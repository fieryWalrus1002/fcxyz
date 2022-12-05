(define (result code text)
  (cons code text))

(define (simple-measure exit)
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


(define (multiple-measure exit position)
  (if (null? position) (exit (result 0 "End Measure")))
  (define x (car (car position)))
  (define y (car (cdr (car position))))
  (set-page 0)
  (xy-move x y)
  (wait-for-next timedelay)
  (simple-measure exit)
  (save-exp (gen-exp-name path (current-time)(+ "Pos_" x "x" y)))
  (multiple-measure exit (cdr position)))

(define (measure exit)(multiple-measure exit xy))
; mesurema spustit cekani na barcode pak spusti mereni a tak stale dokola dokud zadavam bar code 

(define (run exit)
  (set! protocol (current-protocol))
  (if (empty-protocol? protocol) (set! protocol (open-protocol)))
  (if (empty-protocol? protocol) (exit (result -1 "Protocol is EMPTY")))
  (set! path (select-dir))
  (if (not (string? path)) (exit (result 0 "User cancel")))
  (measure exit))
  
(define (start)
  (call/cc run))
  
(define path ())
(define protocol ())
