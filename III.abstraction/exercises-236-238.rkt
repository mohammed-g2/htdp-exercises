;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercises-236) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; Exercise 236.
; Create test suites for the following two functions Then abstract over them.
; Define the above two functions in terms of the abstraction as one-liners and
; use the existing test suites to confirm that the revised definitions work
; properly. Finally, design a function that subtracts 2 from each number on a
; given list.


;; add*
;; add the given number to each element of given list
;; Number Lon -> Lon
(check-expect (add* 2 '()) '())
(check-expect (add* 2 (list 2)) (list 4))
(check-expect (add* 3 (list 1 2 3 5)) (list 4 5 6 8))
(define (add* n lon)
  (cond [(empty? lon) lon]
        [else (cons (+ n (first lon)) (add* n (rest lon)))]))

; Lon -> Lon
; adds 1 to each item on l
(check-expect (add1* '()) '())
(check-expect (add1* (list 2)) (list 3))
(check-expect (add1* (list 1 2 3 4)) (list 2 3 4 5))
(define (add1* l)
  (add* 1 l))

	
; Lon -> Lon
; adds 5 to each item on l
(check-expect (plus5 '()) '())
(check-expect (plus5 (list 5)) (list 10))
(check-expect (plus5 (list 1 2 3 4 5)) (list 6 7 8 9 10))
(define (plus5 l)
  (add* 5 l))

;; subtract2
;; subtracts 2 from each number on a given list
;; Lon -> Lon
(check-expect (subtract2 '()) '())
(check-expect (subtract2 (list 5)) (list 3))
(check-expect (subtract2 (list 8 2 1 9)) (list 6 0 -1 7))
(define (subtract2 lon)
  (add* -2 lon))


; Exercise 238.
; Abstract the two functions in figure 89 into a single function. Both consume
; non-empty lists of numbers (Nelon) and produce a single number. The left one
; produces the smallest number in the list, and the right one the largest.
(check-expect (min-max > (list 1)) 1)
(check-expect (min-max > (list 1 2 3 4 5)) 5)
(check-expect (min-max > (list 7 5 1 4 9 5)) 9)
(check-expect (min-max < (list 1 2 3 4 5)) 1)
(check-expect (min-max < (list 7 5 1 4 9 5)) 1)
(define (min-max fn lon)
  (cond [(empty? (rest lon)) (first lon)]
        [else (if (fn (first lon) (min-max fn (rest lon)))
                  (first lon)
                  (min-max fn (rest lon)))]))

; Nelon -> Number
; determines the smallest 
; number on l
(define (inf l)
  (min-max > l))
	
; Nelon -> Number
; determines the largest 
; number on l
(define (sup l)
  (min-max < l))
