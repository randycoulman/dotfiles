(setq tab-stop-list (number-sequence 4 200 4))
(define-key text-mode-map (kbd "<tab>") 'tab-to-tab-stop)

(add-hook 'sgml-mode-hook
          '(lambda ()
             (local-set-key [?\C-c?\C-/] 'sgml-close-tag)))

(add-to-list 'auto-mode-alist '("svn-commit.tmp" . text-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdn\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.mdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(eval-after-load "flyspell"
  '(progn
     (define-key flyspell-mode-map (kbd "C-.") nil)
     (define-key flyspell-mode-map (kbd "C-,") nil)
     (define-key flyspell-mode-map (kbd "C-;") nil)
     ))
