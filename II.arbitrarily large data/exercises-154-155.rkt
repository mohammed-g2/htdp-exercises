;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercises-154-155) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct layer [color doll])
;; RD (russian doll) is one of:
;; - String
;; - (make-layer String RD)
;; inerp. a representation of a russian doll
;examples
(define rd0 "red")
(define rd1 (make-layer "green" "red"))
(define rd2 (make-layer "yellow" (make-layer "green" "red")))
(define rd3 (make-layer "black" rd2))
;template
(define (fn-for-rd rd)
  (cond [(string? rd) ...]
        [(layer? rd) (... (layer-color rd) ... (fn-for-rd (layer-doll rd)))]))


; Exercise 154.
; Design the function colors. It consumes a Russian doll and produces a string of
; all colors, separated by a comma and a space

;; colors
;; produces a string of all colors, separated by a comma and a space
;; RD -> String
(check-expect (colors rd0) "red")
(check-expect (colors rd1) "green, red")
(check-expect (colors rd2) "yellow, green, red")
(check-expect (colors rd3) "black, yellow, green, red")
(define (colors rd)
  (cond [(string? rd) rd]
        [(layer? rd) (string-append (layer-color rd) ", " (colors (layer-doll rd)))]))


; Exercise 155.
; Design the function inner, which consumes an RD and produces the (color of the) innermost doll

;; inner
;; produces the (color of the) innermost doll
;; RD -> String
(check-expect (inner rd0) "red")
(check-expect (inner rd1) "red")
(check-expect (inner rd3) "red")
(define (inner rd)
  (cond [(string? rd) rd]
        [(layer? rd) (inner (layer-doll rd))]))
