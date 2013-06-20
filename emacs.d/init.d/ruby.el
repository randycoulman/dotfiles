(require 'rcodetools)
(require 'ruby-compilation)
(require 'inf-ruby)

(add-hook 'ruby-mode-hook
          'lambda()
          (local-set-key (kbd "RET") 'reindent-then-newline-and-indent))

(add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("[Rr]akefile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec\\'" . ruby-mode))

(global-set-key "\C-ck" 'ruby-compilation-rake)
