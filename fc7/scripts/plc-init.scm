;(plc-read-word addr)
;(plc-write-word addr value)
;(plc-read-bit addr bit)
;(plc-write-bit addr bit value)
;(plc-wait-for-bit addr bit timeout)

(define (plc-is-measure-ready) (plc-read-bit 4000 0))
(define (plc-set-measure-busy) (plc-write-bit 4000 1 #t))
(define (plc-set-measure-end) (plc-write-bit 4000 2 #t))
(define (plc-is-manual-control) (plc-read-bit 4000 4))
(define (plc-reset-measure) (plc-write-bit 4000 5 #t))
(define (plc-move-in-progress) (plc-read-bit 4000 6))
(define (plc-stop-move) (plc-write-bit 4000 7 #t))
;cekam na bit 4000.0   timeout  = 60s
(define (plc-wait-for-ready) (plc-wait-for-bit 4000 0 60))

(define (plc-set-x x) (plc-write-word 4010 x))
(define (plc-set-y y) (plc-write-word 4011 y))
(define (plc-set-z z) (plc-write-word 4012 z))
(define (plc-set-xy x y) (begin (plc-set-x x)(plc-set-y y)))
(define (plc-set-xyz x y z) (begin (plc-set-x x)(plc-set-y y)(plc-set-z z)))

(define (plc-get-x)(plc-read-word 4020))
(define (plc-get-y)(plc-read-word 4021))
(define (plc-get-z)(plc-read-word 4022))

(define (plc-id)(plc-read-word 4802))
