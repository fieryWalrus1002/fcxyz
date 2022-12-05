(load "date-time.scm")
(load "plc-init.scm")
(load "scheduler.scm")


(define protocol-a (current-protocol))
(define path "d:\\data\\multi\\")

(define (set-light-actinic1 percent)
    (set-property "fluorcam.actinic" percent)
    (set-property "fluorcam.actinic_on" #t))

(define (set-light-actinic2 percent)
    (set-property "fluorcam.unknown.track0" percent)
    (set-property "fluorcam.unknown.switch0" #t))

(define (set-light-far percent)
    (set-property "fluorcam.unknown.track1" percent)
    (set-property "fluorcam.unknown.switch1" #t))

(define (action-measuring)
    (lambda () (exp-measure protocol-a)))

(define (action-light-off) 
    (lambda ()
        (set-light-actinic1 0)
        (set-light-actinic2 0)
        (set-light-far 0)))

(define (action-set-light light percent)
   (if (= light "act1") (lambda () (set-light-actinic1 percent))
   (if (= light "act2") (lambda () (set-light-actinic2 percent))
   (if (= light "far") (lambda () (set-light-far percent))
   (lambda() (display "invalid name for light" light))))))

(define (action-wait)(wait/progress "Time to next day: " 10))
(define (next-day) (define-action "23:59:55" action-wait))

(define sh (list (define-action "6:20" (action-set-light "act1" 80))
                 (define-action "8:00" (action-measuring))
                 (define-action "12:52" (action-set-light "act1" 30))
                 (define-action "19:00" (action-light-off))
                 (next-day)
                 (define-action "4:00" (action-measuring))))

(define (simple-measure protocol)
  (set-protocol protocol)
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

(define (exp-measure protocol)
    (gui-set-page 0)
    (simple-measure protocol)
    (save-exp (create-exp-name path (datetime))))


(define (check protocol)
  (if (empty-protocol? protocol) (set! protocol (open-protocol)))
  (if (empty-protocol? protocol) (throw -1 "Protocol is EMPTY"))
  (if (not (path-exists? path)) (set! path (select-dir)))
  (if (not (string? path)) (throw -1 "Path is EMPTY")))
  
(define (start)
  (check protocol-a)
  (scheduler-start sh))

(try/cc start)







