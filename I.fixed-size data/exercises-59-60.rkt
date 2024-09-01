;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercises-59-60) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

; Exercise 59.
; Finish the design of a world program that simulates the
; traffic light FSA.

;; TL -> Image
;; render the current traffic light
(check-expect (tl-render "red")
              (beside (circle 10 "solid" "red")
                      (circle 10 "outline" "yellow")
                      (circle 10 "outline" "green")))
(check-expect (tl-render "yellow")
              (beside (circle 10 "outline" "red")
                      (circle 10 "solid" "yellow")
                      (circle 10 "outline" "green")))
(check-expect (tl-render "green")
              (beside (circle 10 "outline" "red")
                      (circle 10 "outline" "yellow")
                      (circle 10 "solid" "green")))
(define (tl-render tl)
  (cond [(string=? tl "red") (beside (circle 10 "solid" "red")
                                     (circle 10 "outline" "yellow")
                                     (circle 10 "outline" "green"))]
        [(string=? tl "yellow") (beside (circle 10 "outline" "red")
                                       (circle 10 "solid" "yellow")
                                       (circle 10 "outline" "green"))]
        [(string=? tl "green") (beside (circle 10 "outline" "red")
                                       (circle 10 "outline" "yellow")
                                       (circle 10 "solid" "green"))]))


;; TL -> TL
;; get the next traffic light state
(check-expect (tl-next "red") "yellow")
(check-expect (tl-next "yellow") "green")
(check-expect (tl-next "green") "red")
(define (tl-next tl)
  (cond [(string=? tl "red") "yellow"]
        [(string=? tl "yellow") "green"]
        [(string=? tl "green") "red"]))


; TrafficLight -> TrafficLight
; simulates a clock-based American traffic light
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick tl-next 1]))


; Exercise 60. An alternative data representation for a traffic
; light program may use numbers instead of strings, Reformulate
; tl-next’s tests for tl-next-numeric

; An N-TrafficLight is one of:
; – 0 interpretation the traffic light shows red
; – 1 interpretation the traffic light shows green
; – 2 interpretation the traffic light shows yellow

(check-expect (tl-next-numirc 0) 1)
(check-expect (tl-next-numirc 1) 2)
(check-expect (tl-next-numirc 2) 0)
(define (tl-next-numirc tl) (modulo (+ tl 1) 3))