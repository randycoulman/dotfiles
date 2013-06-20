;;; "Borrowed" from emacsredux.com

(require 'recentf)
(setq recentf-max-saved-items 200
      recentf-max-menu-items 15)

(recentf-mode +1)

(defun rac-recentf-ido-find-file ()
  "Find a recent file using ido."
  (interactive)
  (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
    (when file
      (find-file file)))
  )

(global-set-key (kbd "C-c C-f") 'rac-recentf-ido-find-file)
(global-set-key (kbd "C-c f") 'rac-recentf-ido-find-file)
;;(global-set-key (kbd "C-c C-f") 'recentf-open-files)
;;(global-set-key (kbd "C-c f") 'recentf-open-files)
