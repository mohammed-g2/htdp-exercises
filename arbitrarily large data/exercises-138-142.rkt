;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercises-138-142) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; Exercise 138.
; Here is a data definition for representing sequences of amounts of money.
; Create some examples and design the sum function, which consumes a
; List-of-amounts and computes the sum of the amounts.

;; A List-of-amounts is one of: 
;; – '()
;; – (cons PositiveNumber List-of-amounts)
;; interp. a list of amounts of money
;examples
(define loa0 '())
(define loa1 (cons 10 '()))
(define loa2 (cons 20 (cons 50 '())))
(define loa3 (cons 100 (cons 125 (cons 856 (cons 47 '()))))) ;1128
;template
(define (fn-for-loa loa)
  (cond [(empty? loa) ...]
        [(cons? loa) (... (first loa) ... (fn-for-loa(rest loa)))]))

;; sum
;; produce the sum of a given list of amounts (loa)
;; Loa -> Number
(check-expect (sum loa0) 0)
(check-expect (sum loa1) 10)
(check-expect (sum loa2) 70)
(check-expect (sum loa3) 1128)
(define (sum loa)
  (cond [(empty? loa) 0]
        [(cons? loa) (+ (first loa) (sum(rest loa)))]))


; Exercise 139.
; Design the function pos?, which consumes a List-of-numbers and determines whether
; all numbers are positive numbers.
; design checked-sum. The function consumes a List-of-numbers. It produces their sum
; if the input also belongs to List-of-amounts; otherwise it signals an error.

;; los (List of Numbers) is one of:
;; - '()
;; - (cons Number Los)
;; interp. a list of numbers
;examples
(define los0 '())
(define los1 (cons 1 '()))
(define los2 (cons 1 (cons 2 (cons 3 (cons 4 '())))))
(define los3 (cons 1 (cons 2 (cons -3 (cons 4 '())))))
(define los4 (cons -1 (cons -2 (cons -3 '()))))
;template
(define (fn-for-los los)
  (cond [(empty? los) ...]
        [(cons? los) (... (first los) ... (fn-for-los (rest los)))]))

;; pos?
;; determines whether all numbers of given list are positive numbers
;; Los -> Boolean
(check-expect (pos? '()) #true)
(check-expect (pos? los1) #true)
(check-expect (pos? los2) #true)
(check-expect (pos? los3) #false)
(check-expect (pos? los4) #false)

(define (pos? los)
  (cond [(empty? los) #true]
        [(cons? los) (and (positive? (first los)) (pos? (rest los)))]))


;; check-sum
;; consumes a List-of-numbers. It produces their sum if the input also
;; belongs to List-of-amounts; otherwise it signals an error.
;; Loa -> Number | error
(check-expect (check-sum '()) 0)
(check-expect (check-sum (cons 1 (cons 2 (cons 3 '())))) 6)
(check-error (check-sum (cons 1 (cons 2 (cons -3 '())))) "list containes a negative number")

(define (check-sum loa)
  (cond [(not (pos? loa)) (error "list containes a negative number")]
        [else (sum loa)]))

; Exercise 140.
; Design the function all-true, which consumes a list of Boolean values and determines whether all of them are #true.

;; lob (list of boolean) is one of:
;; = '()
;; - (cons Boolean Lob)
;; interp. a list of booleans
;examples
(define lob0 '())
(define lob1 (cons #true '()))
(define lob2 (cons #false '()))
(define lob3 (cons #true (cons #true (cons #true '()))))
(define lob4 (cons #true (cons #true (cons #false (cons #true '())))))
(define lob5 (cons #false (cons #false (cons #false '()))))
(define lob6 (cons #false (cons #false (cons #true (cons #false '())))))
;template
(define (fn-for-lob lob)
  (cond [(empty? lob) ...]
        [(cons? lob) (... (first lob) ... (fn-for-lob(rest lob)))]))

;; all-true
;; check if all elements of given list are true
;; Lob -> Boolean
(check-expect (all-true lob0) #true)
(check-expect (all-true lob1) #true)
(check-expect (all-true lob2) #false)
(check-expect (all-true lob3) #true)
(check-expect (all-true lob4) #false)
(define (all-true lob)
  (cond [(empty? lob) #true]
        [(cons? lob) (and (first lob) (all-true(rest lob)))]))

; Now design one-true, a function that consumes a list of Boolean values and determines whether
; at least one item on the list is #true

;; one-true
;; consumes a list of Boolean values and determines whether at least one item on the list is #true
;; Lob -> Boolean
(check-expect (one-true lob0) #false)
(check-expect (one-true lob1) #true)
(check-expect (one-true lob2) #false)
(check-expect (one-true lob3) #true)
(check-expect (one-true lob4) #true)
(check-expect (one-true lob5) #false)
(check-expect (one-true lob6) #true)

(define (one-true lob)
  (cond [(empty? lob) #false]
        [(cons? lob) (or (first lob) (one-true (rest lob)))]))

; Exercise 141.
; If you are asked to design the function cat, which consumes a list of strings and appends them all
; into one long string, you are guaranteed to end up with this partial definition


; List-of-string -> String
; concatenates all strings in l into one long string
 
(check-expect (cat '()) "")
(check-expect (cat (cons "a" (cons "b" '()))) "ab")
(check-expect
  (cat (cons "ab" (cons "cd" (cons "ef" '()))))
  "abcdef")

(define (cat los)
  (cond [(empty? los) ""]
        [(cons? los) (string-append (first los) (cat (rest los)))]))
 

; Exercise 142.
; Design the ill-sized? function, which consumes a list of images loi and a positive number n. It produces
; the first image on loi that is not an n by n square; if it cannot find such an image, it produces #false

;; Loi (list og images) is one of:
;; - '()
;; - (cons Image Loi)
;; interp. a list of images
;examples
(define loi0 '())
(define loi1 (cons (square 10 "solid" "green") '()))
(define loi2 (cons (square 10 "solid" "green") (cons (square 10 "solid" "green") (cons (square 10 "solid" "green") '()))))
(define loi3 (cons (square 10 "solid" "green") (cons (rectangle 10 20 "solid" "green") (cons (square 10 "solid" "green") '()))))

;; ill-sized?
;; consumes a list of images loi and a positive number n, prodcues the first image on loi that is not an
;; n by n square, if it cannot find such an image, it produces #false
;; Loi Number -> Image | #false
(check-expect (ill-sized? loi0 10) #false)
(check-expect (ill-sized? loi1 10) #false)
(check-expect (ill-sized? loi2 10) #false)
(check-expect (ill-sized? loi2 20) (square 10 "solid" "green"))
(check-expect (ill-sized? loi3 10) (rectangle 10 20 "solid" "green"))

(define (ill-sized? loi n)
  (cond [(empty? loi) #false]
        [(cons? loi) (if (not (= (* (image-width (first loi)) (image-height (first loi))) (* n n)))
                         (first loi)
                         (ill-sized? (rest loi) n))]))

