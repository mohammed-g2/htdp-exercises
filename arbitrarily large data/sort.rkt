;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname sort) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; insert
;; insert a number n into given sorted list of number
;; Number Lon -> Lon
(check-expect (insert 0 '()) (list 0))
(check-expect (insert 0 (list 4 2 1 -1)) (list 4 2 1 0 -1))
(check-expect (insert 5 (list 9 7 4 3 1)) (list 9 7 5 4 3 1))
(define (insert n lon)
  (cond [(empty? lon) (cons n lon)]
        [else (if (>= n (first lon))
                  (cons n lon)
                  (cons (first lon) (insert n (rest lon))))]))

;; sort
;; sort a list of numbers in descnding order
;; List-of-numbers -> List-of-numbers
;(check-expect (sort> '()) '())
(check-expect (sort> (cons 1 '())) (cons 1 '()))
(check-expect (sort> (cons 3 (cons 2 (cons 1 '())))) (cons 3 (cons 2 (cons 1 '()))))
(check-expect (sort> (cons 1 (cons 2 (cons 3 '())))) (cons 3 (cons 2 (cons 1 '()))))
(check-expect (sort> (cons 3 (cons 1 (cons 2 '())))) (cons 3 (cons 2 (cons 1 '()))))
(check-expect (sort> (list 8 7 2 4 9 1 7)) (list 9 8 7 7 4 2 1))
(define (sort> lon)
  (cond [(empty? (rest lon)) lon]
        [else (insert (first lon) (sort> (rest lon)))]))
