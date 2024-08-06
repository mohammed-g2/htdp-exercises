;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercises-34-38) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; Exercise 34.
; Design the function string-first, which extracts the first character
; from a non-empty string. Don’t worry about empty strings

;; String -> 1String
;; exetracts the first character from non-empty string
;; Examples:
; Given "Hello" output "H"
; Given "world" output "w"
;template
; (define (string-first s)
;   (... s ...))
(define (string-first s)
  (string-ith s 0))

; Exercise 35.
; Design the function string-last, which extracts the last character
; from a non-empty string

;; String -> 1String
;; exetracts the last character from non-empty string
;; Examples:
; Given "Hello" output "o"
; Given "worlds" output "s"
;template
;(define (string-last s)
;  (... s ...))
(define (string-last s)
  (string-ith s (- (string-length s) 1)))

; Exercise 36.
; Design the function image-area, which counts the number of pixels
; in a given image.

;; Image -> Number
;; count the number of pixels in given image img
;; Examples:
; Given (square 10 "solid" "black") output 100
; Given (rectangle 10 20 "solid" "black") output 200
;template
;(define (image-area img)
;  (... img ...))
(define (image-area img)
  (* (image-width img) (image-height img)))

; Exercise 37.
; Design the function string-rest, which produces a string like the given
; one with the first character removed.

;; String -> String
;; produce a string like the given one (str) with the first character removed
;; Examples:
; Given "Hello" output "ello"
; Given "worlds" output "orlds"
;template
;(define (string-rest str)
;  (... str ...))
(define (string-rest str)
  (substring str 1 (string-length str)))

; Exercise 38.
; Design the function string-remove-last, which produces a string like the
; given one with the last character removed.

;; String -> String
; remove the last character from given string (str)
;; Examples:
; Given "Hello" output "Hell"
; Given "worlds" output "world"
;template
;(define (string-remove-last str)
;  (... str ...))
(define (string-remove-last str)
  (substring str 0 (- (string-length str) 1)))
