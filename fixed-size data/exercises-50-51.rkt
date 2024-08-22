;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercises-50-51) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; TrafficLight (tf) is one of the following Strings:
;; - green
;; - yellow
;; - red
;; interp. the colors of a traffic light

; Exercise 50.
; Add enough tests

;; tf -> tf
;; yields the next state given current state s
(check-expect (next-light  "green") "yellow")
(check-expect (next-light "yellow")    "red")
(check-expect (next-light    "red")  "green")
(define (next-light s)
  (cond [(string=? s  "green") "yellow"]
        [(string=? s "yellow")    "red"]
        [(string=? s    "red")  "green"]))

; Exercise 51.
; Design a big-bang program that simulates a traffic light for
; a given duration. The program renders the state of a traffic
; light as a solid circle of the appropriate color, and it
; changes state on every clock tick.

(define BACKGROUND (empty-scene 100 100))

;; render
;; tf -> Image
;; render the current traffic light
(define (render tf)
  (place-image (circle 20 "solid" tf) 50 50 BACKGROUND))


;; tock
;; tf -> tf
;; update the current traffic light once every clock tick
(define (tock tf)
  (next-light tf))


;; main
;; tf -> tf
;; initialize the program
(define (main tf)
  (big-bang tf
    [to-draw render]
    [on-tick tock]))
