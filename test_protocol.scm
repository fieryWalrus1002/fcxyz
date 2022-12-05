(load "date-time.scm")
(load "plc-init.scm")
(load "scheduler.scm")

;///// INSTRUCTIONS FOR MODIFYING THIS SCRIPT
; Start this protocol between 08:00 and 16:59. The scheduler will execute the light-adapted protocols, then during the early morning, it will execute the dark
; adapted protocols. The data will then be ready in the directory specified below.

;///// DEFINE YOUR DESTINATION PATH
; Dump the data files into this directory. They can be moved at a later time.
(define path "c:\\data\120322_brandon_tobacco\\")

;///// DEFINE YOUR PROTOCOLS
;;(define protocol-current (current-protocol)) ;; use current protocol
;(define arab1-dark (protocol-load "C:\\protocols\\033022_brandon_tobacco.p")) ;;load morning protocol from file
(define dark-protocol (protocol-load "C:\\protocols\\wizardmod.p")) ;;load morning protocol from file
(define light-protocol (protocol-load "C:\\protocols\\test_protocol.p")) ;;load morning protocol from file

;///// TURN ON AUTOMATIC ANALYSIS
; You can change what selection file (*.sel) your automatic analysis will use in this section of code. 
; Create the area in masks.xml, then load it in Pre-Processing. Save as a *.sel file into the C:\selfiles directory.
(define analyse-enabled #t)

(define(analyse-run)
 (set-selection-manual)(sleep 100)
 (shapes-load "C:\\selfiles\\fullscreen.xsel") ;the arabidopsis selection fie I wish to use
 (background-exclusion)(sleep 100)
 (exp-analyse))
;///// DEFINE YOUR XY POSITIONS
; Below are listed two different sets of coordinates. They are referenced in the DEFINE ACTIONS section.

;these are the coordinates
;(define pos1_xy (list '(200 1000 200)))
;(define pos_xy (list '(2105 579 0) '(1418 669 0) '(701 664 0) '(689 1770 0) '(1406 1838 0) '(2156 1820 0) '(0 0 0)))
(define pos_xy (list 
'(716 1355 0)
'(1268 1243 0)
'(710 2054 0)
'(1247 2065 0)
'(348 2785 0)
'(897 2815 0)
'(1413 2815 0)
'(1882 2828 0)
'(0 0 0)))

;///// DEFINE ACTIONS TO BE TAKEN
(define (action-dark) (multiple-measure pos_xy dark-protocol analyse-run path))
(define (action-light) (multiple-measure pos_xy light-protocol analyse-run path))
;;;;;;;;;;;;;;;;;;;;;;;;;;;(multiple-measure position protocol analyse path)
;;;; action waiting to midnight
(define (action-wait)(wait/progress "Time to next day: " 10))
(define (next-day) (define-action "23:59:55" action-wait))
(define (wait sec)(wait/progress "Wait: " sec))
;;relax time beetwen attemps in [sec]
(define relax-time 60)
(define number-attempts 5)


;///// DEFINE ACTION START TIMES
(define sh0 (list 
(define-action "9:00" action-light)
(next-day)
(define-action "00:01" action-dark)
(define-action "9:00" action-light)
))
                 

;///// END OF STUFF YOU NEED TO CHANGE, BEGINNING OF CRAP YOU SHOULD NOT CHANGE

(define (simple-measure protocol)
  (set-protocol protocol)
  (if (empty-protocol? protocol) (throw -1 "Protocol is EMPTY"))
  (if (not (compile-protocol protocol)) (throw -2 "Compile protocol failed"))
  (if (not (upload-protocol protocol)) (throw -3 "Upload protocol failed"))
  (if (not (start-measuring)) (throw -4 "Start measuring failed"))
  ;(if (!= (wait-for-end-measuring) 0) (throw -5 "Error in measuring"))
  ;ok)
  (wait-for-end-measuring))

(define (create-exp-name . param) 
  (define (iter result param)
    (if (null? param) result
      (iter (+ result (car param))(cdr param))))
  (iter "" param))

(define (char-alpha? ch)
    (or (and (>= ch #\A) (<= ch #\Z))(and (>= ch #\a)(<= ch #\z))))

(define (correct-name str) 
  (define count (string-length str))
  (define (iter n)
    (if (>= n count) str
      (begin
        (define ch (string-ref str n))
        (if (not (or (char-numeric? ch) (char-alpha? ch))) (string-set! str n #\-))
        (iter (+ n 1))))) 
  (iter 0))

(define (datetime) (correct-name (datetime->string (current-datetime))))


;(define (plc-set-xyz x y z)(display (format "plc-set-xyz x:~a y:~a z:~a" x y z)))
;(define (plc-wait-for-ready) (display "plc-wait-for-ready"))

(define (simple-measure-with protocol n)
    (let ((ok #t)(status 0)(rep (- n 1)))
        (if (< rep 0) (throw -5 "Error in measuring"))
        (set! status (simple-measure protocol))
        (if (= status -1) (throw -1 "User terminated"))
        (if (= status -2) 
            (begin
                (set! ok #f)
                (wait relax-time)
                (simple-measure-with protocol rep)))
        ok))

(define (multiple-measure position protocol analyse path)
  (if (null? position)
    #t
    (begin
      (define x (car (car position)))
      (define y (car (cdr (car position))))
      (define z (car (cdr (cdr (car position)))))
      (gui-set-page 0)
      (plc-set-xyz x y z)
      (plc-wait-for-ready)
      ;(simple-measure protocol)
      (define ok (simple-measure-with protocol number-attempts))
      (if analyse-enabled(analyse))
      (if (exist-rgblucam) 
        (begin
          (plc-set-xy x (+ y 180))
          (plc-wait-for-ready)
          (sleep 2000)
          (exp-add-image (rgblucam-get-image 5 1) "rgblucam")))
     (if ok 
        (save-exp (create-exp-name path "Exp_" (datetime) (+ "_Pos_" x "x" y ".tar")))
        (save-exp (create-exp-name path "Exp_bad" (datetime) (+ "_Pos_" x "x" y ".tar"))))
     (wait 1200) 
     (multiple-measure (cdr position) protocol analyse path))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;



(define (check protocol path)
  (if (empty-protocol? protocol) (set! protocol (open-protocol)))
  (if (empty-protocol? protocol) (throw -1 "Protocol is EMPTY"))
  (if (not (path-exists? path)) (set! path (select-dir)))
  (if (not (string? path)) (throw -1 "Path is EMPTY")))
  

(define (start)
  (check dark-protocol path)
  (check light-protocol path)
  (scheduler-start sh0) ;; sheduler for actual day
 
)

(try/cc start)














