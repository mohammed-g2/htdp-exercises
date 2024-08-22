;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercises-64-) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 64.
; Design the function manhattan-distance, which measures
; the Manhattan distance of the given posn to the origin.

(define (md-distance posn)
  (+ (posn-x posn) (posn-y posn)))