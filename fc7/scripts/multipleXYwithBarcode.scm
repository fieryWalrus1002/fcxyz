(load "init-multiple.scm")

(define xy (list '(100 100) '(300 100) '(500 100) '(700 100) '(900 100) '(900 300) '(700 300) '(500 300) '(300 300) '(100 300)))
(define timedelay 5000)
(define barcode ())

(define (barcode-read exit)
  (set! barcode (read-barcode))
  (if (not (string? barcode)) (exit (result 0 "End Measure"))))  


(define (multiple-measure exit position)
  (if (null? position) (exit (result 0 "End Measure")))
  (define x (car (car position)))
  (define y (car (cdr (car position))))
  (set-page 0)
  (xy-move x y)
  (define stime (tick-count))
  (barcode-read exit)
  (set! stime (- (tick-count) stime))
  (wait-for-next (- timedelay stime))
  (simple-measure exit)
  (save-exp (gen-exp-name path (current-time)(+ "Pos_" x "x" y " barcode_" barcode)))
  (multiple-measure exit (cdr position)))


(start)
