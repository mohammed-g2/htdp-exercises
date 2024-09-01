;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercises-88-91) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

; Exercise 88.
; Define a structure type that keeps track of the cat’s x-coordinate
; and its happiness. Then formulate a data definition for cats,
; dubbed VCat, including an interpretation.

; Exercise 91.
; Extend your structure type definition and data definition from
; exercise 88 to include a direction field. Adjust your happy-cat
; program so that the cat moves in the specified direction. The
; program should move the cat in the current direction, and it should
; turn the cat around when it reaches either end of the scene

(define-struct vcat [xpos dir h])
;; VCat is (make-vcat Number 1String Number)
;; a cat with it's x position, direction and happiness where:
;; - happiness (h) is a Number between 0 and 1000
;; - direction (dir) is one of: "l" (left), "r" (right)
;examples
(define vcat1 (make-vcat 10 "l" 50))
(define vcat2 (make-vcat 40 "r" 0))
(define vcat3 (make-vcat 5 "r" 100))
;template
(define (fn-for-vcat c)
  (... (vcat-xpos c)
       ... (vcat-h c)))

; Exercise 89.
; Design the happy-cat world program, which manages a walking cat
; and its happiness level. Let’s assume that the cat starts out
; with perfect happiness.

;constants
(define CAT1 .)
(define CAT2 .)
(define SPEED 2)
(define BACKGROUND (empty-scene (* 4 (image-width CAT1)) (+ 10(image-height CAT1))))
(define START-X (/ (image-width CAT1) 2))
(define STRAT-Y (/ (image-height BACKGROUND) 2))

;; VCat -> Image
;; render the current state
(define (render vc)
  (if (odd? (vcat-xpos vc))
      (place-image CAT1 (+ (vcat-xpos vc) START-X) STRAT-Y BACKGROUND)
      (place-image CAT2 (+ (vcat-xpos vc) START-X) STRAT-Y BACKGROUND)))

;; VCat -> VCat
;; update the current state (the cat moves 1 px/tick) and happiness -1 point/tick
;; when cat reaches the edges flip the direction
(define (tock vc)
  (cond [(equal? (vcat-dir vc) "l") (if (< (vcat-xpos vc) 0)
                                        (make-vcat (vcat-xpos vc) "r" (- (vcat-h vc) 1))
                                        (make-vcat (- (vcat-xpos vc) 1) "l" (- (vcat-h vc) 1)))]
        [(equal? (vcat-dir vc) "r") (if (> (vcat-xpos vc) (image-width BACKGROUND))
                                        (make-vcat (vcat-xpos vc) "l" (- (vcat-h vc) 1))
                                        (make-vcat (+ (vcat-xpos vc) 1) "r" (- (vcat-h vc) 1)))]))

;; VCat -> Boolean
;; stop the program if happiness reached 0
(define (end? vc)
  (if (<= (vcat-h vc) 0)
      #true
      #false))


;;VCat -> VCat
;; initialize the world
(define (main vc)
  (big-bang vc
    [to-draw render]
    [on-tick tock]
    [stop-when end?]))

;(main (make-vcat 0 "r" 1000))