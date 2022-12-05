(load "date-time.scm")
(load "plc-init.scm")
(load "scheduler.scm")

(define protocol (current-protocol))
(define path "d:\\data\\multi\\")

(define xy (list '(0 0 250) '(350 0 250) '(700 0 250)'(1050 0 250)  '(1050 350 200) '(700 350 200) '(350 350 200) '(0 350 200)))        

(define (action-a) (multiple-measure xy protocol))
(define (action-b) (multiple-measure xy protocol))

(define sh (list (define-action "9:20" action-a)
                 (define-action "15:09" action-b)
                 (define-action "17:58" action-a)))


(define (simple-measure protocol)
  (if (empty-protocol? protocol) (throw -1 "Protocol is EMPTY"))
  (if (not (compile-protocol protocol)) (throw -2 "Compile protocol failed"))
  (if (not (upload-protocol protocol)) (throw -3 "Upload protocol failed"))
  (if (not (start-measuring)) (throw -4 "Start measuring failed"))
  (if (!= (wait-for-end-measuring) 0) (throw -5 "Error in measuring"))
  ok)

(define (create-exp-name . param) 
  (define (iter result param)
    (if (null? param) result
      (iter (+ result (car param))(cdr param))))
  (iter "" param))

(define (char-alpha? ch)
    (or (and (>= ch #\A) (<= ch #\Z))(and (>= ch #\a)(<= ch #\z))))

(define (correct-name str) 
  (define count (string-length str))
  (define (iter n)
    (if (>= n count) str
      (begin
        (define ch (string-ref str n))
        (if (not (or (char-numeric? ch) (char-alpha? ch))) (string-set! str n #\-))
        (iter (+ n 1))))) 
  (iter 0))

(define (datetime) (correct-name (datetime->string (current-datetime))))


;(define (plc-set-xyz x y z)(display (format "plc-set-xyz x:~a y:~a z:~a" x y z)))
;(define (plc-wait-for-ready) (display "plc-wait-for-ready"))

(define (multiple-measure position protocol)
  (if (null? position)
    #t
    (begin
      (define x (car (car position)))
      (define y (car (cdr (car position))))
      (define z (car (cdr (cdr (car position)))))
      (gui-set-page 0)
      (plc-set-xyz x y z)
      (plc-wait-for-ready)
      (simple-measure protocol)
      (if (exist-rgblucam) 
        (begin
          (plc-set-xy x (+ y 18))
          (plc-wait-for-ready)
          (sleep 1000)
          (exp-add-image (rgblucam-get-image 20 1) "rgblucam")))
     (save-exp (create-exp-name path (datetime) (+ "-Pos-" x "x" y)))
     (multiple-measure (cdr position) protocol))))

(define (check)
  (if (empty-protocol? protocol) (set! protocol (open-protocol)))
  (if (empty-protocol? protocol) (throw -1 "Protocol is EMPTY"))
  (if (not (path-exists? path)) (set! path (select-dir)))
  (if (not (string? path)) (throw -1 "Path is EMPTY")))
  
(define (start)
  (check)
  (scheduler-start sh))

(try/cc start)
;(correct-name "12/24/2012 10:20 pm")















