;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |exercises 310-313|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct no-parent [])
(define NP (make-no-parent))
(define-struct child [father mother name date eyes])
;; FT (family tree) is one of:
;; - (make-no-parent)
;; - (make-child FT FT String Number String)
;; interp. representation of a family tree
;examples:
(define carl (make-child NP NP "Carl" 1926 "green"))
(define bettina (make-child NP NP "Bettina" 1926 "green"))
(define adam (make-child carl bettina "Adam" 1950 "hazel"))
(define david (make-child carl bettina "David" 1955 "black"))
(define eva (make-child carl bettina "Eva" 1965 "blue"))
(define fred (make-child NP NP "Fred" 1966 "pink"))
(define gustav (make-child fred eva "Gustav" 1988 "brown"))
;template
(define (fn-for-ft ft)
  (cond [(no-parent? ft) ...]
        [else (... (fn-for-ft (child-father ft))
                   ... (fn-for-ft (child-mother ft))
                   ... (child-name ft)
                   ... (child-date ft)
                   ... (child-eyes ft))]))

; Exercise 310.
; Develop count-persons. The function consumes a family tree and counts the
; child structures in the tree.

;; count-persons
;; count the cild structures in the given family tree
;; FT -> Number
(check-expect (count-persons NP) 0)
(check-expect (count-persons carl) 1)
(check-expect (count-persons eva) 3)
(check-expect (count-persons gustav) 5)
(define (count-persons ft)
  (cond [(no-parent? ft) 0]
        [else (+ 1 (count-persons (child-father ft))
                   (count-persons (child-mother ft)))]))

; Exercise 311.
; Develop the function average-age. It consumes a family tree and the current
; year. It produces the average age of all child structures in the family tree.

;; average-age
;; produces the average age of all child structures in the family tree
;; FT Number -> Number
(check-expect (average-age NP 2000) 0)
(check-expect (average-age carl 2000) 74)
(check-expect (average-age adam 2000) 66)
(define (average-age ft year)
  (cond [(no-parent? ft) 0]
        [else (/ (+ (average-age (child-father ft) year)
                 (average-age (child-mother ft) year)
                 (- year (child-date ft)))
                 (count-persons ft))]))

; Exercise 312.
; Develop the function eye-colors, which consumes a family tree and produces
; a list of all eye colors in the tree. An eye color may occur more than once
; in the resulting list.

;; eye-colors
;; produces a list of all eye colors in the tree,  eye color may occur more than once
;; FT -> [List-of String]
(check-expect (eye-colors NP) '())
(check-expect (eye-colors carl) '("green"))
(check-expect (eye-colors eva) '("blue" "green" "green"))
(check-expect (eye-colors gustav) '("brown" "pink" "blue" "green" "green"))
(define (eye-colors ft)
  (cond [(no-parent? ft) '()]
        [else (append
               (list (child-eyes ft))
               (eye-colors (child-father ft))
               (eye-colors (child-mother ft)))]))


; Exercise 313.


(check-expect (blue-eyed-ancestor? gustav) #true)
(check-expect (blue-eyed-ancestor? eva) #false)
(define (blue-eyed-ancestor? an-ftree)
  (cond
    [(no-parent? an-ftree) #false]
    [else
     (or
       (and (child? (child-father an-ftree)) (string=? "blue" (child-eyes (child-father an-ftree))))
       (and (child? (child-mother an-ftree)) (string=? "blue" (child-eyes (child-mother an-ftree))))
       (blue-eyed-ancestor? (child-father an-ftree))
       (blue-eyed-ancestor? (child-mother an-ftree)))]))


