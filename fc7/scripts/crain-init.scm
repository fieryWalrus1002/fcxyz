(define big-endian #t)
(define little-endian #f)

(define (crain-move-to-base) 
  (define buffer (make-buffer))
  (buffer-add-string buffer "PBa")
  (buffer-add-u16 buffer 0 little-endian)
  (fluorcam-send-via-serial buffer))

(define (crain-move x)
  (define buffer (make-buffer))
  (buffer-add-string buffer "PBb")
  (buffer-add-u16 buffer x little-endian)
  (fluorcam-send-via-serial buffer))

