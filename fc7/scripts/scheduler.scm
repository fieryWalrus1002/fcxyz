(define (define-action time p) (list (string->time time) p))

(define null ())
           
(define (for-each p lst)
  (if (null? lst)
      null
      (begin
        (p (car lst))
        (for-each p (cdr lst)))))

       
(define (execute a)
  (let ((time (seconds-between (car a) (current-time)))(act (car (cdr a))))
    (wait/progress "Time to next action: " time)
    (act)))
        
        
(define (scheduler-start lst)
  (let ((t0 (current-time)))
  (for-each
    (lambda (act)
      (if (> (car act) t0)
        (execute act)))
        lst)))

        
(define cont-stack ())

(define (push-cont arg) (set! cont-stack (cons arg cont-stack)))
(define (pop-cont) (set! cont-stack (cdr cont-stack)))
(define (throw code text) ((car cont-stack) (cons code text)))

(define (try/cc proc . arg)
  (define result (call/cc (lambda (exit) (push-cont exit) (apply proc arg)))) 
  (pop-cont)
   result)      

(define ok (cons 1 "Ok"))   

(define (gui-set-page page) (set-page page))