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


;; Miscellaneous global customization functions used by subsequent
;; code go here.  Note: customization functions that are specific to
;; modes go in the initialization file for that mode.


;; Functions that are linked directly to key sequences.

(defun my-previous-window ()
  "Switch to previous window in canonical ordering."
  (interactive)
  (other-window -1))

;; I can never remember the boilerplate for specifying outline mode.
;; NOTE: this code does not work correctly if region is narrowed.
(defun new-outline ()
  "Boilerplate for new outline."
  (interactive)
  (let (; save current point
	(start-point (point)))
    (goto-char (point-min))
    (insert "-*- Mode: Outline -*-\n\n")
    (goto-char start-point)
    (outline-mode)))

(defun refresh-buffer ()
  "Refresh the buffer from the disk, prompt if buffer modified."
  (interactive)
  (revert-buffer t (not (buffer-modified-p)) t))

(defun comment-out-code (beg end &optional arg)
  "Comment out a region of code"
  (interactive "*r\nP")
  (let ((old-comment-start comment-start))
    (setq comment-start (concat comment-start "TODO: OLD CODE"))
    (comment-region beg end arg)
    (setq comment-start old-comment-start)))

(defun uncomment-out-code (beg end &optional arg)
  "Uncomment out a region of code"
  (interactive "*r\nP")
  (let ((old-comment-start comment-start))
    (setq comment-start (concat comment-start "TODO: OLD CODE"))
    (uncomment-region beg end arg)
    (setq comment-start old-comment-start)))

(defun save-and-replace-code (beg end &optional arg)
  "comment out a region of code to save it, then paste a copy of it for modification"
  (interactive "*r\nP")
  (copy-region-as-kill beg end)
  (let ((old-end end))
    (goto-char (- end 1))
    (comment-out-code beg old-end))
  (forward-line)
  (let ((new-beg (point))
        (new-end (+ (point) (- end beg))))
    (yank)
    (indent-and-restore new-beg new-end)))



;; Functions used in more than one other mode

;; Indent the currently selected region and return the cursor to the
;; start point of the indentation
(defun indent-and-restore (start-point this-point)
  (indent-region start-point this-point nil)
  (goto-char start-point))

(defun insert-license-body (line-prefix)
  (insert line-prefix " All Rights Reserved\n")
  (insert line-prefix "\n")
  (insert line-prefix " Redistribution and use in source and binary forms, with or without\n")
  (insert line-prefix " modification, are permitted provided that the following conditions are\n")
  (insert line-prefix " met:\n")
  (insert line-prefix "\n")
  (insert line-prefix " 1. Redistributions of source code must retain the above copyright\n")
  (insert line-prefix "    notice, this list of conditions and the following disclaimer.\n")
  (insert line-prefix "\n")
  (insert line-prefix " 2. Redistributions in binary form must reproduce the above copyright\n")
  (insert line-prefix "    notice, this list of conditions and the following disclaimer in the\n")
  (insert line-prefix "    documentation and/or other materials provided with the distribution.\n")
  (insert line-prefix "\n")
  (insert line-prefix " THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS\n")
  (insert line-prefix " \"AS IS\" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT\n")
  (insert line-prefix " LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR\n")
  (insert line-prefix " A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT\n")
  (insert line-prefix " HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,\n")
  (insert line-prefix " SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT\n")
  (insert line-prefix " LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,\n")
  (insert line-prefix " DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY\n")
  (insert line-prefix " THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT\n")
  (insert line-prefix " (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE\n")
  (insert line-prefix " OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.\n")
  (insert line-prefix "\n")
)

(defun insert-emacs-mode (commentBegin mode)
  (insert commentBegin "* -*- mode: " mode " -*-\n"))

(defun insert-source-code-copyright (prefix)
  (insert prefix " " *copyright-str* "\n"))

(defun insert-author-info (prefix)
  (insert prefix " Author: " *user-name* " <" *user-mail-address* ">\n"))
