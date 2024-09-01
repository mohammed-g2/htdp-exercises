;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercises-160) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; List-of-string String -> N
;; determines how often s occurs in los
(check-expect (count '() "a") 0)
(check-expect (count (cons "a" (cons "b" (cons "c" '()))) "b") 1)
(check-expect (count (cons "a" (cons "b" (cons "a" (cons "c" (cons "a" '()))))) "a") 3)
(define (count los s)
  (cond [(empty? los) 0]
        [else (if (string=? (first los) s)
                  (+ (count (rest los) s) 1)
                  (count (rest los) s))]))

; Exercise 160.
; Design the functions set+.L and set+.R, which create a set by adding a
; number x to some given set s for the left-hand and right-hand data definition, respectively.

;; set+.L
;; adds number x to set
;; Number Son.L -> Son.L
(check-expect (set+.L 1 '()) (cons 1 '()))
(check-expect (set+.L 1 (cons 2 '())) (cons 2 (cons 1 '())))
(check-expect (set+.L 2 (cons 2 (cons 3 '()))) (cons 2 (cons 3 (cons 2 '()))))
(define (set+.L x son)
  (cond [(empty? son) (cons x '())]
        [else (cons (first son) (set+.L x (rest son)))]))


;; set+.R
;; adds number x to set where no number occurs twice in son
;; Number Son.R -> Son.R
(check-expect (set+.R 1 '()) (cons 1 '()))
(check-expect (set+.R 5 (cons 2 '())) (cons 2 (cons 5'())))
(check-expect (set+.R 3 (cons 2 (cons 1 (cons 3 '())))) (cons 2 (cons 1 (cons 3 '()))))
(define (set+.R x son)
  (cond [(empty? son) (cons x '())]
        [else (if (member? x son)
                  son 
                  (cons (first son) (set+.R x (rest son))))]))
