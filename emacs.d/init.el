(let ((init-dir (expand-file-name "init.d" user-emacs-directory)))
  (if (file-exists-p init-dir)
      (dolist (file (directory-files init-dir t "\\.el$"))
        (load file)))

  (setq custom-file (expand-file-name "emacs-customizations.el" user-emacs-directory))
  (load custom-file)
  )
