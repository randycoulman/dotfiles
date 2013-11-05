(package-initialize)

(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(setq rac-required-packages
      (list 'exec-path-from-shell
            'expand-region
            'idomenu
            'iedit
            'inf-ruby
            'markdown-mode
            'mmm-mode
            'multi-term
            'multiple-cursors
            'ruby-compilation
            'smartparens
            'yari
            'yasnippet))

(dolist (package rac-required-packages)
  (when (not (package-installed-p package))
    (package-refresh-contents)
    (package-install package)))
