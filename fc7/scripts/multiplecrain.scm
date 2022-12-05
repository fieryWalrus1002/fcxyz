(load "init-multiple.scm")
(load "crain-init.scm")

(define position-list (list 100 300 500 700 900))
;doba mezi posuvem
(define timedelay 10000)

(define (multiple-measure exit position)
  (if (null? position) (exit (result 0 "End Measure")))
  (define x (car position))
  (set-page 0)
  (crain-move x)
  (wait-for-next timedelay)
  (simple-measure exit)
  (save-exp (gen-exp-name path (current-time)(+ "Pos_" x "x")))
  (multiple-measure exit (cdr position)))

(define (measure exit)
  (multiple-measure exit position-list))

(start)
