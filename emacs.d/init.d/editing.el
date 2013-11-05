(require 'multiple-cursors)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C-S-c C-e") 'mc/edit-ends-of-lines)
(global-set-key (kbd "C-S-c C-a") 'mc/edit-beginnings-of-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this-dwim)
(global-unset-key (kbd "M-<down-mouse-1>"))
(global-set-key (kbd "M-<mouse-1>") 'mc/add-cursor-on-click)

(require 'smartparens-config)

;;; "Borrowed" from emacsredux.com and Ryan Davis (aka @zenspider)

(defun rac-smart-open-line ()
  "Insert an empty line after the current line.
Position the cursor at its beginning, according to the current mode."
  (interactive)
  (move-end-of-line nil)
  (newline-and-indent)
  )

(defun rac-smart-open-line-above ()
  "Insert an empty line above the current line.
Position the cursor at its beginning, according to the current mode."
  (interactive)
  (move-beginning-of-line nil)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode)
  )

(global-set-key [(shift return)] 'rac-smart-open-line)
(global-set-key [(control shift return)] 'rac-smart-open-line-above)


(defun rac-move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode)
  )

(defun rac-move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode)
  )

(global-set-key [(meta shift up)] 'rac-move-line-up)
(global-set-key [(meta shift down)] 'rac-move-line-down)


(defun rac-scroll-up ()
  "Scroll up one line; move text, not cursor."
  (interactive)
  (scroll-down 1)
  )

(defun rac-scroll-down ()
  "Scroll down one line; move text, not cursor."
  (interactive)
  (scroll-up 1)
  )

(global-set-key (kbd "<M-up>") 'rac-scroll-up)
(global-set-key (kbd "<M-down>") 'rac-scroll-down)


(defun rac-smarter-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1)))
  )

(global-set-key [remap move-beginning-of-line]
                'rac-smarter-move-beginning-of-line)


(defun rac-top-join-line ()
  "Join the current line with the line beneath it."
  (interactive)
  (delete-indentation 1)
  )

(global-set-key (kbd "C-^") 'rac-top-join-line)
