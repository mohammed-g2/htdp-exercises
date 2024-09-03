;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercises-250-251) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Number -> [List-of Number]
; tabulates sin between n and 0 (incl.) in a list
(define (tab-sin n)
  (cond
    [(= n 0) (list (sin 0))]
    [else (cons (sin n) (tab-sin (sub1 n)))]))
	
; Number -> [List-of Number]
; tabulates sqrt between n and 0 (incl.) in a list
(define (tab-sqrt n)
  (cond
    [(= n 0) (list (sqrt 0))]
    [else (cons (sqrt n) (tab-sqrt (sub1 n)))]))

; Exercise 250.
; Design tabulate, which is the abstraction of the two functions in figure 92.
; When tabulate is properly designed, use it to define a tabulation function
; for sqr and tan.

;; tabulate
;; tabluate fn bewteen n and 0
;; [Number -> Number] Number -> List-of-Number
(define (tabulate fn n)
  (cond [(= n 0) (list (fn n))]
        [else (cons (fn n) (tabulate fn (sub1 n)))]))

;; t-sqr
;; tabulate sqr between n and 0
;; Number -> Number
(define (t-sqr n)
  (tabulate sqr n))

;; t-tan
;; tabulate tan between n and 0
(define (t-tan n)
  (tabulate tan n))


; Exercise 251.
; Design fold1, which is the abstraction of the two functions in figure 93

; [List-of Number] -> Number
; computes the sum of 
; the numbers on l
(define (sum l)
  (fold1 + l 0))
	
; [List-of Number] -> Number
; computes the product of 
; the numbers on l
(define (product l)
  (fold1 * l 1))

;; fold1
;; folds a list according to fn
;; [Number Number -> Number] List-of-Number Number -> Number
(define (fold1 fn l e)
  (cond [(empty? l) e]
        [else (fn (first l) (fold1 fn (rest l) e))]))