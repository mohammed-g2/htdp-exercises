;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercises-166-170) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct work [employee rate hours])
; A (piece of) Work is a structure: 
;   (make-work String Number Number)
; interpretation (make-work n r h) combines the name 
; with the pay rate r and the number of hours h
;examples
(define w1 (make-work "james" 80 7))
(define w2 (make-work "susan" 60 12))
;template
(define (fn-for-w w)
  (... ... (work-employee w)
       ... (work-rate w)
       ... (work-hours w)))

; Low (short for list of works) is one of: 
; – '()
; – (cons Work Low)
; interpretation an instance of Low represents the 
; hours worked for a number of employees
;examples
(define low0 '())
(define low1 (cons w1 '()))
(define low2 (cons w2 (cons w1 '())))
;template
(define (fn-for-low low)
  (cond [(empty? low) ...]
        [else (... (fn-for-w (first low)) (fn-for-low (rest low)))]))

; Exercise 166.
; Develop a data representation for paychecks. Assume that a paycheck contains two
; distinctive pieces of information: the employee’s name and an amount. Then design
; the function wage*.v3. It consumes a list of work records and computes a list of
; paychecks from it, one per record.

(define-struct paycheck [name amount])
;; Paycheck is (make-paycheck String Number)
;; interp. representation of a paycheck
;exampels
(define p1 (make-paycheck "james" 2000))
(define p2 (make-paycheck "susan" 1000))
;template
(define (fn-for-paycheck p)
  (... (paycheck-name p)
       ... (paycheck-amount p)))

;; create-paycheck
;; make a paycheck form a work
;; Work -> Paycheck
(define (create-paycheck w)
  (make-paycheck (work-employee w) (* (work-rate w) (work-hours w))))

;; wage*.v3
;; consumes a list of work records and computes a list of paychecks from it, one per record
;; Low -> Lop
(check-expect (wage*.v3 '()) '())
(check-expect (wage*.v3 (cons (make-work "james" 20 7) '())) (cons (make-paycheck "james" (* 20 7)) '()))
(check-expect
 (wage*.v3 (cons (make-work "susan" 30 8) (cons (make-work "james" 10 6) '())))
 (cons (make-paycheck "susan" (* 30 8)) (cons (make-paycheck "james" (* 10 6)) '())))
(define (wage*.v3 low)
  (cond [(empty? low) low]
        [else (cons (create-paycheck (first low)) (wage*.v3 (rest low)))]))

; Exercise 167.
; Design the function sum, which consumes a list of Posns and produces the sum of all of its x-coordinates.

;; sum
;; consumes a list of Posns and produces the sum of all of its x-coordinates
;; Lop -> Number
(check-expect (sum '()) 0)
(check-expect (sum (cons (make-posn 0 10) '())) 0)
(check-expect (sum (cons (make-posn 10 10) '())) 10)
(check-expect (sum (cons (make-posn 10 10) (cons (make-posn 20 10) '()))) 30)
(define (sum lop)
  (cond [(empty? lop) 0]
        [else (+ (posn-x (first lop)) (sum (rest lop)))]))

; Exercise 168.
; Design the function translate. It consumes and produces lists of Posns. For each (make-posn x y) in
; the former, the latter contains (make-posn x (+ y 1))

;; transalte-one
;; translate one posn from (make-posn x y) to (make-posn x (+ y 1))
;; Posn -> Posn
(check-expect (translate-one (make-posn 10 10)) (make-posn 10 11))
(define (translate-one p)
  (make-posn (posn-x p) (+ (posn-y p) 1)))

;; translate
;; For each (make-posn x y) in input Lop the output Lop contains (make-posn x (+ y 1))
;; Lop -> Lop
(check-expect (translate '()) '())
(check-expect (translate (cons (make-posn 0 0) '())) (cons (make-posn 0 1) '()))
(check-expect
 (translate (cons (make-posn 10 10) (cons (make-posn 20 10) (cons (make-posn 20 30) '()))))
 (cons (make-posn 10 11) (cons (make-posn 20 11) (cons (make-posn 20 31) '()))))
(define (translate lop)
  (cond [(empty? lop) lop]
        [else (cons (translate-one (first lop)) (translate (rest lop)))]))

; Exercise 169.
; Design the function legal. Like translate from exercise 168, the function consumes and
; produces a list of Posns. The result contains all those Posns whose x-coordinates are
; between 0 and 100 and whose y-coordinates are between 0 and 200.

;; legal?
;; check if 
;; legal given posn's x-coordinates are between 0 and 100 and whose y-coordinates are between 0 and 200
;; Posn -> Boolean
(check-expect (legal? (make-posn 0 0)) #true)
(check-expect (legal? (make-posn 100 0)) #true)
(check-expect (legal? (make-posn 0 200)) #true)
(check-expect (legal? (make-posn 80 90)) #true)
(check-expect (legal? (make-posn 101 0)) #false)
(check-expect (legal? (make-posn 0 201)) #false)
(check-expect (legal? (make-posn 101 201)) #false)
(check-expect (legal? (make-posn -1 -1)) #false)
(define (legal? p)
  (if (and
       (and (>= (posn-x p) 0)
            (<= (posn-x p) 100))
       (and (<= (posn-y p) 200)
            (>= (posn-y p) 0)))
      #true
      #false))

;; produce a list contains all those Posns whose x-coordinates are
;; between 0 and 100 and whose y-coordinates are between 0 and 200.
;; Lop -> Lop
(check-expect (legal '()) '())
(check-expect (legal (cons (make-posn 0 0) '())) (cons (make-posn 0 0) '()))
(check-expect
 (legal (cons (make-posn 111 222) (cons (make-posn 100 200) (cons (make-posn 101 99) (cons (make-posn 99 201) (cons (make-posn 10 9) '()))))))
 (cons (make-posn 100 200) (cons (make-posn 10 9) '())))
(define (legal lop)
  (cond [(empty? lop) lop]
        [else (if (legal? (first lop))
                  (cons (first lop) (legal (rest lop)))
                  (legal (rest lop)))]))


; Exercise 170. Here is one way to represent a phone number:
(define-struct phone [area switch four])
; A Phone is a structure: 
;   (make-phone Three Three Four)
; A Three is a Number between 100 and 999. 
; A Four is a Number between 1000 and 9999. 
; Design the function replace. It consumes and produces a list of Phones. It replaces all occurrence of area code 713 with 281.

;; replace
;; replaces all occurrence of area code 713 with 281.
;; Lop -> Lop
(check-expect (replace '()) '())
(check-expect (replace (cons (make-phone 111 111 1111) '())) (cons (make-phone 111 111 1111) '()))
(check-expect (replace (cons (make-phone 713 111 1111) '())) (cons (make-phone 281 111 1111) '()))
(check-expect
 (replace (cons (make-phone 111 111 1111) (cons (make-phone 713 111 1111) (cons (make-phone 713 111 1111) '()))))
 (cons (make-phone 111 111 1111) (cons (make-phone 281 111 1111) (cons (make-phone 281 111 1111) '()))))

(define (replace lop)
  (cond [(empty? lop) lop]
        [else (if (= (phone-area (first lop)) 713)
                  (cons (make-phone 281 (phone-switch (first lop)) (phone-four (first lop))) (replace (rest lop)))
                  (cons (first lop) (replace (rest lop))))]))