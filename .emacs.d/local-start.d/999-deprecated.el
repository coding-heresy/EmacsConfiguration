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


;; Deprecated code from the period before this project was under
;; source code control.



;; Support code for interactive functions

;; HISTORICAL NOTE: early attempt at building something like a wizard
;; for quickly generating skeletons since the various skeleton
;; libraries are poorly documented and difficult to use.

;; interrogators returns three functions: a function that asks a
;; yes/no question to the user and returns t/nil based on the answer;
;; a function that asks the user for a free form string, which it
;; returns; and a function that returns nil if any previous invocation
;; of one of the first two functions received erroneous input from the
;; user, or t otherwise.
;; (defun interrogators ()
;;   (lexical-let ((continue-p t))
;;     (values (lambda (arg)
;; 	      (let ((answer (read-string (concat arg " [y/n]? "))))
;; 		(cond ((string= answer "y") t)
;; 		      ((string= answer "n") nil)
;; 		      (t (progn
;; 			   (message (concat "'" arg "' must by 'y' or 'n'"))
;; 			   (setq continue-p nil)
;; 			   nil)))))
;; 	    (lambda (arg)
;; 	      (let ((answer (read-string (concat arg "? "))))
;; 		(if (string= answer "")
;; 		    (progn
;; 		      (message (concat arg " must not be empty"))
;; 		      (setq continue-p nil)
;; 		      nil)
;; 		  answer)))
;; 	    (lambda () continue-p))))

;; ;; Macros that simplify logic of using interrogators.  NOTE: variable
;; ;; capture in with-interrogators is intentional and is mirrored by use
;; ;; of the captured variables in subsequent macros in this section.
;; ;; Very unhygienic.

;; (defmacro with-interrogators (&rest body)
;;   `(multiple-value-bind (yes-no freeform continue-p)
;; 	(interrogators)
;;     (progn ,@body)))

;; (defmacro yes-no-q (str pred)
;;   `(if (funcall yes-no ,str)
;;        (setq ,pred t)))

;; (defmacro yes-no-if-continue (str pred)
;;   `(if (funcall continue-p)
;;        (if (funcall yes-no ,str)
;; 	   (setq ,pred t))))

;; (defmacro freeform-q (str result)
;;   `(setq ,result (funcall freeform ,str)))

;; (defmacro freeform-if-continue (str result)
;;   `(if (funcall continue-p)
;;        (setq ,result (funcall freeform ,str))))

;; (defmacro get-namespace (result-predicate result-value)
;;   `(if (funcall yes-no "Use namespace (e.g. std)")
;;        (progn
;; 	 (setq ,result-predicate t)
;; 	 (setq ,result-value (funcall freeform "Namespace")))
;;      (progn
;;        (setq ,result-predicate nil)
;;        (setq ,result-value nil))))


;; Various other code, some of which uses the interrogator code

;; (defun c++-new-class-header-skeleton ()
;;   "Boilerplate for new class header."
;;   (interactive)
;;   (let (; save current point
;; 	(start-point (point))
;; 	(namespace-p nil)
;; 	(namespace nil)
;; 	(classname nil))
;;     (with-interrogators
;;      ;; Determine whether to use namespace.
;;      (get-namespace namespace-p namespace)
;;      ;; Determine class name.
;;      (freeform-if-continue "Class name" classname)
;;      (if (funcall continue-p)
;; 	 ;; Insert appropriate text in the buffer.
;; 	 (progn
;; 	   (insert-c++-copyright)
;; 	   ;; Compiler directives to prevent multiple includes.
;; 	   (insert "#ifndef " (upcase classname) "_HEADER\n")
;; 	   (insert "#define " (upcase classname) "_HEADER\n\n")
;; 	   ;; namespace
;; 	   (if namespace-p
;; 	       (insert "namespace " namespace "\n{\n"))
;; 	   ;; class definition.
;; 	   (insert "class " classname "\n{\n")
;; 	   (insert "public:\n")
;; 	   (insert "protected:\n")
;; 	   (insert "private:\n")
;; 	   (insert "};\n")
;; 	   (if namespace-p
;; 	       (insert "};\n"))
;; 	   ;; Terminate compiler directive.
;; 	   (insert "\n#endif")
;; 	   ;; Indent and restore point.
;; 	   (indent-region start-point (point) nil)
;; 	   (goto-char start-point))))))

;; (defun c++-new-class-implementation-skeleton ()
;;   "Boilerplate for new class implementation."
;;   (interactive)
;;   (let (; save current point
;; 	(namespace-p nil)
;; 	(namespace nil)
;; 	(classname nil)
;; 	(start-point (point)))
;;     (with-interrogators
;;      ;; Determine whether to use namespace.
;;      (get-namespace namespace-p namespace)
;;      ;; Determine class name.
;;      (freeform-if-continue "Class name" classname)
;;      (if (funcall continue-p)
;; 	 ;; Insert appropriate text in the buffer.
;; 	 (progn
;; 	   (insert-c++-copyright)
;; 	   ;; Sections for include files
;; 	   (insert-c++-include-file-sections)
;; 	   ;; namespace
;; 	   (if namespace-p
;; 	       (insert "using namespace " namespace ";\n\n"))
;; 	   ;; constructor
;; 	   (insert classname "::" classname "() {\n}\n\n")
;; 	   ;; destructor
;; 	   (insert classname "::~" classname "() {\n}\n")
;; 	   ;; indent and restore point.
;; 	   (indent-region start-point (point) nil)
;; 	   (goto-char start-point))))))

;; ;; In progress.  Should eventually be integrated with
;; ;; c++-new-main-program.
;; (defun c++-new-test-program-skeleton ()
;;   "Boilerplate for new test program using boost::test."
;;   (interactive)
;;   (let (; save current point
;; 	(start-point (point)))
;;     (insert-include-file-sections)
;;     (insert "BOOST_AUTO_TEST_CASE(/* test name */)\n{\n}\n")
;;     ;; Add BOOST_TEST_MAIN definition and Boost unit test include file
;;     ;; into the previously inserted include block for Boost.
;;     (save-excursion
;;       (if (re-search-backward "Boost includes")
;; 	  (progn
;; 	    (forward-line)
;; 	    (insert "#define BOOST_TEST_MAIN\n")
;; 	    (insert "#include <boost/test/included/unit-test.hpp>\n"))))
;;     (indent-and-restore start-point (point-max))
;;     ))

;; ;; In progress
;; (defun c++-new-main-program ()
;;   "Boilerplate for new main program."
;;   (interactive)
;;   (let (; save current point
;; 	(start-point (point))
;; 	(using-std-namespace-p nil))
;;     ;; Build interrogators
;;     (with-interrogators
;;      (yes-no-q "Use std namespace" using-std-namespace-p)
;;      (if (funcall continue-p)
;; 	 (progn
;; 	   (insert-c++-copyright)
;; 	   (insert-c++-include-file-sections)
;; 	   (if using-std-namespace-p
;; 	       (insert "using namespace std;\n\n"))
;; 	   (insert "int main(int argc, const char *argv[]) {\n}\n")
;; 	   (indent-and-restore start-point (point)))))))

;; (defun new-perl-skeleton ()
;;   "Boilerplate for new Perl script."
;;   (interactive)
;;   (let* (; save current point
;; 	 (start-point (point))
;; 	 (options-p nil))
;;     (with-interrogators
;;      (yes-no-if-continue "Command line options" options-p)
;;      (if (funcall continue-p)
;; 	 (progn
;; 	   (insert "#!/usr/bin/perl -w\n\n")
;; 	   ;; libraries
;; 	   (if options-p
;; 	       (insert "use Getopt::Std;\n"))
;; 	   (insert "use strict;\n\n")
;; 	   ;; usage subroutine
;; 	   (insert "sub usage {\n")
;; 	   (insert "print STDERR \"Usage: $0")
;; 	   (if options-p
;; 	       (progn
;; 		 (insert " [options]")
;; 		 (insert "\\n\";\nprint STDERR \"where [options] ")
;; 		 (insert "are: \\n\";\n")
;; 		 (insert "print STDERR \"\\t-h print usage")))
;; 	   (insert "\\n\";\nexit(1);\n}\n\n")
;; 	   ;; main subroutine
;; 	   (insert "sub main {\n")
;; 	   (if options-p
;; 	       (progn
;; 		 (insert "my %opts;\n")
;; 		 (insert "getopts(\"h\", \\%opts);\n")
;; 		 (insert "if (exists($opts{\"h\"})) {\nusage();\n}\n")))
;; 	   (insert "}\n\nmain;\n")
;; 	   (indent-region start-point (point) nil)
;; 	   (goto-char start-point))))))

;; (defun c++-new-makefile-skeleton ()
;;   "Boilerplate for new Makefile for C++ code."
;;   (interactive)
;;   (let (; save current point
;; 	(start-point (point))
;; 	(project nil)
;; 	(program nil)
;; 	(library-base nil)
;; 	(boost-p nil)
;; 	(boost-libraries-p nil)
;; 	(wt-p nil)
;; 	(wt-local-httpd nil)
;; 	(quantlib-p nil)
;; 	(make-one-program-p nil)
;; 	(make-one-library-p nil)
;; 	(target-var-name nil)
;; 	(object-var-name nil)
;; 	(include-local-p nil)
;; 	; TODO: add a variable for a list of objects/binaries
;; 	)
;;     ;; Build interrogators.
;;     (with-interrogators
;;      (freeform-q "Project name" project)
;;      (yes-no-if-continue "Use boost" boost-p)
;;      (if boost-p
;; 	 (yes-no-if-continue "Use boost libraries" boost-libraries-p))
;;      (yes-no-if-continue "Use Wt" wt-p)
;;      (if wt-p
;; 	 (yes-no-if-continue "Use local httpd for Wt" wt-local-httpd-p))
;;      (yes-no-if-continue "Use quantlib" quantlib-p)
;;      (yes-no-if-continue "Make one program" make-one-program-p)
;;      (if make-one-program-p
;; 	 (progn
;; 	   (freeform-if-continue "Program name" program)
;; 	   (if program
;; 	       (progn
;; 		 (setq target-var-name "PROGRAM")
;; 		 (setq object-var-name "PROGRAM_OBJECTS"))))
;;        (yes-no-if-continue "Make one library" make-one-library-p))
;;      (if make-one-library-p
;; 	 (progn
;; 	   (freeform-if-continue "Library base name" library-base)
;; 	   (setq target-var-name "LIBRARY_BASE_NAME")
;; 	   (setq object-var-name "LIBRARY_OBJECTS")))
;;      (yes-no-if-continue "Use local directory include files"
;; 			 include-local-p)
;;      (if (funcall continue-p)
;; 	 ;; Generate Makefile.
;; 	 (progn
;; 	   ;; Base directory and project directory.
;; 	   (insert "BASE_DIR = " base-src-dir "/c++\n")
;; 	   (insert (upcase project) "_DIR = $(BASE_DIR)/" project "\n")
;; 	   ;; Base directory includes
;; 	   (if boost-p
;; 	       (insert "include $(BASE_DIR)/Makefile.boost\n"))
;; 	   (if wt-p
;; 	       (insert "include $(BASE_DIR)/Makefile.wt\n"))
;; 	   (if quantlib-p
;; 	       (insert "include $(BASE_DIR)/Makefile.quantlib\n"))
;; 	   ;; Macros for binary/library and object targets.
;; 	   (if target-var-name
;; 	       (progn
;; 		 (insert "\n" target-var-name "=")
;; 		 (if program
;; 		     (insert program "\n")
;; 		   (if library-base
;; 		       (insert library-base "\n")
;; 		     (if make-one-program-p
;; 			 (insert "# Add program here.\n")
;; 		       (if make-one-library-p
;; 			   (insert "# Add library base name here.\n")))))))
;; 	   (if object-var-name
;; 	       (progn
;; 		 (insert "\n" object-var-name "=")
;; 		 (if program
;; 		     (insert program ".o\n")
;; 		   (if library-base
;; 		       (insert library-base ".o\n")
;; 		     (if make-one-program-p
;; 			 (insert "# Add program objects here.")
;; 		       (if make-one-library-p
;; 			   (insert "# Add library objects here.\n")))))))
;; 	   ;; Flags.
;; 	   (insert "\nINCLUDES=")
;; 	   (if boost-p
;; 	       (insert "-I$(BOOST_INCLUDE_DIRS)"))
;; 	   (if wt-p
;; 	       (insert " -I$(WT_INCLUDE_DIRS)"))
;; 	   (if quantlib-p
;; 	       (insert " -I$(QUANTLIB_INCLUDE_DIRS)"))
;; 	   (if include-local-p
;; 	       (insert " -I$(" (upcase project) "_DIR)"))
;; 	   (insert "\n")
;; 	   (if boost-libraries-p
;; 	       (insert "\nBOOST_LIBS= # Add Boost libraries here\n"))
;; 	   (if wt-p
;; 	       (progn
;; 		 (insert "\nWT_LIBS=-lwt ")
;; 		 (if wt-local-httpd-p
;; 		     (insert "-lwthttp")
;; 		   (insert "-lwtfcgi"))
;; 		 (insert " -lz\n")))
;; 	   (if quantlib-p
;; 	       (insert "\nQUANTLIB_LIBS=-lQuantLib\n"))
;; 	   (if (not make-one-library-p)
;; 	       (progn
;; 		 (insert "\nLIBRARIES=")
;; 		 (if boost-libraries-p
;; 		     (insert " -L$(BOOST_LIB_DIRS) $(BOOST_LIBS)"))
;; 		 (if wt-p
;; 		     (insert " -L$(WT_LIB_DIRS) $(WT_LIBS)"))
;; 		 (if quantlib-p
;; 		     (insert " -L$(QUANTLIB_LIB_DIRS) $(QUANTLIB_LIBS)"))
;; 		 (insert "\n")))
;; 	   (insert "\nBUILD_FLAGS=-g\n")
;; 	   (insert "\nWARNING_FLAGS=-Wall -Wcomments\n")
;; 	   ;; Targets
;; 	   (insert "\n.PHONY: all clean")
;; 	   (if make-one-program-p
;; 	       ;; Phony targets for building one program.
;; 	       (progn
;; 		 (insert "\nall: $(PROGRAM)\n")
;; 		 (insert "\nclean:\n\trm -f $(PROGRAM) ")
;; 		 (insert "$(PROGRAM_OBJECTS) *.P *~ *.a"))
;; 	     (if make-one-library-p
;; 		 (progn
;; 		   (insert "\nall: $(TARGET_LIBRARY)\n")
;; 		   (insert "\nclean:\n\trm -f $(TARGET_LIBRARY) ")
;; 		   (insert "$(LIBRARY_OBJECTS) *.P *~ *.a"))
;; ;; 	       ;; Phony targets for building multiple programs.
;; ;; 	       (progn
;; ;; 		 (insert "\nall: $(BINARIES)\n")
;; ;; 		 (insert "\nclean:\n\trm -f $(" (upcase project))
;; ;; 		 (insert "_OBJECTS) "))
;; 	       ))
;; 	   (insert "*.P *~ *.a\n")
;; 	   ;; Dependency builder
;; 	   (insert "\n# Autobuild dependencies, see Makefile.std ")
;; 	   (insert "for details.\n")
;; 	   (if object-var-name
;; 	       (insert "-include $(" object-var-name ":.o=.P)\n"))
;; 	   (insert "\ninclude $(BASE_DIR)/Makefile.std\n")
;; 	   (if make-one-program-p
;; 	       (insert "\ninclude $(BASE_DIR)/Makefile.makeoneprogram\n"))
;; 	   (if make-one-library-p
;; 	       (insert "\ninclude $(BASE_DIR)/Makefile.makeonelibrary\n"))
;; 	   ;; Restore point, no need to indent Makefiles.
;; 	   (goto-char start-point))))))


;; Initialization that is no longer required but may be useful again
;; in the future




;; LISP mode

;; Basic initialization.
;;(setq inferior-lisp-program "/usr/bin/sbcl")

;; Using slime for lisp interaction.
;; (add-to-list 'load-path "/usr/share/common-lisp/source/slime")
;; (require 'slime)
;; (slime-setup)

;; Hooks
;; (add-hook 'slime-mode-hook
;; 	  '(lambda ()
;; 	     (define-key slime-mode-map "\C-c\C-c" 'comment-region)))

;; (add-hook 'slime-mode-hook 'flyspell-prog-mode)

;; (add-hook 'emacs-lisp-mode
;; 	  '(lambda ()
;; 	     (define-key emacs-lisp-mode-map "\C-j" 'eval-last-sexp)))




;; Java mode

;; ;; Suraj Acharya's code to properly indent java code in the presence
;; ;; of annotations.
;; (require 'java-mode-indent-annotations)

;; ;; David Ponce's code to automatically build Makefiles for Java
;; ;; projects.
;; ;;(require 'jmaker)

;; ;; JDE templates are allowed to prompt for insertion items.
;; (setq tempo-interactive 1)

;; ;; Hooks

;; ;; See comments in java-mode-indent-annotations.el
;; (add-hook 'java-mode-hook
;; 	  '(lambda ()
;; 	     (java-mode-indent-annotations-setup)
;; 	     ))

;; ;; See comments in java-mode-indent-annotations.el
;; (add-hook 'jde-mode-hook
;; 	  '(lambda ()
;; 	     (java-mode-indent-annotations-setup)
;; 	     (define-key jde-mode-map "\M-;" 'jde-complete-minibuf)
;; 	     ))



;; Makefile mode

;; Hooks
;; (add-hook 'makefile-mode-hook
;; 	  '(lambda ()
;; 	     (define-key makefile-mode-map "\C-cn"
;; 	       'c++-new-makefile-skeleton)
;; 	     ))
