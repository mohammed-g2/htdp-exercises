;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercises-171-174) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)

; Exercise 171.
; You know what the data definition for List-of-strings looks like. Spell it out.
; Make sure that you can represent Piet Hein’s poem as an instance of the definition
; where each line is represented as a string and another instance where each word is
; a string. Use read-lines and read-words to confirm your representation choices.

; Next develop the data definition for List-of-list-of-strings. Again, represent Piet
; Hein’s poem as an instance of the definition where each line is represented as a list
; of strings, one per word, and the entire poem is a list of such line representations

;; Definitions:

;; List-of-strings (los) is one of:
;; - '()
;; - (cons String los)
;; interp. a representation of a file where each line is a string
;exampels
(define los0 '())
(define los1 (cons "hello world" '()))
(define los2 (cons "hello world" (cons "this is a..." '())))
;template
(define (fn-for-los los)
  (cond [(empty? los) ...]
        [else (... (first los) (fn-for-los (rest los)))]))


;; List-of-list-of-strings (llos) is one of:
;; - '()
;; - (cons los llos)
;; interp. a representation of  file where each line is a list of strings (los) and each
;; (los) have on string per field
;examples
(define llos0 '())
(define 11os1 (cons los1 '()))
(define llos2  (cons los1 (cons los0 (cons los2 '()))))
;template
(define (fn-for-llos llos)
  (cond [(empty? llos) ...]
        [else (... (fn-for-los (first llos)) (fn-for-llos (rest llos)))]))


; Exercise 172.
; Design the function collapse, which converts a list of lines into a string. The strings
; should be separated by blank spaces (" "). The lines should be separated with a newline ("\n")

;; collapse-line
;; join words on a list of stirngs with a space
;; los -> String
(check-expect (collapse-line '()) "")
(check-expect (collapse-line (cons "hello" '())) "hello")
(check-expect (collapse-line (cons "hello" (cons "world" (cons "again" '())))) "hello world again")
(define (collapse-line los)
  (cond [(empty? los) ""]
        [(empty? (rest los)) (first los)]
        [else (string-append (first los) " " (collapse-line (rest los)))]))

;; collapse
;; converts a list of lines into a string. strings should be separated by blank spaces (" ").
;; The lines should be separated with a newline ("\n")
;; llos -> String
(check-expect (collapse '()) "")
(check-expect (collapse 11os1) "hello world\n")
(check-expect (collapse llos2) "hello world\n\nhello world this is a...\n")
(define (collapse llos)
  (cond [(empty? llos) ""]
        [else (string-append (collapse-line (first llos)) "\n" (collapse (rest llos)))]))

; Exercise 173.
; Design a program that removes all articles from a text file. The program consumes the name
; n of a file, reads the file, removes the articles, and writes the result out to a file whose
; name is the result of concatenating "no-articles-" with n. For this exercise, an article is
; one of the following three words: "a", "an", and "the".

;; remove-articles-line
;; remove articles "a", "an", "the" from given los
;; los -> los
(check-expect (remove-articles-line '()) '())
(check-expect (remove-articles-line (list "hey" "there")) (list "hey" "there"))
(check-expect (remove-articles-line (list "not" "a" "chance" "that" "the" "..." "an" "octopus"))
              (list "not" "chance" "that" "..." "octopus"))
(define (remove-articles-line los)
  (cond [(empty? los) '()]
        [else (if (or
                   (string=? (first los) "a")
                   (string=? (first los) "an")
                   (string=? (first los) "the"))
                  (remove-articles-line (rest los))
                  (cons (first los) (remove-articles-line (rest los))))]))
;; remove-articles
;; removes "a", "an", and "the" from given list of lists of string
;; llos -> llos
(check-expect (remove-articles '()) '())
(check-expect (remove-articles (list
                                 (list "this" "is" "a" "...")
                                 (list "and" "the" "was" "...")
                                 (list "yet" "an" "octopus" "happend" "...")))
               (list
                (list "this" "is" "...")
                (list "and" "was" "...")
                (list "yet" "octopus" "happend" "...")))

(define (remove-articles llos)
  (cond [(empty? llos) '()]
        [else (cons (remove-articles-line (first llos)) (remove-articles (rest llos)))]))

;; no-articles
;; remove all articles "a", "an", and "the" form given file (n), then writes the result to
;; a file name "no-articles-<name>"
;; String -> String

(define (no-articles n)
  (write-file (string-append n ".dat")
              (collapse (remove-articles (read-words/line n)))))


; Exercise 174.
; Design a program that encodes text files numerically. Each letter in a word should be
; encoded as a numeric three-letter string with a value between 0 and 256.

;; encode-word
;; encode a word
;; String -> String
(check-expect (encode-word '()) "")
;(check-expect (encode-word (list "")) (list ""))
(check-expect (encode-word (string->list "hell"))
              (string-append
               (number->string (string->int "h"))
               (number->string (string->int "e"))
               (number->string (string->int "l"))
               (number->string (string->int "l"))))
(define (encode-word w)
  (cond [(empty? w) ""]
        [else (string-append (number->string (char->integer (first w))) (encode-word (rest w)))]))

;; encode-line
;; encode list of strings (los)
;; los -> los
(check-expect (encode-line '()) '())
(check-expect (encode-line (list "ab" "b" "c"))
              (list (string-append (number->string (string->int "a")) (number->string (string->int "b")))
                    (number->string (string->int "b"))
                    (number->string (string->int "c"))))
(define (encode-line los)
  (cond [(empty? los) los]
        [else (cons (encode-word (string->list (first los))) (encode-line (rest los)))]))

;; encode-lines
;; encode list of list of strings (llos)
;; llos -> llos
(check-expect (encode-lines '()) '())
(check-expect (encode-lines (list
                             (list "a" "b")
                             (list "c" "d")))
              (list
               (list (number->string (string->int "a")) (number->string (string->int "b")))
               (list (number->string (string->int "c")) (number->string (string->int "d")))))
(define (encode-lines llos)
  (cond [(empty? llos) llos]
        [else (cons (encode-line (first llos)) (encode-lines (rest llos)))]))

;; encode
;; encodes text files numerically, n is a filename
;; String -> String
(define (encode filename)
  (write-file (string-append filename ".encoded")
              (collapse (encode-lines (read-words/line filename)))))