;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;;;; Fonts
(set-face-attribute 'default nil
                    :family "GeistMono Nerd Font"
                    :height 110)
(set-face-attribute 'variable-pitch nil
                    :family "Alegreya"
                    :height 120)
(set-face-attribute 'fixed-pitch nil
                    :family "GeistMono Nerd Font"
                    :height 110)
;; (setq org-agenda-files '("~/org/todo.org" "~/org/work.org"))
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-tokyo-night)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(setq select-enable-clipboard t)
(setq scroll-margin 0)
(after! emacs-everywhere
  (setq emacs-everywhere-final-parameters "")
  (setq emacs-everywhere-default-frame-name "Emacs Everywhere"))
;; in ~/.doom.d/config.el

(use-package! tree-sitter
  :config
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package! tree-sitter-langs
  :after tree-sitter)
(with-eval-after-load 'treemacs
  (set-face-attribute 'treemacs-root-face nil :family "Alegreya Sans" :height 1.0)
  (set-face-attribute 'treemacs-file-face nil :family "Alegreya Sans" :height 1.0)
  (set-face-attribute 'treemacs-directory-face nil :family "Alegreya Sans" :height 1.0))
;; Open Treemacs on startup

;; Use 'window-setup-hook' to ensure the frame is ready

;; Minimap often needs a slight delay or a specific UI hook
                                        ; (add-hook 'doom-first-buffer-hook #'demap-open)

(setq read-process-output-max (* 1024 1024)) ; 1MB chunks instead of 4KB
(setq lsp-use-plists t)
(after! lsp-mode
  (add-hook 'python-mode-hook
            (lambda ()
              (add-hook 'before-save-hook #'lsp-format-buffer t t)
              (add-hook 'before-save-hook #'lsp-organize-imports t t))))
(setq eglot-max-file-watches 1000000)
(after! eglot
  (setq eglot-ignored-server-capabilities '(:fileWatching))
  ;; This ensures Eglot doesn't try to manage the venv itself
  (setq eglot-workspace-configuration
        '((:pyright . (:analysis (:autoSearchPaths t
                                  :useLibraryCodeForTypes t))))))
;; 1. Prevent Eglot from even trying to format
;; 3. Tell Doom to let the LSP handle the formatting
(after! apheleia
  (setf (alist-get 'ruff-chained apheleia-formatters)
        '("sh" "-c" "ruff check --select I --fix - | ruff format -"))

  (setf (alist-get 'python-mode apheleia-mode-alist) '(ruff-chained)))
(setq-hook! 'latex-mode-hook +format-with-lsp nil) ; Let the formatter handle it, not the LSP
(after! eglot
  (add-to-list 'eglot-server-programs
               '((latex-mode tex-mode context-mode) . ("texlab"))))
(add-hook 'LaTeX-mode-hook 'eglot-ensure)
(add-hook 'latex-mode-hook 'eglot-ensure)
(setq-default eglot-workspace-configuration
              '(:texlab (:build (:onSave t)
                         :chktex (:onEdit t :onOpen t)
                         :diagnosticsDelay 300
                         :completion (:callSnippet t
                                      :cite (:enabled t)
                                      :bibtex (:formatting (:enabled t))))))
;; (add-hook 'prog-mode-hook #'topsy-mode)
(setq vterm-module-cmake-args "-DUSE_SYSTEM_LIBVTERM=OFF")

(set-file-template! "\\.org$" :ignore t)
(setq org-roam-capture-templates
      '(("d" "default" plain "%?"
         :target (file+head "%(read-string \"Subdir: \")/%<%Y%m%d%H%M%S>-${slug}.org"
                            "#+title: ${title}\n")
         :unnarrowed t)))
(use-package doom-themes
  :demand t
  :config
  (load-theme 'compline t))
(set-frame-parameter nil 'alpha-background 96) ; 85 is the percentage of opacity
(add-to-list 'default-frame-alist '(alpha-background . 96))
;; (load! "centaur")
(use-package openwith
  :ensure t
  :config
  (setq openwith-associations '(("\\.pdf\\'" "sioyek" (file))))
  (openwith-mode 1))

(set-email-account! "gmail"
                    '((mu4e-sent-folder       . "/[Gmail]/Sent Mail")
                      (mu4e-drafts-folder     . "/[Gmail]/Drafts")
                      (mu4e-trash-folder      . "/[Gmail]/Trash") (mu4e-refile-folder     . "/[Gmail]/All Mail")
                      (user-mail-address      . "eastonwei12@gmail.com")
                      (user-full-name         . "Easton Wei")
                      (smtpmail-smtp-server   . "smtp.gmail.com")
                      (smtpmail-smtp-service  . 587)
                      (smtpmail-stream-type   . starttls)
                      (smtpmail-auth-supported . (plain login)))
                    t)

(setq mu4e-get-mail-command "mbsync -a")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")
(after! flycheck
  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers '(json-jsonlint))))
(load! "universal-launcher")
(load! "evil")
(load! "editing")
(load! "present")
(load! "dashboard")
(load! "elfeed-config")
(load! "keybinds")
(load! "dired")
(load! "emms")
(load! "background")
(load! "vterm")
(setq! confirm-kill-processes nil)
(setq! confirm-kill-emacs nil)
(load! "eww")
(setq browse-url-browser-function 'browse-url-default-browser)
(load! "writing")
(setq password-store-password-length 25)
(defun my/wikipedia-read (title)
  "Fetch plain text of a Wikipedia article and display it in a buffer."
  (interactive "sWikipedia article: ")
  (let* ((url (concat "https://en.wikipedia.org/w/api.php"
                      "?action=query"
                      "&prop=extracts"
                      "&explaintext=true"
                      "&format=json"
                      "&titles=" (url-hexify-string title)))
         (buf (url-retrieve-synchronously url)))
    (with-current-buffer buf
      (goto-char (point-min))
      (re-search-forward "^$")  ; skip HTTP headers
      (let* ((json-data (json-read))
             (pages (cdr (assq 'pages (cdr (assq 'query json-data)))))
             (page (cdar pages))
             (extract (cdr (assq 'extract page))))
        (if (or (null extract) (string= extract ""))
            (message "No article found for: %s" title)
          (let ((out-buf (get-buffer-create (format "*Wikipedia: %s*" title))))
            (with-current-buffer out-buf
              (read-only-mode -1)
              (erase-buffer)
              (insert extract)
              (goto-char (point-min))
              (read-only-mode 1))
            (pop-to-buffer out-buf)))))))
(setq frame-title-format '("%b - emacs"))
(after! smartparens
  (sp-with-modes '(tex-mode plain-tex-mode latex-mode LaTeX-mode text-mode)
    (sp-local-pair "$" nil :actions :rem)))
(setq! org-directory "~/org/")
(setq! org-agenda-files '("~/org/todo.org"))

;; Force Emacs to forget any hidden "Custom" settings for the agenda
(put 'org-agenda-files 'customized-value nil)
(setq ox-clip-linux-cmd "wl-copy -t text/html")
(use-package! ox-clip
  :demand t
  :config
  ;; Your configuration goes here
  (setq ox-clip-linux-cmd "wl-copy -t text/html < %f"))
(setq TeX-source-correlate-mode t)
(setq TeX-source-correlate-start-server t)
(setq TeX-source-correlate-method 'synctex)
(after! tex
  ;; 1. Add Sioyek to your available programs list safely
  (setq TeX-view-program-list (assoc-delete-all "Sioyek" TeX-view-program-list))
  (add-to-list 'TeX-view-program-list
               '("Sioyek" "sioyek --reuse-window --forward-search-file \"%b\" --forward-search-line %n \"%o\""))

  ;; 2. REPLACE the selection list entirely so Sioyek is the absolute choice for PDFs
  (setq TeX-view-program-selection
        '((output-pdf "Sioyek")
          ((output-dvi has-no-display-manager) "dvi2tty")
          ((output-dvi style-pstricks) "dvips and gv")
          (output-dvi "xdvi")
          (output-html "xdg-open"))))
(use-package tex
  :config
  (setq TeX-view-program-seleciton '((output-pdf "Sioyek"))))
