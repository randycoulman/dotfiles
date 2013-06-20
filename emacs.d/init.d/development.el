(require 'expand-region)
(require 'iedit)
(require 'iedit-rect)

(add-hook 'prog-mode-hook
          '(lambda ()
             (set-fill-column 80)))
(add-hook 'prog-mode-hook 'auto-fill-mode)
(add-hook 'prog-mode-hook 'subword-mode)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(global-set-key (kbd "C-.") 'er/expand-region)
(global-set-key (kbd "C-,") 'er/contract-region)
