;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercises-11-20) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; Exercise 11
; Define a function that consumes two numbers, x and y, and that computes
; the distance of point (x,y) to the origin
(define (f x y)
  (sqrt (+ (sqr x) (sqr y))))

;; Exercise 12
; Define the function cvolume, which accepts the length of a side of an equilateral
; cube and computes its volume. If you have time, consider defining csurface, too.
(define (cvolume s)
  (* s s s))

(define (csurface s)
  (* 6 (sqr s)))

;; Exercise 13
; Define the function string-first, which extracts the first 1String from a non-empty string
(define (string-first str)
  (if (> (string-length str) 0)
      (string-ith str 0)
      "empty string"))

;; Exercise 14
; Define the function string-last, which extracts the last 1String from a non-empty string
(define (string-last str)
  (if (> (string-length str) 0)
      (string-ith str (- (string-length str) 1))
      "empty string"))

;; Exercise 15
; Define ==>. The function consumes two Boolean values, call them sunny and friday. Its
; answer is #true if sunny is false or friday is true
(define (=> sunny friday)
  (or (not sunny) friday))

;; Exercise 16
; Define the function image-area, which counts the number of pixels in a given image
(define (image-area img)
  (* (image-width img) (image-height img)))

;; Exercise 17
; Define the function image-classify, which consumes an image and conditionally produces
; "tall" if the image is taller than wide
; "wide" if it is wider than tall
; "square" if its width and height are the same
(define (image-classify img)
  (cond [(= (image-width img) (image-height img)) "square"]
        [(> (image-width img) (image-height img))   "wide"]
        [(< (image-width img) (image-height img))   "tall"]))

;; Exercise 18
; Define the function string-join, which consumes two strings and appends them with "_" in between
(define (string-join str1 str2)
  (string-append str1 "_" str2))

;; Exercise 19
; Define the function string-insert, which consumes a string str plus a number i and inserts "_"
; at the ith position of str. Assume i is a number between 0 and the length of the given string (inclusive)
(define (string-insert str i)
  (string-append
   (substring str 0 i)
   "_"
   (substring str i (string-length str))))

;; Exercise 20
; Define the function string-delete, which consumes a string plus a number i and deletes the ith position from str
(define (string-delete str i)
  (string-append
   (substring str 0 i)
   (substring str (+ i 1) (string-length str))))