;; vterm.el -*- lexical-binding: t; -*-


;; (use-package vterm
;;   :ensure t
;;   :defer t
;;   :init
;;   (setq vterm-timer-delay 0.05
;;         vterm-kill-buffer-on-exit t
;;         vterm-max-scrollback 5000)
;;   :config
;;   (setq vterm-buffer-name-string "vterm %s"
;;         vterm-environment '("TERM=xterm-256color"))

;;   (defun +vterm--respect-current-dir (fn &rest args)
;;     "Open vterm in the directory of the current buffer."
;;     (let ((default-directory (or (and (buffer-file-name)
;;                                       (file-name-directory (buffer-file-name)))
;;                                  (and (eq major-mode 'dired-mode)
;;                                       (dired-current-directory))
;;                                  default-directory)))
;;       (apply fn args)))
;;   (advice-add 'vterm :around #'+vterm--respect-current-dir)

;;   (add-hook 'vterm-mode-hook
;;             (lambda ()
;;               (setq-local confirm-kill-processes nil)
;;               (setq-local hscroll-margin 0)
;;               (setq-local mode-line-format nil)
;;               (set (make-local-variable 'buffer-face-mode-face)
;;                    '(:family "GeistMono Nerd Font"))
;;               (buffer-face-mode t)))

;;   (define-key vterm-mode-map (kbd "C-<left>")  #'windmove-left)
;;   (define-key vterm-mode-map (kbd "C-<right>") #'windmove-right)
;;   (define-key vterm-mode-map (kbd "C-<up>")    #'windmove-up)
;;   (define-key vterm-mode-map (kbd "C-<down>")  #'windmove-down))

;; (with-eval-after-load 'vterm
;;   ;; Meow integration


;;   ;; Auto-spawn vterm in any new frame that isn't main or explicitly handled
;;   (defun my/vterm-in-new-frame (frame)
;;     "Open vterm only in additional frames, not the main frame or explicit frames."
;;     (unless (or (frame-parameter frame 'main-frame)
;;                 (frame-parameter frame 'explicit-vterm))
;;       (with-selected-frame frame
;;         (delete-other-windows)
;;         (let ((vterm-buffer (vterm (format "*vterm-%s*" (frame-parameter frame 'name)))))
;;           (switch-to-buffer vterm-buffer)
;;           (delete-other-windows)))))
;;   (add-hook 'after-make-frame-functions #'my/vterm-in-new-frame))

;; (defun jb/vterm ()
;;   "Open vterm buffer as a bottom popup at 30% height."
;;   (interactive)
;;   (require 'vterm)
;;   (let ((buf (get-buffer-create "*vterm*")))
;;     (with-current-buffer buf
;;       (unless (derived-mode-p 'vterm-mode)
;;         (vterm-mode)))
;;     (select-window
;;      (display-buffer
;;       buf
;;       '((display-buffer-reuse-window
;;          display-buffer-in-side-window)
;;         (side . bottom)
;;         (slot . 0)
;;         (window-height . 0.3)
;;         (window-parameters . ((no-delete-other-windows . t))))))))

;; ;; Tag initial frame as main so hooks can skip it
;; (defun my/tag-initial-frame ()
;;   "Tag the first frame as main."
;;   (set-frame-parameter nil 'main-frame t))
;; (add-hook 'emacs-startup-hook #'my/tag-initial-frame)

;; ;; Explicitly spawn a new frame with vterm
;; (defun my/new-frame-with-vterm ()
;;   "Create a new frame and force it to display only a new vterm buffer."
;;   (interactive)
;;   (require 'vterm)
;;   (let* ((vterm-buf-name (format "*vterm-%s*" (format-time-string "%H%M%S")))
;;          ;; 1. Create the buffer first without displaying it yet
;;          (vterm-buffer (save-window-excursion (vterm vterm-buf-name)))
;;          ;; 2. Create the frame with the explicit tag
;;          (new-frame (make-frame '((explicit-vterm . t)))))

;;     (select-frame new-frame)
;;     ;; 3. Force the NEW frame's window to show the NEW vterm buffer
;;     (set-window-buffer (frame-selected-window new-frame) vterm-buffer)

;;     ;; 4. Clean up the layout
;;     (delete-other-windows)

;;     ;; 5. Optional: Focus the vterm (useful for meow/input)
;;     (select-window (get-buffer-window vterm-buffer))))

;; (defun my/open-vterm-at-point ()
;;   "Open vterm in the directory of the currently selected window's buffer."
;;   (interactive)
;;   (let* ((buf (window-buffer (selected-window)))
;;          (dir (with-current-buffer buf
;;                 (cond
;;                  ((buffer-file-name buf)
;;                   (file-name-directory (buffer-file-name buf)))
;;                  ((eq major-mode 'dired-mode)
;;                   (dired-current-directory))
;;                  (t default-directory)))))
;;     (let ((default-directory dir))
;;       (vterm))))

;; (defun jb/run-command ()
;;   "Unified interface: shell history + async/output options."
;;   (interactive)
;;   (let* ((cmd (consult--read
;;                shell-command-history
;;                :prompt "Run: "
;;                :sort nil
;;                :require-match nil
;;                :category 'shell-command
;;                :history 'shell-command-history))
;;          (method (completing-read "Method: "
;;                                   '("shell-command" "async-shell-command" "eshell-command"))))
;;     (pcase method
;;       ("shell-command" (shell-command cmd))
;;       ("async-shell-command" (async-shell-command cmd))
;;       ("eshell-command" (eshell-command cmd)))))
;; (defun my/vterm-execute-no-query ()
;;   "Do not prompt for confirmation when closing Emacs with vterm running."
;;   (let ((proc (get-buffer-process (current-buffer))))
;;     (when proc
;;       (set-process-query-on-exit-flag proc nil))))

;; (add-hook 'vterm-mode-hook #'my/vterm-execute-no-query)
(provide 'vterm-config)
;; vterm-config.el ends here
