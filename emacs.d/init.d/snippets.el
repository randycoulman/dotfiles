(require 'yasnippet)

(yas-global-mode 1)

;; Fix tab key conflicts between yasnippet and other modes.
(defun rac-tab-noconflict ()
  (let ((command (key-binding [tab])))
    (local-unset-key [tab])
    (local-set-key (kbd "TAB") command)))

(add-hook 'markdown-mode-hook 'rac-tab-noconflict)
