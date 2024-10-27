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

;; Customizations for C++ mode

;; Support code.  Some of this code depends on the interrogators
;; defined in misc-initialization.el
(defun insert-c++-include-file-sections ()
  (insert "// System includes\n\n")
  (insert "// STL includes\n\n")
  (insert "// Boost includes\n\n")
  (insert "// Other library includes\n\n")
  (insert "// local includes\n\n"))

(defun c++-new-test-program-skeleton ()
  "Boilerplate for new test program using the Catch framework."
  (interactive)
  (let (; save current point
	(start-point (point)))
    (insert-emacs-mode "/*" "c++")
    (insert " *\n * <file name>\n *\n * <description>\n *\n")
    (insert-source-code-copyright " *")
    (insert-license-body " *")
    (insert-author-info " *")
    (insert " *\n */\n\n")
    (insert-c++-include-file-sections)
    (insert "\n#define CATCH_CONFIG_MAIN\n")
    (insert "#include <Catch/catch.hpp>\n\n")
    (insert "using namespace std;\n\n")
    (insert "TEST_CASE(\"\", \"[]\")\n{\n\n")
    (insert "SECTION(\"\") {\n}\n")
    (insert "}\n")
    (indent-and-restore start-point (point-max))
    ))

(defun c++-new-main-program ()
  "Boilerplate for new main program."
  (interactive)
  (let (; save current point
	(start-point (point)))
    (insert-emacs-mode "/*" "c++")
    (insert " *\n * <file name>\n *\n * <description>\n *\n")
    (insert-source-code-copyright "*")
    (insert-license-body " *")
    (insert-author-info " *")
    (insert " *\n */\n\n")
    (insert-c++-include-file-sections)
    (insert "using namespace std;\n\n")
    (insert "int\nmain(const int argc,\nconst char *argv[])\n{\n}\n")
    (indent-and-restore start-point (point))
    ))


;; Use C++ mode for Arduino sketches
(add-to-list 'auto-mode-alist '("\\.pde$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.ino$" . c++-mode))
;; Use C++ mode for openscad
(add-to-list 'auto-mode-alist '("\\.scad$" . c++-mode))


;; Hooks
(add-hook 'c++-mode-hook
	  '(lambda ()
	     (setq show-trailing-whitespace t)
	     (flyspell-prog-mode)
	     ;; (flymake-mode)
	     ;; (flycheck-mode)
	     (define-key c++-mode-map "\C-cp" 'c++-new-main-program)
	     (define-key c++-mode-map "\C-cT" 'c++-new-test-program-skeleton)
             (define-key c++-mode-map "\C-c\C-[" 'comment-out-code)
             (define-key c++-mode-map "\C-c\C-]" 'uncomment-out-code)
             (define-key c++-mode-map "\C-c\C-r" 'save-and-replace-code)
             (font-lock-add-keywords nil '(("//.+OLD CODE.+$" 1 font-lock-code-comment-face t)))
	     (c-set-offset 'innamespace '0)
	     ))
