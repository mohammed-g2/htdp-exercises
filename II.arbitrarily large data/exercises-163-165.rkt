;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercises-163-165) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; Exercise 163.
; Design convertFC. The function converts a list of measurements in Fahrenheit to a list of Celsius measurements.

; Data definitions

;; F is a Number between ... and ...
;; interp. temprature in Fahrenheit
;examples
(define f0 85)
(define f1 75)
;template
(define (fn-for-f f)
  (... f ...))

;; Lof is one of:
;; - '()
;; - (cons F Lof)
;; interp. a list of measurements in Fahrenheit (F)
;examples
(define lof0 '())
(define lof1 (cons 15 '()))
(define lof2 (cons 14 (cons 94 '())))
(define lof3 (cons 85 (cons 58 (cons 8 (cons 84 '())))))
;template
(define (fn-forlof lof)
  (cond [(empty? lof) ...]
        [else (... (fn-for-f (first lof)) ... (fn-for-lof (rest lof)))]))


;; F->C
;; convert Fahrenheit to Celsius
;; F -> C
(check-expect (F->C 32) 0)
(check-expect (F->C 20) -7)
(check-expect (F->C -8) -23)
(define (F->C f)
  (inexact->exact (floor (/ (- f 32) 1.8))))

;; convertFC
;; converts a list of measurements in Fahrenheit to a list of Celsius measurements
;; Lof -> Loc
(check-expect (convertFC '()) '())
(check-expect (convertFC (cons 20 (cons 80 (cons 40 '())))) (cons -7 (cons 26 (cons 4 '())))) 
(define (convertFC lof)
  (cond [(empty? lof) lof]
        [else (cons (F->C (first lof)) (convertFC (rest lof)))]))


; Exercise 164.
; Design the function convert-euro, which converts a list of US$ amounts into a list of € amounts.
; Generalize convert-euro to the function convert-euro*, which consumes an exchange rate and a list
; of US$ amounts and converts the latter into a list of € amounts.


;; convert-euro
;; converts a list of US$ amounts into a list of € amounts
;; List-of-PositiveNumbers -> List-of-PositiveNumbers
(check-expect (convert-euro '()) '())
(check-expect (convert-euro (cons 10 (cons 20 (cons 70 '())))) (cons 8 (cons 17 (cons 62 '()))))
(define (convert-euro lou)
  (cond [(empty? lou) lou]
        [else (cons (inexact->exact (floor (* 0.895 (first lou)))) (convert-euro (rest lou)))]))


;; convert-euro*
;; consumes an exchange rate and a list of US$ amounts and converts the latter into a list of € amounts.
;; Number List-of-PositiveNumbers -> List-of-PositiveNumbers
(check-expect (convert-euro* 0.9 '()) '())
(check-expect (convert-euro* 0.9 (cons 10 (cons 20 (cons 28 '())))) (cons 9 (cons 18 (cons 25 '()))))
(check-expect (convert-euro* 1 (cons 10 (cons 20 (cons 28 '())))) (cons 10 (cons 20 (cons 28 '()))))
(check-expect (convert-euro* 1.2 (cons 10 (cons 20 (cons 28 '())))) (cons 12 (cons 24 (cons 33 '()))))

(define (convert-euro* rate lou)
  (cond [(empty? lou) lou]
        [else (cons (inexact->exact (floor ( * rate (first lou)))) (convert-euro* rate (rest lou)))]))

; Exercise 165.
; Design the function subst-robot, which consumes a list of toy descriptions (one-word strings) and
; replaces all occurrences of "robot" with "r2d2"; all other descriptions remain the same.

;; subst-robot
;; replaces all occurrences of "robot" with "r2d2" in given list of one word strings
;; Los -> Los
(check-expect (subst-robot '()) '())
(check-expect (subst-robot (cons "a" '())) (cons "a" '()))
(check-expect (subst-robot (cons "robot" '())) (cons "r2d2" '()))
(check-expect (subst-robot (cons "a" (cons "b" (cons "a" '())))) (cons "a" (cons "b" (cons "a" '()))))
(check-expect
 (subst-robot (cons "a" (cons "b" (cons "robot" (cons "a" (cons "robot" (cons "robot" '())))))))
 (cons "a" (cons "b" (cons "r2d2" (cons "a" (cons "r2d2" (cons "r2d2" '())))))))

(define (subst-robot los)
  (cond [(empty? los) los]
        [else (if (string=? (first los) "robot")
                  (cons "r2d2" (subst-robot (rest los)))
                  (cons (first los) (subst-robot (rest los))))]))


; Generalize subst-robot to substitute. The latter consumes two strings, called new and old,
; and a list of strings. It produces a new list of strings by substituting all occurrences of old with new.

;; substitute
;; consumes two strings, new and old, and a list of strings.
;; It produces a new list of strings by substituting all occurrences of old with new.
;; String String Los -> Los
(check-expect (substitute "new" "old" '()) '())
(check-expect
 (substitute "new" "old" (cons "newa" (cons "newa" (cons "newa" '()))))
 (cons "newa" (cons "newa" (cons "newa" '()))))
(check-expect
 (substitute "new" "old" (cons "old" (cons "old" (cons "old" (cons "newish" '())))))
 (cons "new" (cons "new" (cons "new" (cons "newish" '())))))
(check-expect
 (substitute "new" "old" (cons "new" (cons "newish" (cons "old" (cons "older" '())))))
 (cons "new" (cons "newish" (cons "new" (cons "older" '())))))
 
(define (substitute n o los)
  (cond [(empty? los) los]
        [else (if (string=? (first los) o)
                  (cons n (substitute n o (rest los)))
                  (cons (first los) (substitute n o (rest los))))]))
