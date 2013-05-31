(require 'expand-region)
(require 'iedit)
(require 'iedit-rect)

(setq tab-stop-list (number-sequence 4 200 4))
(define-key text-mode-map (kbd "<tab>") 'tab-to-tab-stop)

(add-hook 'prog-mode-hook
          '(lambda ()
             (set-fill-column 80)))
(add-hook 'prog-mode-hook 'auto-fill-mode)
(add-hook 'prog-mode-hook 'subword-mode)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(add-hook 'sgml-mode-hook
          '(lambda ()
             (local-set-key [?\C-c?\C-/] 'sgml-close-tag)))

(global-set-key (kbd "C-.") 'er/expand-region)
(global-set-key (kbd "C-,") 'er/contract-region)

(add-to-list 'auto-mode-alist '(".*_EDITMSG\\'" . text-mode))
(add-to-list 'auto-mode-alist '("svn-commit.tmp" . text-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdn\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.mdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
