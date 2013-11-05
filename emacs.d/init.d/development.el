(require 'iedit)
(require 'iedit-rect)
(require 'projectile)

(projectile-global-mode)

(add-hook 'prog-mode-hook
          '(lambda ()
             (set-fill-column 80)))
(add-hook 'prog-mode-hook 'auto-fill-mode)
(add-hook 'prog-mode-hook 'subword-mode)

(add-hook 'before-save-hook 'delete-trailing-whitespace)
