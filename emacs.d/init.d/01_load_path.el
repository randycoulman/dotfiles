(let ((site-lisp-dir (expand-file-name "site-lisp" user-emacs-directory)))
  (if (file-exists-p site-lisp-dir)
      (add-to-list 'load-path site-lisp-dir)))
