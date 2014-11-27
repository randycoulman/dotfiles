(require 'iedit)
(require 'iedit-rect)
(require 'projectile)

(projectile-global-mode)

(which-function-mode)

(add-hook 'prog-mode-hook 'auto-fill-mode)
(add-hook 'prog-mode-hook 'subword-mode)

(add-hook 'before-save-hook 'delete-trailing-whitespace)
