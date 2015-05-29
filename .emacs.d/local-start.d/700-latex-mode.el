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

;; Support code.
(defun latex-skeleton ()
  "Boilerplate for new latex document."
  (interactive)
  (insert "\\documentclass{minimal}\n")
  (insert "\\author{Brian Davis}\n")
  (insert "\\begin{document}\n")
  (let ((entry-point (point)))
    (insert "\n\\end{document}\n")
    (goto-char entry-point)))

(defun equation-skeleton ()
  "New equation in latex."
  (interactive)
  (insert "\\begin{equation}\n")
  (let ((entry-point (point)))
    (insert "\n\\end{equation}\n")
    (goto-char entry-point)))

(defun latex-fraction ()
  "Boilerplate for a fraction in latex."
  (interactive)
  (insert "\\frac{")
  (let ((entry-point (point)))
    (insert "}{}")
    (goto-char entry-point)))

(defun latex-sqrt ()
  "Boilerplate for a square root in latex."
  (interactive)
  (insert "\\sqrt{")
  (let ((entry-point (point)))
    (insert "}")
    (goto-char entry-point)))


;; Hooks
(add-hook 'LaTeX-mode-hook
	  '(lambda ()
	       (define-key LaTeX-mode-map "\C-c l" 'latex-skeleton)
	       (define-key LaTeX-mode-map "\C-c e" 'equation-skeleton)
	       (define-key LaTeX-mode-map "\C-c f" 'latex-fraction)
	       (define-key LaTeX-mode-map "\C-c s" 'latex-sqrt)
	       ))
