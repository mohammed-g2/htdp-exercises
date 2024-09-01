;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercises-195-196) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)

;; LETTER is one of:
;; - a
;; - ...
;; - z
;; a member of this list:
(define LETTER (explode "abcdefghijklmnopqrstuvwxyz"))
;; templates
(define (fn-for-letter l)
  (cond [(not (member? LETTER)) ...]
        [(string=? l ...) ...]
        [else (... l )]))

; Exercise 195.
; Design the function starts-with#, which consumes a Letter
; and Dictionary and then counts how many words in the given
; Dictionary start with the given Letter

(define LOCATION "E:\\learn\\htdp\\words")

;; dictionary is a list of strings:
(define DICTIONARY (read-lines LOCATION))

;; starts-with#
;; counts how many words in the given Dictionary start with
;; the given Letter
;; Letter DICTIONARY -> Number
(check-expect (starts-with# "a" '()) 0)
(check-expect (starts-with# "a" (list "hello" "wolrd" "this" "program" "runs")) 0)
(check-expect (starts-with# "a" (list "the" "animal" "farm" "a" "new" "article")) 3)
(define (starts-with# l d)
  (cond [(empty? d) 0]
        [else (if (string=? l (string-ith (first d) 0))
                     (+ 1 (starts-with# l (rest d)))
                     (starts-with# l (rest d)))]))

; Exercise 196.
; Design count-by-letter. The function consumes a Dictionary and counts how often
; each letter is used as the first one of a word in the given dictionary. Its
; result is a list of Letter-Counts, a piece of data that combines letters and counts.

(define-struct letter-count [l c])
;; Letter-Counts is (make-letter-count 1String Number)
;; interp. representation of the number of accurnces of each letter in the dictionary
;examples
(define lc0 (make-letter-count "a" 0))
(define lc1 (make-letter-count "b" 20))
;template
(define (fn-for-lc lc)
  (... (letter-count l) ... (letter-count c)))

;; count-letters
;; count the number of occurncses of a letter in given dictionary
;; LETTER DICTIONARY -> Number
;(check-expect (count-letters LETTER (list "hello" "world" "animal" "farm" "anew" "hell" "ay"))
;              (list (make-letter-count "h" 2)
;                    (make-letter-count "w" 1)
;                    (make-letter-count "a" 3)
;                    (make-letter-count "f" 1)))
(define (count-letters l d)
  (cond [(empty? l) '()]
        [else (cons
               (make-letter-count (first l) (starts-with# (first l) d))
               (count-letters (rest l) d))]))

;; count-by-letter
;; counts how often each letter is used as the first one of a word in the given dictionary
;; DICTIONARY -> List-of-Letter-Count
;(check-expect (count-by-letter '()) '())
;(check-expect (count-by-letter (list "hello" "world" "animal" "farm" "anew" "hell" "ay"))
;              (list (make-letter-count "h" 2)
;                    (make-letter-count "w" 1)
;                    (make-letter-count "a" 3)
;                    (make-letter-count "f" 1)))
(define (count-by-letter d)
  (count-letters LETTER d))