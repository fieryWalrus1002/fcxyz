(define safe-get-id
  (let ((last 111111110))
    (lambda ()
      (define id (rfid-get-id))
      (if(>= id 0) (set! last id) (set! last (+ last 1)))
      last)))