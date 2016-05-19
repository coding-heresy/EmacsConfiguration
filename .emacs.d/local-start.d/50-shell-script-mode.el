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

;; Customizations for shell script mode

(defun new-shell-script ()
    "Boilerplate for new shell script"
  (interactive)
  (let (; save current point
        (start-point (point)))
    (insert "#!/bin/bash\n\n")
    (insert "function usage\n{\n/bin/echo \"usage $0: \"\nexit 1\n}\n")
    (indent-and-restore start-point (point-max))
    ))

(add-hook 'sh-mode-hook
	  '(lambda ()
	     (setq show-trailing-whitespace t)
	     (define-key sh-mode-map "\C-cp" 'new-shell-script)
	     ;; Default mapping for "C-c C-c" has something to do with
	     ;; case statements.
	     (define-key sh-mode-map "\C-c\C-c" 'comment-region)
	     ))
