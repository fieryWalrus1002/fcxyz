(define (result code text)
  (cons code text))

(define (simple-measure exit)
  (if (empty-protocol? protocol) (exit (result -1 "Protocol is EMPTY")))
  (if (not (compile-protocol protocol)) (exit (result -2 "Compile protocol failed")))
  (if (not (upload-protocol protocol)) (exit (result -3 "Upload protocol failed")))
  (if (not (start-measuring)) (exit (result -4 "Start measuring failed")))
  (if (!= (wait-for-end-measuring) 0) (exit (result -5 "Error in measuring")))
  (result 1 "Ok"))

(define (analyse-run)
  (set-selection-auto)(sleep 100)
  (background-exclusion)(sleep 100)
  (exp-analyse))
  
(define (analyse-run2)
  (set-selection-manual)(sleep 100)
  (shapes-load "C:\\user-plate.sel")
  (background-exclusion)(sleep 100)
  (exp-analyse))

(define (create-exp-name . param) 
  (define (iter result param)
    (if (null? param) result
      (iter (+ result (car param))(cdr param))))
  (iter "" param))

(define (measure exit)
  (begin 
    (simple-measure exit)
    (if analyse-enabled (analyse-run))
    (save-exp  (create-exp-name path "Exp-" (plant-get-id) "-" (current-time) ".tar"))
    (result 1 "Ok")))

(define (run exit)
  (set! protocol (current-protocol))
  (if (empty-protocol? protocol) (exit (result -1 "Protocol is EMPTY")))
  (if (not (path-exists? path)) (exit (result -6 "Path is wrong")))
  (measure exit))

(define analyse-enabled #f)  
(define path "C:\\FCdata\\")
(define protocol ())

(call/cc run)

