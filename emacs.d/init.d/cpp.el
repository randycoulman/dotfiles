(c-add-style "rc"
			 '("stroustrup"
			   (c-hanging-braces-alist
				(brace-list-close before)
				(substatement-open before after)
				(class-close before)
				(namespace-close before)
				(brace-list-open before after)
				(brace-entry-open)
				(block-close . c-snug-do-while)
				(extern-lang-open after)
				(inexpr-class-open after)
				(inexpr-class-close before))))

(c-set-offset 'inline-open 0)
(c-set-offset 'statement-case-open '+)

(add-hook 'c-mode-common-hook
          '(lambda () (c-toggle-auto-hungry-state 1)))

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
