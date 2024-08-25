;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercises-150-153) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; Exercise 150.
; Design the function add-to-pi. It consumes a natural number n and adds it to pi
; Once you have a complete definition, generalize the function to add, which adds
; a natural number n to some arbitrary number x without using +

;; add-to-pi
;; N -> Number
;; computes (+ n pi) without using +
(check-within (add-to-pi 0) pi 3.141592653589793)
(check-within (add-to-pi 1) (+ pi 1) 4.141592653589793)
(check-within (add-to-pi 8) (+ pi 8) 11.141592653589793)
(check-within (add-to-pi 10) (+ pi 10) 13.141592653589793)
(define (add-to-pi n)
  (cond [(zero? n) pi]
        [(positive? n) (add1 (add-to-pi (sub1 n)))]))

;; add
;; Number Number -> Number
;; adds a natural number n to some arbitrary number x
(check-expect (add 0 0) 0)
(check-expect (add 0 8) 8) 
(check-expect (add 5 8) 13)
(check-expect (add 50 100) 150)
(define (add n x)
  (cond [(zero? n) x]
        [(positive? n) (add (sub1 n) (add1 x))]))

;Exercise 151.
; Design the function multiply. It consumes a natural number n and multiplies
; it with a number x without using *

;; multiply
;; consumes a natural number n and multiplies it with a number x
;; Number Number -> Number
(check-expect (multiply 0 0) 0)
(check-expect (multiply 0 5) 0)
(check-expect (multiply 5 0) 0)
(check-expect (multiply 1 5) 5)
(check-expect (multiply 2 3) 6)
(check-expect (multiply 5 5) 25)
(check-expect (multiply 100 8) 800)
(define (multiply n x)
  (cond [(zero? n) 0]
        [(positive? n) (if (= n 1)
                           x
                           (add (multiply (sub1 n) x) x))]))

;; Exercise 152.
; Design two functions: col and row.
; The function col consumes a natural number n and an image img. It produces
; a column—a vertical arrangement—of n copies of img.
; The function row consumes a natural number n and an image img. It produces
; a row—a horizontal arrangement—of n copies of img.

(define BACKGROUND (empty-scene 100 200 "transparent"))

;; col
;; produces a column—a vertical arrangement—of n copies of img
;; Number Image -> Image
(check-expect (col 0 (rectangle 1 200 "solid" "black")) BACKGROUND)
(check-expect (col 1 (rectangle 1 200 "solid" "black")) (place-image (rectangle 1 200 "solid" "black") 10 (/ (image-height BACKGROUND) 2) BACKGROUND))
(define (col n img)
  (cond [(zero? n) BACKGROUND]
        [(positive? n) (place-image
                        img
                        (* n 10)
                        (/ (image-height BACKGROUND) 2)
                        (col (sub1 n) img))]))

;; row
;; produces a row—a horizontal arrangement—of n copies of img
;; Number Image -> Image
(check-expect (row 0 (rectangle 1 200 "solid" "black")) BACKGROUND)
(check-expect (row 1 (rectangle 100 1 "solid" "black")) (place-image (rectangle 100 1 "solid" "black") (/ (image-width BACKGROUND) 2) 10 BACKGROUND))
(define (row n img)
  (cond [(zero? n) BACKGROUND]
        [(positive? n) (place-image
                        img
                        (/ (image-width BACKGROUND) 2)
                        (* n 10)
                        (row (sub1 n) img))]))

; Exercise 153.
; Use the two functions from exercise 152 to create a rectangle of COLUMNS by ROWS squares, each of which has size 10 by 10
; Design add-balloons. The function consumes a list of Posn whose coordinates fit into the dimensions of the lecture hall.
; It produces an image of the lecture hall with red dots added as specified by the Posns.

(define HALL
  (place-image
   (col (/ (image-width BACKGROUND) 10) (rectangle 1 (image-height BACKGROUND) "solid" "black"))
   (/ (image-width BACKGROUND) 2) (/ (image-height BACKGROUND) 2)
   (row (/ (image-height BACKGROUND) 10) (rectangle (image-width BACKGROUND) 1 "solid" "black"))))

;; add-ballons
;; consumes a list of Posn whose coordinates fit into the dimensions of the lecture hall.
;; produces an image of the lecture hall with red dots added as specified by the Posns.
;; List-of-Posn -> Image
(check-expect (add-ballon '()) HALL)
(check-expect (add-ballon (cons (make-posn 10 10) '())) (place-image (circle 5 "solid" "red") 10 10 HALL))
(check-expect (add-ballon (cons (make-posn 10 10) (cons (make-posn 20 80) '()))) (place-image
                                                                      (circle 5 "solid" "red")
                                                                      10 10
                                                                      (place-image
                                                                       (circle 5 "solid" "red")
                                                                       20 80
                                                                       HALL)))
(define (add-ballon lop)
  (cond [(empty? lop) HALL]
        [else (place-image
               (circle 5 "solid" "red")
               (posn-x (first lop)) (posn-y (first lop))
               (add-ballon (rest lop)))]))