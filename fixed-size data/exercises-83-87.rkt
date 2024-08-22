;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercises-83-87) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t
;template
(define (fn-for-editor ed)
  (... (editor-pre ed)
       ... (editor-post ed)))

; Exercise 83.
; Design the function render, which consumes an Editor and
; produces an image.

;constants
(define BG (empty-scene 200 20))
(define cursor (rectangle 1 20 "solid" "red"))

;; render
;; render the editor
;; Editor -> Image
(check-expect (render (make-editor "hello" " world")) (overlay/align "left" "center"
                 (beside/align "bottom"
                         (text "hello" 11 "black")
                         cursor
                         (text " world" 11 "black"))
               (empty-scene 200 20)))
(define (render e)
  (overlay/align "left" "center"
                 (beside/align "bottom"
                         (text (editor-pre e) 11 "black")
                         cursor
                         (text (editor-post e) 11 "black"))
               (empty-scene 200 20)))

; Exercise 84.
; Design edit. The function consumes two inputs, an
; editor ed and a KeyEvent ke, and it produces another
; editor. Its task is to add a single-character KeyEvent
; ke to the end of the pre field of ed, unless ke denotes
; the backspace ("\b") key. In that case, it deletes the
; character immediately to the left of the cursor (if
; there are any). The function ignores the tab key ("\t")
; and the return key ("\r").

; Exercise 86.
; Notice that if you type a lot, your editor program does
; not display all of the text. Instead the text is cut off
; at the right margin. Modify your function edit from exercise
; 84 so that it ignores a keystroke if adding it to the end of
; the pre field would mean the rendered text is too wide for your canvas.

;; edit
;; consume editor ed and key-event ke and adds a single character
;; ke key event to the end of pre field of ed, unless ke is
;; "\b" then delete the last character of pre, and ignore "\t" and "\r"
;; Editor 1String -> Editor
(check-expect (edit (make-editor "hello" "world") "a") (make-editor "helloa" "world"))
(check-expect (edit (make-editor "" "world") "a") (make-editor "a" "world"))
(check-expect (edit (make-editor "" "world") "\b") (make-editor "" "world"))
(check-expect (edit (make-editor "a" "world") "\b") (make-editor "" "world"))
(check-expect (edit (make-editor "hello" "world") "\b") (make-editor "hell" "world"))
(check-expect (edit (make-editor "hello" "world") "\t") (make-editor "hello" "world"))
(check-expect (edit (make-editor "hello" "world") "\r") (make-editor "hello" "world"))
(check-expect
 (edit (make-editor "1234567890 1234567890 1234567890" "") "a")
 (make-editor "1234567890 1234567890 1234567890" ""))
(check-expect
 (edit (make-editor "" "1234567890 1234567890 1234567890") "a")
 (make-editor "" "1234567890 1234567890 1234567890"))
(define (edit ed ke)
  (cond [(string=? "\t" ke) ed]
        [(string=? "\r" ke) ed]
        [(string=? "\b" ke) (if (< (string-length (editor-pre ed)) 1)
                                ed
                                (make-editor (substring
                                          (editor-pre ed)
                                          0
                                          (- (string-length (editor-pre ed)) 1))
                                         (editor-post ed)))]
        [(>= (string-length (string-append (editor-pre ed) (editor-post ed))) 32) ed]
        [else (make-editor (string-append (editor-pre ed) ke) (editor-post ed))]))

; Exercise 85.
; Define the function run. Given the pre field of an editor, it
; launches an interactive editor, using render and edit from the
; preceding two exercises for the to-draw and on-key clauses, respectively

;; run
;; launches an interactive editor
;; Editor -> Editor
(define (run ed)
  (big-bang ed
    [to-draw render]
    [on-key edit]))

;(run (make-editor "hello" "world"))

; Exercise 87.
; Develop a data representation for an editor based on our first
; idea, using a string and an index. Then solve the preceding
; exercises again. Retrace the design recipe.

(define-struct editor.v2 [str index])
;; editor is (make-editor String Number)
;; interp. index is the position of the cursor

;; render.v2
;; render the editor
;; Editor -> Image
(check-expect (render.v2 (make-editor.v2 "hello world" 5)) (overlay/align "left" "center"
                 (beside/align "bottom"
                         (text "hello" 11 "black")
                         cursor
                         (text " world" 11 "black"))
               (empty-scene 200 20)))
(define (render.v2 ed)
  (overlay/align "left" "center"
                 (beside/align "bottom"
                               (text (substring
                                      (editor.v2-str ed)
                                      0
                                      (editor.v2-index ed)) 11 "black")
                               cursor
                               (text (substring
                                      (editor.v2-str ed)
                                      (editor.v2-index ed)
                                      (string-length (editor.v2-str ed))) 11 "black"))
                 (empty-scene 200 20)))

;; edit.v2
;; consume editor ed and key-event ke and adds a single character
;; ke key event to the end of pre field of ed, unless ke is
;; "\b" then delete the last character of pre, and ignore "\t" and "\r"
;; Editor 1String -> Editor
(check-expect (edit.v2 (make-editor.v2 "hello world" 5) "a") (make-editor.v2 "helloa world" 6))
(check-expect (edit.v2 (make-editor.v2 "world" 0) "a") (make-editor.v2 "aworld" 1))
(check-expect (edit.v2 (make-editor.v2 "world" 0) "\b") (make-editor.v2 "world" 0))
(check-expect (edit.v2 (make-editor.v2 "aworld" 1) "\b") (make-editor.v2 "world" 0))
(check-expect (edit.v2 (make-editor.v2 "hello world" 5) "\b") (make-editor.v2 "hell world" 4))
(check-expect (edit.v2 (make-editor.v2 "hello world" 1) "\t") (make-editor.v2 "hello world" 1))
(check-expect (edit.v2 (make-editor.v2 "hello world" 1) "\r") (make-editor.v2 "hello world" 1))
(check-expect
 (edit.v2 (make-editor.v2 "1234567890 1234567890 1234567890" 1) "a")
 (make-editor.v2 "1234567890 1234567890 1234567890" 1))
(check-expect
 (edit.v2 (make-editor.v2 "1234567890 1234567890 1234567890" 32) "a")
 (make-editor.v2 "1234567890 1234567890 1234567890" 32))
(define (edit.v2 ed ke)
  (cond [(string=? ke "\t") ed]
        [(string=? ke "\r") ed]
        [(and (string=? ke "\b") (= (editor.v2-index ed) 0)) ed]
        [(>= (string-length (editor.v2-str ed)) 32) ed]
        [(string=? ke "\b") (make-editor.v2
                             (string-append
                              (substring (editor.v2-str ed) 0 (- (editor.v2-index ed) 1))
                              (substring (editor.v2-str ed) (editor.v2-index ed) (string-length (editor.v2-str ed))))
                             (- (editor.v2-index ed) 1))]
        [else (make-editor.v2
               (string-append
                (substring (editor.v2-str ed) 0 (editor.v2-index ed))
                ke
                (substring (editor.v2-str ed) (editor.v2-index ed) (string-length (editor.v2-str ed))))
               (+ (editor.v2-index ed) 1))]))

;; run
;; launches an interactive editor
;; Editor -> Editor
(define (run.v2 ed)
  (big-bang ed
    [to-draw render.v2]
    [on-key edit.v2]))

;(run.v2 (make-editor.v2 "hello world" 5))