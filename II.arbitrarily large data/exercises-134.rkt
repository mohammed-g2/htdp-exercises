;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercises-134) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 134.
; Develop the contains? function, which determines whether some given string occurs on a given list of strings

; Data definition

;; los (list of strings) is one of:
;; - '()
;; - (cons String los)
;; interp. a list of strings
;examples
(define los1 '())
(define los2 (cons "a" '()))
(define los3 (cons "a" (cons "b" (cons "c" (cons "d" '())))))
;template
(define (fn-for-los los)
  (cond [(empty? los) ...]
        [(cons? los) (... (first los) ... (rest los))]))

;; contains?
;; determines whether given string occurs on a given list of strings
;; String Los -> Boolean
(check-expect (contains? "a" '()) #false)
(check-expect (contains? "a" (cons "c" '())) #false)
(check-expect (contains? "a" (cons "a" '())) #true)
(check-expect (contains? "a" (cons "b" (cons "c" (cons "a" '())))) #true)
(check-expect (contains? "a" (cons "b" (cons "c" (cons "a" (cons "d" '()))))) #true)
(define (contains? s los)
  (cond [(empty? los) #false]
        [(cons? los) (or (string=? s (first los)) (contains? s (rest los)))]))