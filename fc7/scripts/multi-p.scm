(define (cadr p) (car (cdr p)))

(define (result code text)
  (cons code text))

(define (simple-measure exit protocol)
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

(define (measure exit protocol repeat-count repeat-delay)
	(set-protocol protocol)  ;kvuli uzlozeni pri ukladani bere current
	(multiple-measure exit protocol repeat-count repeat-delay))

(define (multiple-measure exit protocol n repeat-delay)
  (if (= n 0) (result 1 "Ok")
    (begin 
      (simple-measure exit protocol)
      (save-exp (gen-exp-name path (current-time)))  
      (set! n (- n 1))
      (if (= n 0) (result 1 "Ok")
        (begin
          (wait-for-next (* repeat-delay 1000))
          (multiple-measure exit protocol n repeat-delay)
           )))))
		   
(define (run exit)
  (set! protocol-a (open-protocol))
;  (set! protocol-a (protocol-load " c:\\bbleble.p"))
  (set! protocol-b (open-protocol))
  (if (empty-protocol? protocol-a) (exit (result -1 "Protocol-a is EMPTY")))
  (if (empty-protocol? protocol-b) (exit (result -1 "Protocol-b is EMPTY")))
  (set! path (select-dir))
  (if (not (string? path)) (exit (result 0 "User cancel")))
  (set! param (ask-repeat-param))
  (if (not (list? param)) (exit (result 0 "User cancel")))
  (set! repeat-count-a (car param))
  (set! repeat-delay-a (cadr param))
  (set! param (ask-repeat-param))  
  (set! repeat-count-b (car param))
  (set! repeat-delay-b (cadr param))
  (define (loop n exit)
    (if (= n 0) (result 1 "Ok")
      (begin
        (measure exit protocol-a repeat-count-a repeat-delay-a)
        (wait-for-next (* repeat-delay-b 1000))
        (measure exit protocol-b repeat-count-b repeat-delay-b)
        (set! n ( - n 1))
        (if (= n 0) (result 1 "Ok")
          (begin
            (wait-for-next (* repeat-delay-a 1000))
            (loop n exit))))))
    (loop repeat-all exit))			

(define repeat-count-a 1)
(define repeat-delay-a 0)
(define repeat-count-b 1)
(define repeat-delay-b 0)

(define param ())
(define path ())
(define protocol-a ())
(define protocol-b ())
(define repeat-all 3) ;celkovy pocet opakovani

(call/cc run)