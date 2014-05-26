(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
(global-set-key "" 'newline-and-indent)
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key "" (quote undo))
(global-set-key "\C-ci" 'idomenu)

(electric-pair-mode t)
