(load "rfid-init.scm")

(define (result code text)
  (cons code text))

(define (simple-measure exit)
  (if (empty-protocol? protocol) (exit (result -1 "Protocol is EMPTY")))
  (if (not (compile-protocol protocol)) (exit (result -2 "Compile protocol failed")))
  (if (not (upload-protocol protocol)) (exit (result -3 "Upload protocol failed")))
  (if (not (start-measuring)) (exit (result -4 "Start measuring failed")))
  (if (!= (wait-for-end-measuring) 0) (exit (result -5 "Error in measuring")))
  (result 1 "Ok"))

;(wait-for-end-measuring) -> -2 .. SYNC_DROP_OUT

(define (create-exp-name . param) 
  (define (iter result param)
    (if (null? param) result
      (iter (+ result (car param))(cdr param))))
  (iter "" param))

(define (analyse-run)
  (set-selection-auto)(sleep 100)
  (background-exclusion)(sleep 100)
  (exp-analyse))  
  
(define (multiple-measure exit)
  (define ready (plc-waitfor-ready))
  (if (not ready) (exit (result 0 "PLC is not ready")))
  (plc-set-measure-busy)
  (simple-measure exit)
  (plc-set-measure-end)
  (if analyse-enabled (analyse-run))
  (save-exp (create-exp-name path "\\" "Exp-"  (safe-get-id) "-" (current-time) ".tar"))
  (multiple-measure exit))

(define (measure exit)(multiple-measure exit))

(define (run exit)
  (set! protocol (current-protocol))
  (if (empty-protocol? protocol) (set! protocol (open-protocol)))
  (if (empty-protocol? protocol) (exit (result -1 "Protocol is EMPTY")))
  (if (not (path-exists path)) (set! path (select-dir)))
  (if (not (string? path)) (exit (result 0 "User cancel")))
  (measure exit))

(define path ())
;(define path "d:\\data\\multi")
(define protocol ())
(define analyse-enabled #t)  

(call/cc run)
;(set! path (select-dir))
;(create-exp-name path "\\" "Exp-"  (safe-get-id) "-" (current-time) ".tar")