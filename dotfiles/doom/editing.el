;; editing.el --- Description -*- lexical-binding: t; -*-

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

;; Elisp
(use-package highlight-defined
  :ensure t
  :hook (emacs-lisp-mode . highlight-defined-mode))

(use-package elisp-refs
  :ensure t)

(provide 'editing)
;;; editing.el ends here
