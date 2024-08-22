;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercises-45-46) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

; Exercise 45.
; Design a “virtual cat” world program that continuously moves the cat
; from left to right. Let’s call it cat-prog and let’s assume it consumes
; the starting position of the cat. Furthermore, make the cat move three
; pixels per clock tick. Whenever the cat disappears on the right, it
; reappears on the left.

; Exercise 46.
; Improve the cat animation with a slightly different image
; Adjust the rendering function from exercise 45 so that it uses one cat
; image or the other based on whether the x-coordinate is odd.


(define CAT1 .)
(define CAT2 .)
(define SPEED 2)
(define BACKGROUND (empty-scene (* 4 (image-width CAT1)) (+ 10(image-height CAT1))))
(define START-X (/ (image-width CAT1) 2))
(define STRAT-Y (/ (image-height BACKGROUND) 2))

;; sp is a Numner
;; interp. the starting position of the cat

;; Number -> Image
;; render the current state
(define (render sp)
  (if (odd? sp)
      (place-image CAT1 (+ sp START-X) STRAT-Y BACKGROUND)
      (place-image CAT2 (+ sp START-X) STRAT-Y BACKGROUND)))


;; Number -> Number
;; update the current state (the cat moves per SPEED) on clock tick
(define (tock sp)
  (if (> sp (image-width BACKGROUND))
      (- (image-width CAT1))
      (+ sp SPEED)))



;; Number -> Number
;; initialize the world
(define (main sp)
  (big-bang sp
    [to-draw render]
    [on-tick tock]))
