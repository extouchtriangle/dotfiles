;;; elfeed-config.el --- Description -*- lexical-binding: t; -*-
(use-package! elfeed
  :ensure t
  :custom
  (elfeed-db-directory "~/.elfeed")
  (elfeed-search-filter "")
  :config
  (make-directory "~/.elfeed" t)
  ;; Restore the standard feeds list here
  (define-key elfeed-search-mode-map (kbd "d") #'elfeed-download-current-entry)
  (define-key elfeed-search-mode-map (kbd "O") #'elfeed-search-browse-url)
  (define-key elfeed-search-mode-map (kbd "C-c M") #'jb/elfeed-search-play-in-mpv)
  (define-key elfeed-show-mode-map   (kbd "C-c M") #'jb/elfeed-play-in-mpv))

;; --- Miniflux/Protocol section removed ---

(use-package elfeed-tube
  :ensure t
  :after elfeed
  :config
  (elfeed-tube-setup)
  (define-key elfeed-show-mode-map   (kbd "F")     #'elfeed-tube-fetch)
  (define-key elfeed-show-mode-map   (kbd "C-x C-s") #'elfeed-tube-save))

(defun jb/elfeed-play-in-mpv ()
  "Play current elfeed show entry in mpv."
  (interactive)
  (let ((url (elfeed-entry-link elfeed-show-entry)))
    (unless url (user-error "No URL for this entry"))
    (start-process "elfeed-mpv" nil "mpv"
                   "--ytdl-format=bestvideo[height<=1080]+bestaudio/best"
                   "--save-position-on-quit"
                   url)))

(defun jb/elfeed-search-play-in-mpv ()
  "Play selected elfeed search entry in mpv."
  (interactive)
  (let* ((entry (elfeed-search-selected :ignore-region))
         (url   (elfeed-entry-link entry)))
    (unless url (user-error "No URL for this entry"))
    (elfeed-untag entry 'unread)
    (elfeed-search-update-entry entry)
    (start-process "elfeed-mpv" nil "mpv"
                   "--ytdl-format=bestvideo[height<=1080]+bestaudio/best"
                   "--save-position-on-quit"
                   url)))

;; 1. Define your custom names here
(defvar jb/elfeed-feed-title-aliases
  '(("https://www.youtube.com/feeds/videos.xml?playlist_id=UULFHnyfMqiRRG1u-2MsSQLbXA" . "Veritasium")
    )
  "An alist mapping feed URLs to custom titles.")

;; 2. Create the function that overrides the display title
(defun jb/elfeed-override-fetch-title (args)
  "Override feed titles before they are displayed in the search buffer."
  (let* ((feed (car args))
         (url (elfeed-feed-url feed))
         (alias (assoc url jb/elfeed-feed-title-aliases)))
    (when alias
      (setf (elfeed-feed-title feed) (cdr alias)))
    args))

;; 3. Apply the fix
(advice-add 'elfeed-search-print-entry :before #'jb/elfeed-override-fetch-title)
(provide 'elfeed-config)
(require 'elfeed-tube-mpv)
(use-package! elfeed-tube-mpv
  :ensure t ;; or :straight t
  :bind (:map elfeed-show-mode-map
              ("C-c C-f" . elfeed-tube-mpv-follow-mode)
              ("C-c C-w" . elfeed-tube-mpv-where)))

