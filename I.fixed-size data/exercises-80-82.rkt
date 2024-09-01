;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercises-80-82) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 80.
; Create templates for functions that consume instances of the
; following structure types:

(define-struct movie [title director year])
;template
(define (fn-for-movie m)
  (... (movie-title m)
   ... (movie-director m)
   ... (movie-year m)))

(define-struct pet [name number])
;template
(define (fn-for-pet p)
  (... (pet-name p)
   ... (pet-number p)))

(define-struct CD [artist title price])
;template
(define (fn-for-CD cd)
  (... (CD-artist cd)
   ... (CD-title cd)
   ... (CD price cd)))

(define-struct sweater [material size color])
;template
(define (fn-for-sweater s)
  (... (sweater-material s)
   ... (sweater-size s)
   ... (sweater-color s)))

; Exercise 81.
; Design the function time->seconds, which consumes instances of
; time structures (see exercise 77) and produces the number of seconds
; that have passed since midnight. For example, if you are representing
; 12 hours, 30 minutes, and 2 seconds with one of these structures and
; if you then apply time->seconds to this instance, the correct result
; is 45002.

(define-struct time [h m s])
;; Time is (make-time Number Number Number)
;; interp. the time since midnight where:
;; - h is hours from 0 to 12
;; - m in minutes from 0 to 59
;; - s is seconds from 0 to 59
;examples
(define midnight (make-time 12 0 0))
(define time1 (make-time 11 59 59))
(define time2 (make-time 0 0 59))
(define time3 (make-time 10 45 21))
;template
(define (fn-for-time t)
  (... (time-h t)
   ... (time-m t)
   ... (time-s t)))

;; time->seconds
;; consume instance of time and produces the number of
;; seconds that has passed since midnight
;; Time -> Number
(check-expect (time->seconds (make-time 12 30 2)) 45002)
(define (time->seconds t)
  (+ (* (time-h t) 60 60)
     (* (time-m t) 60)
     (time-s t)))

; Exercise 82.
; Design the function compare-word. The function consumes two three-letter
; words (see exercise 78). It produces a word that indicates where the
; given ones agree and disagree. The function retains the content of the
; structure fields if the two agree; otherwise it places #false in the
; field of the resulting word

(define-struct word [l1 l2 l3])
;; Word is (make-word 1String 1String 1String)
;; interp. a three letter word where letter is one of:
;; - a to z
;; - #false
;example
(define word1 (make-word "w" "a" "r"))
(define word2 (make-word "o" "n" #false))
(define word3 (make-word #false "n" "o"))
;template
(define (fn-for-word w)
  (... (word-l1 w)
       ... (word-l2 w)
       ... (word-l3 w)))

;; compare-word
;; consume 2 three letter word, produce one word where:
;; - retains the content of the structure fields if 2 letters agree
;; - else place #false in the field if the two disagree
;; Word Word -> Word
(check-expect (compare-word word1 word2) (make-word #false #false #false))
(check-expect (compare-word word2 word3) (make-word #false "n" #false))
(define (compare-word w1 w2)
  (make-word
   (if (equal? (word-l1 w1) (word-l1 w2))
       (word-l1 w1)
       #false)
   (if (equal? (word-l2 w1) (word-l2 w2))
       (word-l2 w1)
       #false)
   (if (equal? (word-l3 w1) (word-l3 w2))
       (word-l3 w1)
       #false)))