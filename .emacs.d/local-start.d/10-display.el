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


;; Default display parameters.  Currently, this is the first file that
;; is loaded.

;; Eliminate the delay caused by set-default-font.
(modify-frame-parameters nil '((wait-for-wm . nil)))

;; Get rid of the bell for fuck's sake.
(setq visible-bell t)

;; Windows-style scroll bar.
(set-scroll-bar-mode 'right)

;; Don't echo passwords.
(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt)

;; Use line wrap instead of truncate for horizontally split windows.
(setq truncate-partial-width-windows nil)

;; Get rid of start up splash screen.
(setq inhibit-startup-message t)

;; Disable tool bar and menu bar.
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Display column numbers.
(setq column-number-mode t)

;; Highlight selected regions.
(transient-mark-mode t)

;; Show balanced parentheses.
(require 'paren)
(show-paren-mode 1)

;; Selected text is deleted by typing as in windows.
(delete-selection-mode t)

;; Enable erase-buffer command.
(put 'erase-buffer 'disabled nil)

;; Enable narrow-to-region command
(put 'narrow-to-region 'disabled nil)


;; Visuals.

;; Use font-lock-mode wherever it is defined.
(global-font-lock-mode 1)

;; Make font lock mode more readible in certain modes.
(set-face-foreground 'font-lock-string-face "DarkBlue")
(set-face-foreground 'font-lock-variable-name-face "Purple")

;; Correct font on startup.
(set-default-font
 "-Misc-Fixed-Medium-R-Normal--10-100-75-75-C-60-ISO8859-1")

;; White background is very hard on the eyes.
(set-background-color "LightGray")

;; Don't scroll the window when there is new output (e.g. for shell).
(setq comint-scroll-show-maximum-output nil)

;; Command history should collapse duplicates (i.e. executing the 
;; same command twice in a row and then using M-p to scroll backwards
;; through commands should only produce the command once).
(setq comint-input-ignoredups t)

;; Compilation mode next-error should skip anything less than an
;; error.
(setq compilation-skip-threshold 2)

;; Compilation mode should move the point to the end of the buffer and
;; scroll the output by default.
(setq compilation-scroll-output t)

;; Point movement should be according to logical lines instead of
;; screen lines.
(setq line-move-visual nil)
