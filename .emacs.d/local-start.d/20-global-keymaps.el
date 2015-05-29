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

;; All calls to global-set-key go in this file.

;; C-[TAB] switches to next window.
(global-set-key [(control tab)] 'other-window)

;; M-G gives goto-line.
(global-set-key [(meta g)] 'goto-line)

;; C-x c gives compile.
(global-set-key "\C-xc" 'compile)

;; C-x m gives man page.
(global-set-key "\C-xm" 'man)

;; C-c C-c gives comment region.
(global-set-key "\C-c\C-c" 'comment-region)

;; C-c u gives uncomment-region.
(global-set-key "\C-cu" 'uncomment-region)

;; C-[return] gives indent region.
(global-set-key [(control return)] 'indent-region)

;; C-M-r gives regexp search backward.
(global-set-key [(control meta r)]
		'isearch-backward-regexp)

;; C-x g gives magit-status.
(global-set-key "\C-xg" 'magit-status)

;; C-. gives find-tag-other-window.
(global-set-key [(control .)] 'find-tag-other-window)

;; C-M-y yanks from system clipboard instead of kill ring.
(global-set-key [(control meta y)] 'clipboard-yank)

;; C-M-w copies emacs selection to system clipboard.
(global-set-key [(control meta w)] 'clipboard-kill-ring-save)




;; Keymaps to custom functions that are defined in 15-misc-custom.el.

;; C-x C-r gives refresh buffer
(global-set-key "\C-x\C-r" 'refresh-buffer)

;; C-x O (capital o) gives new-outline.
(global-set-key "\C-xO" 'new-outline)

;; M-[tab] switches to previous window
(global-set-key [(meta tab)] 'my-previous-window)
