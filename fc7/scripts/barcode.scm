(define (result code text)
  (cons code text))

(define (simple-measure exit)
  (if (empty-protocol? protocol) (exit (result -1 "Protocol is EMPTY")))
  (if (not (compile-protocol protocol)) (exit (result -2 "Compile protocol failed")))
  (if (not (upload-protocol protocol)) (exit (result -3 "Upload protocol failed")))
  (if (not (start-measuring)) (exit (result -4 "Start measuring failed")))
  (if (!= (wait-for-end-measuring) 0) (exit (result -5 "Error in measuring")))
  (result 1 "Ok"))

(define (multiple-measure exit)
  (set! barcode (read-barcode))
  (if (not (string? barcode)) (exit (result 0 "End Measure")))
  (simple-measure exit)
  (save-exp (gen-exp-name path (current-time) barcode))
  (multiple-measure exit))

(define (measure exit)(multiple-measure exit))
; mesurema spustit cekani na barcode pak spusti mereni a tak stale dokola dokud zadavam bar code 

(define (run exit)
  (set! protocol (current-protocol))
  (if (empty-protocol? protocol) (set! protocol (open-protocol)))
  (if (empty-protocol? protocol) (exit (result -1 "Protocol is EMPTY")))
  (set! path (select-dir))
  (if (not (string? path)) (exit (result 0 "User cancel")))
  (measure exit))

(define path ())
(define protocol ())
(define barcode ())

(call/cc run)