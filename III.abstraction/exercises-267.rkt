;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercises-267) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 267.
; Use map to define the function convert-euro, which converts a list of US$ amounts
; into a list of € amounts based on an exchange rate of US$ 1.06 per €.


;; convert-euro
;; convert a list of US$ amounts into a list of euro€ amounts
;; [List-of amounts] -> [List-of amounts]
(check-expect (convert-euro '()) '())
(check-expect (convert-euro (list 1)) (list (/ 1 1.06)))
(check-expect (convert-euro (list 10 20 15)) (list (/ 10 1.06) (/ 20 1.06) (/ 15 1.06)))
(define (convert-euro loa)
  (local ((define (us->eu a) (/ a 1.06)))
  (map us->eu loa)))

; Finally, try your hand at translate, a function that translates a list of Posns into a
; list of lists of pairs of numbers

;; translate
;; translates a list of Posns into a list of lists of pairs of numbers
;; [List-of Posn] ->[List-of [List-of Number]]
(check-expect (translate '()) '())
(check-expect (translate (list (make-posn 5 8))) (list (list 5 8)))
(check-expect (translate (list (make-posn 9 4) (make-posn 7 1) (make-posn 5 9)))
              (list '(9 4) '(7 1) '(5 9)))
(define (translate lop)
  (local ((define (posn->lst p) (list (posn-x p) (posn-y p))))
    (map posn->lst lop)))
