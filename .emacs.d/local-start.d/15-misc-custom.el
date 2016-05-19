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
    (setq comment-start (concat comment-start "@todo: OLD CODE"))
    (comment-region beg end arg)
    (setq comment-start old-comment-start)))

(defun uncomment-out-code (beg end &optional arg)
  "Uncomment out a region of code"
  (interactive "*r\nP")
  (let ((old-comment-start comment-start))
    (setq comment-start (concat comment-start "@todo: OLD CODE"))
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
