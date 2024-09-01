;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |exercises 47|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

; Exercise 47.
; Design a world program that maintains and displays a “happiness gauge.”
; Let’s call it gauge-prog, and let’s agree that happiness is a number
; between 0 and 100 (inclusive).
; The gauge-prog program consumes the current level of happiness. With
; each clock tick, the happiness level decreases by 0.1; it never falls
; below 0 though. Every time the down arrow key is pressed, happiness
; decreases by 1/5; every time the up arrow is pressed, happiness jumps
; by 1/3.

(define BACKGROUND (empty-scene 100 100))
(define CONTAINER (rectangle 20 80 "outline" "black"))
;; hg is a Number
;; the happines guage, an number between 0 and 100


;; render
;; Number -> Image
;; render the current level of happiness
(define (render hg)
  (place-image
   (frame (rectangle 20 hg "solid" "red")) 50 50 BACKGROUND))


;; tock
;; Number -> Number
;; update the current happiness level on clock tick
;; decrease happiness by 0.1/s
(define (tock hg)
  (if (<= hg 0)
      hg
      (- hg 0.1)))


;; decrease-by-fifth
;; Number -> Number
;; decrease given number by fifth
(check-expect (decrease-by-fifth 50) 40)
(check-expect (decrease-by-fifth 23) 18.4)
(define (decrease-by-fifth n)
  (- (- (/ (* 20 n) 100) n)))

;; increase-by-third
;; Number -> Number
;; increase given number by third
(check-expect (increase-by-third 50) 66.5)
(check-expect (increase-by-third 28) 37.24)
(define (increase-by-third n)
  (+ n (/ (* 33 n) 100)))


;; key-handler
;; Number Key -> Number
;; update the current happiness level on key event
;; when down arrow key is pressed happiness reduced by 1/5
;; when up arrow key is pressed happines jumps by 1/3
(define (key-handler hg key)
  (cond [(and (string=? key "down") (> hg 1)) (decrease-by-fifth hg)]
        [(and (string=? key "up") (< hg 80)) (increase-by-third hg)]
        [else hg]))


;; main
;; Number -> Number
;; initialize the program
(define (main hg)
  (big-bang hg
    [to-draw render]
    [on-tick tock]
    [on-key key-handler]))