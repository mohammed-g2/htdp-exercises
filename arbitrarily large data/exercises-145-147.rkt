;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercises-145-147) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 145.
; Design the sorted>? predicate, which consumes a NEList-of-temperatures and produces #true if
; the temperatures are sorted in descending order. That is, if the second is smaller than the
; first, the third smaller than the second, and so on. Otherwise it produces #false.

;; sorted>?
;; produces #true if the temperatures are sorted in descending order, else false
;; NEList-of-temprature -> Boolean
(check-expect (sorted>? (cons 5 '())) #true)
(check-expect (sorted>? (cons 2 (cons 1 '()))) #true)
(check-expect (sorted>? (cons 2 (cons 1 (cons 0 (cons -1 '()))))) #true)
(check-expect (sorted>? (cons 3 (cons 4 '()))) #false)
(check-expect (sorted>? (cons 5 (cons 4 (cons 3 (cons 8 (cons 1 '())))))) #false)
(define (sorted>? nlot)
  (cond [(empty? (rest nlot)) #true]
        [else (and (> (first nlot) (first (rest nlot)))
                   (sorted>? (rest nlot)))]))

; Exercise 146.
; Design how-many for NEList-of-temperatures. Doing so completes average, so ensure that average
; passes all of its tests, too

;; how-many
;; return the total number of elemenets in non empty list
;; NEList-of-temperatures -> Number
(check-expect (how-many (cons 0 '())) 1)
(check-expect (how-many (cons 0 (cons 10 (cons 20 '())))) 3)
(check-expect (how-many (cons 10 (cons 20 (cons 40 (cons 50 '()))))) 4)
(define (how-many nlot)
  (cond [(empty? (rest nlot)) 1]
        [else (+ 1 (how-many (rest nlot)))]))

;; nel-sum
;; the sum of non empty list of tempratures
;; NEList-of-tempartures -> Number
(check-expect (nel-sum (cons 1 '())) 1)
(check-expect (nel-sum (cons 1 (cons -1 (cons -2 '())))) -2)
(check-expect (nel-sum (cons 5 (cons 9 (cons 10 (cons 1 '()))))) 25)
(define (nel-sum nlot)
  (cond [(empty? (rest nlot)) (first nlot)]
        [else (+ (first nlot) (nel-sum (rest nlot)))]))

;; avarage
;; calculate the avarage of given list of tempratures
;; NEList-of-temperatures -> Number
(check-expect (avarage (cons 5 '())) 5)
(check-expect (avarage (cons 10 (cons 20 (cons -30 '())))) 0)
(check-expect (avarage (cons 10 (cons 20 (cons 30 (cons 40 '()))))) 25)
(define (avarage nlot)
  (/ (nel-sum nlot) (how-many nlot)))

; Exercise 147.
; Develop a data definition for NEList-of-Booleans, a representation of non-empty
; lists of Boolean values. Then redesign the functions all-true and one-true from exercise 140.

;; NEList-of-Booleans (nlob) is one of:
;; - (cons Boolean '())
;; - (cons nlob)
;; interp. a non empty list of booleans
;examples
(define nlob0 (cons #true '()))
(define nlob1 (cons #false '()))
(define nlob2 (cons #true (cons #true '())))
(define nlob3 (cons #false (cons #true '())))
(define nlob4 (cons #true (cons #true (cons #false (cons #true '())))))
(define nlob5 (cons #false (cons #false (cons #true (cons #false '())))))
(define nlob6 (cons #true (cons #true (cons #true (cons #true '())))))
(define nlob7 (cons #false (cons #false (cons #false (cons #false '())))))
;template
(define (fn-for-nlob nlob)
  (cond [(empty? (rest nlob)) ...]
        [else (... (first nlob) ... (fn-for-nlob (rest nlob)))]))

;; all-true
;; check if the given list consists of #true values
;; nlob -> Boolean
(check-expect (all-true nlob0) #true)
(check-expect (all-true nlob1) #false)
(check-expect (all-true nlob2) #true)
(check-expect (all-true nlob3) #false)
(check-expect (all-true nlob4) #false)
(check-expect (all-true nlob5) #false)
(check-expect (all-true nlob6) #true)
(define (all-true nlob)
  (cond [(empty? (rest nlob)) (first nlob)]
        [else (and (first nlob) (all-true (rest nlob)))]))

;; one-true
;; check if given non empty list have one element that is true
(check-expect (one-true nlob0) #true)
(check-expect (one-true nlob1) #false)
(check-expect (one-true nlob2) #true)
(check-expect (one-true nlob3) #true)
(check-expect (one-true nlob4) #true)
(check-expect (one-true nlob5) #true)
(check-expect (one-true nlob6) #true)
(check-expect (one-true nlob7) #false)
(define (one-true nlob)
  (cond [(empty? (rest nlob)) (first nlob)]
        [else (or (first nlob) (one-true (rest nlob)))]))