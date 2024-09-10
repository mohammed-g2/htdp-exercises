;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |exercises 318-321|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; Any -> Boolean
(define (atom? a)
  (or (string? a) (number? a) (symbol? a)))

;; An S-expr is one of:
;; – Atom
;; – SL
;; interp. an S-expression
;examples
(define s-exp0 'hello)
(define s-exp1 '(0 1 ("hello")))
;template
(define (fn-for-s-exp s-exp)
  (cond [(atom? s-exp) (fn-for-atom s-exp)]
        [else (fn-for-sl s-exp)]))

;; An SL is one of:
;; – '()
;; – (cons S-expr SL)
;; interp. a list of s-expressions
;examples
(define sl0 '())
(define sl1 (list "a" "b" (list "c")))
;template
(define (fn-for-sl sl)
  (cond [(empty? sl) ...]
        [else (...
               (fn-for-s-exp (first sl))
               (fn-for-sl (rest sl)))]))

;; An Atom is one of:
;; – Number
;; – String
;; – Symbol
;; interp. an atomic data type
;template
(define (fn-for-atom atom)
  (cond [(string? atom) ...]
        [(number? atom) ...]
        [(symbol? atom) ...]))


; Exercise 318.
; Design depth. The function consumes an S-expression and determines its depth.
; An Atom has a depth of 1. The depth of a list of S-expressions is the maximum
; depth of its items plus 1.


;; depth
;; consumes an S-expression and determines its depth
;; S-exp -> Number
;(check-expect (depth 'hello) 1)
;(check-expect (depth (list "hello" "w")) 2)
;(check-expect (depth (list (list "a") "b" "c" (list "c" (list "d")))) 4)
;(check-expect (depth (list (list (list (list "a"))))) 5)
(define (depth s-exp)
  (cond [(atom? s-exp) 1]
        [else (depth-sl s-exp)]))

;; depth-sl
;; consume an sl and determines its depth
;; SL -> Number
;(check-expect (depth '()) 1)
;(check-expect (depth '(a b)) 2)
;(check-expect (depth '(((a c d)))) 4)
(define (depth-sl sl)
  (cond [(empty? sl) 1]
        [else (+
               (depth (first sl))
               (depth-sl (rest sl)))]))



; Exercise 319.
; Design substitute. It consumes an S-expression s and two symbols, old and
; new. The result is like s with all occurrences of old replaced by new. 


;; substitute
;; consumes an S-expression s and two symbols, old and new. The result is
;; like s with all occurrences of old replaced by new.
;; S-expr Atom Atom -> S-expr
(check-expect (substitute 'hello 'hello 'world) 'world)
(check-expect (substitute (list "hell" "new" "old") "old" "new") (list "hell" "new" "new"))
(check-expect
 (substitute (list "new" (list "old" (list "old" "new") "new") "new" "old") "old" 5)
 (list "new" (list 5 (list 5 "new") "new") "new" 5))
(define (substitute s-expr old new)
  (local
   ((define (atom? a)
     (or (string? a) (number? a) (symbol? a)))
   (define (substitute-sl sl)
     (cond [(empty? sl) sl]
           [else (cons (substitute (first sl) old new) (substitute-sl (rest sl)))]))
   (define (substitute-atom atom)
     (cond [(equal? atom old) new]
           [else atom])))
   (cond [(atom? s-expr) (substitute-atom s-expr)]
         [else (substitute-sl s-expr)])))


; Exercise 321.
; Abstract the data definitions for S-expr and SL so that they abstract over the
; kinds of Atoms that may appear.


;; An S-expr is one of:
;; – String
;; - Number
;; - Symbol
;; – SL
;; interp. an S-expression
;template
(define (fn-for-s-exp.v2 s-exp)
  (cond [(string? s-exp) ...]
        [(number? s-exp) ...]
        [(symbol? s-exp) ...]
        [else (fn-for-sl s-exp)]))
