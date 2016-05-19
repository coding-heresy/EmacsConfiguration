;;
;; Copyright (C) 2015 Brian Davis
;;
;; Author: Brian Davis <bd@jollyrogerlabs.com>
;;
;; Permission is hereby granted, free of charge, to any person obtaining a copy
;; of this software and associated documentation files (the "Software"), to deal
;; in the Software without restriction, including without limitation the rights
;; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
;; copies of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:

;; The above copyright notice and this permission notice shall be included in
;; all copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
;; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
;; THE SOFTWARE.

;; Customizations for C mode

;; Support code.
(defun insert-c-include-files-sections()
  (insert "/* Standard library includes */\n\n")
  (insert "/* System includes */\n\n")
  (insert "/* local includes */\n\n"))

(defun insert-c-copyright ()
  (insert "/* " copyright-str " */\n\n"))

;; Interactive functions.
(defun c-new-main-program ()
  "Boilerplate for new main program."
  (interactive)
  (let (;; save current point for later use in indentation
	(start-point (point)))
    (insert-c-copyright)
    (insert-c-include-files-sections)
    (insert "int\nmain(int argc,\nconst char *argv[])\n{\n}\n")
    (indent-and-restore start-point (point))))


;; Hooks
(add-hook 'c-mode-hook
	  '(lambda ()
	     (setq show-trailing-whitespace t)
	     (flyspell-prog-mode)
	     (flymake-mode)
	     (define-key c-mode-map "\C-cp" 'c-new-main-program)
             (define-key c-mode-map "\C-c\C-[" 'comment-out-code)
             (define-key c-mode-map "\C-c\C-]" 'uncomment-out-code)
             (define-key c-mode-map "\C-c\C-r" 'save-and-replace-code)
 	     ))
