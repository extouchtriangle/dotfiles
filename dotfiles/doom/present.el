;;; present.el -*- lexical-binding: t; -*-

(after! org-present
  (add-hook 'org-present-mode-hook
            (lambda ()
              (org-present-big)
              (org-display-inline-images)
              (org-present-hide-cursor)
              (doom-modeline-mode -1)      ; Hide the mode-line
              (display-line-numbers-mode -1))) ; Hide line numbers

  (add-hook 'org-present-mode-quit-hook
            (lambda ()
              (org-present-small)
              (org-remove-inline-images)
              (org-present-show-cursor)
              (doom-modeline-mode 1)
              (display-line-numbers-mode 1))))
