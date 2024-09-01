;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercises-72-73) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; Exercise 72.
; Formulate a data definition for the above phone structure
; type definition that accommodates the given examples.


(define-struct phone [area number])
;; phone is structure:
;;   (make-phone (Number Number))
;; interp. representation of a phone number
;examples
(define phone1 (make-phone 12 2525))


; then formulate a data definition for phone numbers using
; this structure type definition. Describe the content of
; the three fields as precisely as possible with intervals.

(define-struct phone# [area switch number])
;; phone# is structure:
;;   (make-phone# (Number Number Number))
;; interp. representation of a phone number where:
;; phone-area is an interval, a three digit number between ... and ...
;; phone-switch is an interval, a three digit number between ... and ...
;; phone-number is an interval, a four digit number number between ... and ...
;examples
(define phone#1 (make-phone# 12 85 12356))


; Exercise 73.
; Design the function posn-up-x, which consumes a Posn p
; and a Number n. It produces a Posn like p with n in the x field.

;; Posn Number -> Posn
;; consumes a Posn p and a Number n, produces a Posn with n in the x field
(check-expect (posn-up-x (make-posn 10 20) 30) (make-posn 30 20))
(check-expect (posn-up-x (make-posn -5 8) 8) (make-posn 8 8))
(define (posn-up-x p n)
  (make-posn n (posn-y p)))
