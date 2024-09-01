;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercises-76-79) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 76.
; Formulate data definitions for the following structure type definitions

(define-struct movie [title producer year])
;; movie is (make-movie String String Number)
;; interp. representation of a movie
;examples
(define movie1 (make-movie "a movie" "producer" 1992))

(define-struct person [name hair eyes phone])
;; person is (make-person String String String Number)
;; interp. represents a person's information
;examples
(define person5 (make-person "mark" "black" "black" 123456))

(define-struct pet [name number])
;; pet is (make-pet String Number)
;; interp. represents a pet' name and it's owner number
;examples
(define pet1 (make-pet "cat" 123456))

(define-struct CD [artist title price])
;; CD is (make-CD String String Number)
;; interp. represents CD's information
;examples
(define cd1 (make-CD "artist" "title" 27))

(define-struct sweater [material size producer])
;; sweater is (make-sweater String Number String)
;; interp. the representation of a sweater
;examples
(define sweater1 (make-sweater "cotton" 14 "producer"))
;template
(define (fn-for-sweater s)
  (... (sweater-material s)
   ... (sweater-size s)
   ... (sweater-producer s)))


; Exercise 77.
; Provide a structure type definition and a data definition for
; representing points in time since midnight. A point in time
; consists of three numbers: hours, minutes, and seconds

(define-struct time [hours minutes seconds])
;; time is (make-time Number Number Number)
;; interp. the time since midnght where:
;; - hours is an interval between 0 and 12
;; - minuter is an interval between 0 and 60
;; - seconds is an interval between 0 and 60
;examples
(define time1 (make-time 5 12 0))
;template
(define (fn-for-time t)
  (... (cond [(number=? (time-hours t)  0) ...]
             [(number=? (time-hours t) 12) ...]
             [(> (time-hours t) 0) ...])
   ... (time-minutes t)
   ... (time-seconds t)))


; Exercise 78.
; Provide a structure type and a data definition for representing
; three-letter words. A word consists of lowercase letters,
; represented with the 1Strings "a" through "z" plus #false.

(define-struct word [l1 l2 l3])
;; word is (make-word 1String 1String 1String)
;; interp. a three 1String word where each letter is one of:
;; - letters from a ... to z
;; - false
;examples
(define word1 (make-word "a" "b" #false))
;template
(define (fn-for-word w)
  (... (cond [(and (string? (word-l1 w)) (= (string-length (word-l1 w)) 1)) ... (word-l1 w)]
             [(boolean? (word-l1 w) #false) ...(word-l1 w)])
   ... (word-l2 w)
   ... (word-l3 w)))


; Exercise 79.
; Create examples for the following data definitions

; A Color is one of: 
; — "white"
; — "yellow"
; — "orange"
; — "green"
; — "red"
; — "blue"
; — "black"

;examples
(define color1 "white")
(define color2 "green")

; H is a Number between 0 and 100.
; interpretation represents a happiness value

;examples
(define h1 0)
(define h2 50)
(define h3 100)

(define-struct person.v2 [fstname lstname male?])
; A Person is a structure:
;   (make-person String String Boolean)

;examples
(define person1 (make-person.v2 "mark" "m" #true))
(define person2 (make-person.v2 "lory" "l" #false))


(define-struct weapon [fired? pos])
; A Weapon is one of: 
; — #false
; — Posn
; interpretation #false means the missile hasn't 
; been fired yet; a Posn means it is in flight

;examples
(define weapon1 (make-weapon #false (make-posn 0 0)))
(define weapon2 (make-weapon #true (make-posn 10 5)))
;template
(define (fn-for-weapon w)
  (... (weapon-fired? w)
   ... (posn-x (weapon-posn w))
       (posn-y (weapon-posn w))))


