;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercises-1-9) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; Exercise 1
; (x, y) are coordinates of a Cartesian point, Write down an expression
; that computes the distance of this point to the origin (0, 0)
(define x 3)
(define y 4)

(sqrt (+ (* x x) (* y y))) 

;; Exercise 2
; create an expression that concatenates prefix and suffix and adds "_" between them
(define prefix "Hello")
(define suffix "world")

(string-append prefix "_" suffix)

;; Exercise 3
; create an expression using string primitives that adds "_" at position i
(define str "helloworld")
(define i 5)

(string-append
 (substring str 0 i)
 "_"
 (substring str i (string-length str)))

;; Exercise 4
; Use the same setup as in exercise 3 to create an expression that deletes the ith
; position from str
(string-append
 (substring str 0 (- i 1))
 (substring str i (string-length str)))

;; Exercise 5
; create the image of a simple boat or tree. Make sure you can easily change the
; scale of the entire image
(define i-scale 4)
(define tree (circle (* 5 i-scale) "solid" "green"))
(define trunk (rectangle (* 3 i-scale) (* 8 i-scale) "solid" "brown"))

(overlay/xy
 tree
 (/ (image-width tree) 3) (image-height tree)
 trunk)

;; Exercise 6
; Create an expression that counts the number of pixels in the image
(define cat .)
(* (image-width cat) (image-height cat)) ;number of pixels

;; Exercise 7
; create an expression that computes whether sunny is false or friday is true
(define sunny #true)
(define friday #false)

(or (not sunny) friday)

;; Exercise 8
; Create a conditional expression that computes whether the cat image is tall
; or wide or square
(if (= (image-height cat) (image-width cat))
    "square"
    (if (> (image-height cat) (image-width cat))
        "tall"
        "wide"))
(cond [(= (image-width cat) (image-height cat)) "square"]
      [(> (image-width cat) (image-height cat)) "wide"]
      [(< (image-width cat) (image-height cat)) "tall"])

;; Exercise 9
; Then create an expression that:
; - for a String, it determines how long the String is
; - for an Image, it uses the area
; - for a Number, it uses the absolute value
; - for #true it uses 10
; - for #false it uses 20
(define in -20)

(cond [(string? in) (string-length in)]
      [(image?  in) (* (image-width in) (image-height in))]
      [(number? in) (abs in)]
      [(and (boolean? in) (= in  #true)) 10]
      [(and (boolean? in) (= in #false)) 20])