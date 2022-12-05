(load "multiple-init.scm")
(load "plc-init.scm")

(define xy (list '(100 100) '(300 100) '(500 100) '(700 100) '(900 100) '(900 300) '(700 300) '(500 300) '(300 300) '(100 300)))



(define (simple-measure exit)
  (if (empty-protocol? protocol) (exit (result -1 "Protocol is EMPTY")))
  (if (not (compile-protocol protocol)) (exit (result -2 "Compile protocol failed")))
  (if (not (upload-protocol protocol)) (exit (result -3 "Upload protocol failed")))
  (if (not (start-measuring)) (exit (result -4 "Start measuring failed")))
  (define error (wait-for-end-measuring))
  (if (!= error 0) (exit (result -5 "Error in measuring")))
  (result 1 "Ok"))


(define (multiple-measure exit position)
  (if (null? position) (exit (result 0 "End Measure")))
  (define x (car (car position)))
  (define y (car (cdr (car position))))
  (gui-set-page 0)
  (plc-set-xy x y)
  (plc-wait-for-ready)
  (simple-measure exit)
  (if (exist-rgblucam) (begin
    (plc-set-xy x (+ y 18))
    (plc-wait-for-ready)
    (exp-add-image (rgblucam-get-image 20 1) "rgblucam")))
  (save-exp (gen-exp-name path (current-time)(+ "Pos_" x "x" y)))
  (multiple-measure exit (cdr position)))


(start)
