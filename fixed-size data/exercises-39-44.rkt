;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercises-39-44) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

; Exercise 39.
; Develop an image of an automobile so that WHEEL-RADIUS remains the
; single point of control.

; Exercise 40.
; Formulate the examples as BSL tests, that is, using the check-expect
; form.

; Exercise 41.
; Finish the sample problem and get the program to run. define the
; constants BACKGROUND and Y-CAR, Also add a clause to the big-bang
; expression that stops the animation when the car has disappeared on
; the right side

(define TREE
  (underlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 20 "solid" "brown")))
(define BACKGROUND (empty-scene 200 40))
(define WHEEL-RADIUS 5)
(define CAR
  (overlay/offset
   (rectangle (* WHEEL-RADIUS 4) (* WHEEL-RADIUS 2) "solid" "red")
   0 (* WHEEL-RADIUS 2)
   (overlay/offset
    (rectangle (* WHEEL-RADIUS 8) (* WHEEL-RADIUS 2) "solid" "red")
    (/ WHEEL-RADIUS 4) WHEEL-RADIUS
    (overlay/offset
     (circle WHEEL-RADIUS "solid" "black")
     (* 4 (- WHEEL-RADIUS)) 0
     (circle WHEEL-RADIUS "solid" "black")))))
(define CAR-Y (- (image-height BACKGROUND) (/ (image-height CAR) 2)))

;; WorldState is a Number
;; Interp. the number of pixels between the left border of
;; the scene and the car

;; cw -> Image
;; render image of the current state
(define (render cw)
  (place-image CAR cw CAR-Y (place-image TREE 20 CAR-Y BACKGROUND)))


;; cw -> cw
;; obtain the next world state on clock tick
(check-expect (tock 10) 13)
(check-expect (tock 78) 81)
(define (tock cw)
  (+ cw 3))


;; cw String -> cw
;; obtain the next state on key event
(define (key-handler cw) ...)


; Exercise 44.
; Formulate the examples as BSL tests. Click RUN and watch them fail.

;; cw Number Number String -> cw
;; WorldState x-postion y-position event-description -> WorldState
; places the car at x-mouse
; if the given me is "button-down" 
; given: 21 10 20 "enter"
; wanted: 21
; given: 42 10 20 "button-down"
; wanted: 10
; given: 42 10 20 "move"
; wanted: 42
(check-expect (mouse-handler 21 10 20 "enter") 21)
(check-expect (mouse-handler 42 10 20 "button-down") 10)
(check-expect (mouse-handler 42 10 20 "move") 42)
(define (mouse-handler cw x y me)
  (if (string=? me "button-down")
      x
      cw))


;; cw -> Boolean
;; evaluatied after each event, check for program end
(check-expect (end? 0) #false)
(check-expect (end? (image-width BACKGROUND)) #false)
(check-expect (end? (+ (image-width BACKGROUND) (/ (image-width CAR) 2))) #false)
(check-expect (end? (+ (image-width BACKGROUND) (/ (image-width CAR) 2) 1)) #true)
(define (end? cw)
  (if (> cw (+ (image-width BACKGROUND) (/ (image-width CAR) 2)))
      #true
      #false))


;; cw -> cw
;; launch the program from the initial state
(define (main ws)
  (big-bang ws
    [on-tick tock]
    [to-draw render]
    [on-mouse mouse-handler]
    [stop-when end?]))


; Exercise 42.
; Modify the interpretation of the sample data definition so that a
; state denotes the x-coordinate of the right-most edge of the car

;; wc is a Number
;; Interp. the x-coordinate of the right-most edge of the car

;; Number -> Image
;; render the current state of the world
(define (render.v2 cw)
  (place-image CAR (+ cw (/ (image-width CAR) 2)) CAR-Y BACKGROUND))


; Exercise 43.
; Let’s work through the same problem statement with a time-based
; data definition

; wc is a Number
; Interp. the number of clock ticks since the animation started

;; Number -> Number
;; update the current state of the world on clock tick
(define (tock.v2 cw)
  (+ cw 1))


(define (main.v2 ws)
  (big-bang ws
    [on-tick tock.v2]
    [to-draw render.v2]
    [stop-when end?]))
