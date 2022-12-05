(define (safe-get-id)
   (define id (rfid-get-id))
   (if (< id 0) "none" id))
(safe-get-id)
