;; ;;; tabs.el --- Description -*- lexical-binding: t; -*-
(if (daemonp)
    (add-hook 'after-make-frame-functions
              (lambda (frame)
                (with-selected-frame frame
                  (centaur-tabs-mode 1))))
  (centaur-tabs-mode 1))
(use-package centaur-tabs
  :ensure t
  :demand t
  :init
  (setq centaur-tabs-set-icons t
        centaur-tabs-gray-out-icons 'buffer
        centaur-tabs-set-bar 'left
        centaur-tabs-set-modified-marker t
        centaur-tabs-close-button "✕"
        centaur-tabs-modified-marker "•"
        centaur-tabs-icon-type 'nerd-icons
        centaur-tabs-plain-icons t
        centaur-tabs-cycle-scope 'tabs
        centaur-tabs-style "bar"
        centaur-tabs-height 32)
  :config
  ;; Filter out temp/ephemeral buffers from tabs
  (defun my/tabs-buffer-list ()
    (seq-filter
     (lambda (b)
       (let ((name (and (buffer-live-p b) (buffer-name b))))
         (and name ; Only proceed if name is a string
              (not (string-prefix-p " " name))
              (not (string-prefix-p "*" name))
              (not (string= name "")))))
     (buffer-list)))
  (setq centaur-tabs-buffer-list-function #'my/tabs-buffer-list)

  ;; Disable tabs in transient/popup-like buffers
  (dolist (hook '(dashboard-mode-hook
                  calendar-mode-hook
                  helpful-mode-hook
                  help-mode-hook))
    (add-hook hook #'centaur-tabs-local-mode))

  (centaur-tabs-mode 1)
  (centaur-tabs-group-by-projectile-project))

;; Keybindings — match Doom's defaults
(with-eval-after-load 'centaur-tabs
  (define-key centaur-tabs-mode-map (kbd "<C-tab>")         #'centaur-tabs-forward)
  (define-key centaur-tabs-mode-map (kbd "<C-iso-lefttab>") #'centaur-tabs-backward))
(advice-add 'centaur-tabs-line :around
            (lambda (orig-fun &rest args)
              (if (and (display-graphic-p) (symbol-function 'centaur-tabs-line))
                  (apply orig-fun args)
                " "))) ; Return a blank string instead of nil if not in GUI
(provide 'tabs)
;; ;;; tabs.el ends here
