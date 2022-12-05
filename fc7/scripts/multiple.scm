(define (cadr p) (car (cdr p)))

(define (result code text)
  (cons code text))

(define (simple-measure exit)
  (if (empty-protocol? protocol) (exit (result -1 "Protocol is EMPTY")))
  (if (not (compile-protocol protocol)) (exit (result -2 "Compile protocol failed")))
  (if (not (upload-protocol protocol)) (exit (result -3 "Upload protocol failed")))
  (if (not (start-measuring)) (exit (result -4 "Start measuring failed")))
  (if (!= (wait-for-end-measuring) 0) (exit (result -5 "Error in measuring")))
  (result 1 "Ok"))

(define (wait-for-next time)
  (define step (/ time 100)) ;progres je volan behem sekundy 10 krat
  (define (loop t)
    (if (> t 0)
      (begin
        (sleep step)
        (set! t (- t step))
        (wait-progress (* (- 1 (/ t time)) 100) t)
        (if (< t 5000) (set-page 0)) ;nastavim stranku live 5s pred vyprsenim casu
        (loop t))))
  (wait-start)
  (loop time)	
  (wait-end))

(define (measure exit)(multiple-measure exit repeat_count))

(define (analyse-run)
  (set-selection-auto)(sleep 100)
  (background-exclusion)(sleep 100)
  (exp-analyse))

(define (multiple-measure exit n)
  (if (= n 0) (result 1 "Ok")
    (begin 
      (simple-measure exit)
      (if analyse-enabled (analyse-run))
      (if (exist-rgblucam) (exp-add-image (rgblucam-get-image 20 1) "rgblucam"))
      (save-exp (gen-exp-name path (current-time)))  
      (set! n (- n 1))
      (if (= n 0) (result 1 "Ok")
        (begin
          (wait-for-next (* repeat_delay 1000))
          (multiple-measure exit n)
           )))))

(define (run exit)
  (set! protocol (current-protocol))
  (if (empty-protocol? protocol) (set! protocol (open-protocol)))
  (if (empty-protocol? protocol) (exit (result -1 "Protocol is EMPTY")))
  (if (not (path-exists? path)) (set! path (select-dir)))
  (if (not (string? path)) (exit (result 0 "User cancel")))
  (set! param (ask-repeat-param))
  (if (not (list? param)) (exit (result 0 "User cancel")))
  (set! repeat_count (car param))
  (set! repeat_delay (cadr param))
  (measure exit))

(define analyse-enabled #f)  
(define repeat_count 1)
(define repeat_delay 0)
(define param ())
(define path ())
;(define path "d:\\data\\multi")
(define protocol ())
;(define protocol (protocol-load "d:\\data\\multi\\fvfm.p"))

(call/cc run)
