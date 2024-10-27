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

;; Initialization code that does not seem to go anywhere else.

;; New default compile command.
(setq compile-command "bazel build -c dbg ...")

;; Enable upcase-region command.
(put 'upcase-region 'disabled nil)

(if *has-flymake-cursor*
    ;; Use flymake-cursor
    (load "flymake-cursor.el")
  )

;; Use packages from melpa-stable
(require 'package)
(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/") t)

;; Configuration for bazel
(require 'bazel)
(add-to-list 'auto-mode-alist '("^BUILD$" . bazel-mode))
(add-to-list 'auto-mode-alist '("^BUILD.bazel$" . bazel-mode))
(add-to-list 'auto-mode-alist '("^MODULE$" . bazel-mode))
(add-to-list 'auto-mode-alist '("^MODULE.bazel$" . bazel-mode))
(add-to-list 'auto-mode-alist '("^\\.bazelrc$" . bazel-mode))
(add-to-list 'auto-mode-alist '("\\.bzl$" . bazel-mode))

;; Don't jump to bazel-specific errors in the *compilation* window
(require 'compile)
(add-to-list 'compilation-transform-file-match-alist '("BUILD.bazel" nil))
(add-to-list 'compilation-transform-file-match-alist '("BUILD" nil))
