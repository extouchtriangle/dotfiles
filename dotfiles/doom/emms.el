(use-package emms
  :defer t
  :commands (emms
             emms-browser
             emms-playlist-mode-go
             emms-pause
             emms-stop
             emms-next
             emms-previous
             emms-shuffle)

  :init
  (setq emms-source-file-default-directory "~/music/"
        emms-setup-default-player t)

  :config
  (emms-all)
  (emms-default-players)
  (emms-mode-line-mode 1)
  (emms-playing-time-mode 1)

  ;; Player Configuration
  (setq emms-player-list '(emms-player-mpv
                           emms-player-vlc
                           emms-player-mplayer))

  (setq emms-player-mpv-parameters
        '("--no-video"
          "--audio-display=no"
          "--ao=pulse"
          "--audio-buffer=0.5"
          "--volume=80"))

  (setq emms-player-vlc-parameters
        '("--no-video"
          "--audio-resampler=soxr"
          "--src-converter-type=0"
          "--aout=pulse"))

  ;; Browser Settings
  (setq emms-browser-covers #'emms-browser-cache-thumbnail-async
        emms-browser-thumbnail-small-size 64
        emms-browser-thumbnail-medium-size 128
        emms-source-file-directory-tree-function
        'emms-source-file-directory-tree-find)

  (add-to-list 'emms-info-functions 'emms-info-ogginfo)
  (add-to-list 'emms-info-functions 'emms-info-tinytag)

  ;; Faces
  (set-face-attribute 'emms-browser-artist-face nil
                      :foreground "#e0dcd4" :height 1.1)
  (set-face-attribute 'emms-browser-album-face nil
                      :foreground "#b4bec8" :height 1.0)
  (set-face-attribute 'emms-browser-track-face nil
                      :foreground "#b4beb4" :height 1.0)
  (set-face-attribute 'emms-playlist-track-face nil
                      :foreground "#f0efeb" :height 1.0)

  ;; Updated: Highlight current track with #1f2228 background
  (set-face-attribute 'emms-playlist-selected-face nil
                      :background "#282c34"
                      :foreground "#ccc4b0"
                      :weight 'bold)

  ;; Notifications
  (add-hook 'emms-player-started-hook #'emms-notify-song-change-with-artwork))

;; --- HELPER FUNCTIONS ---

(defun emms-center-buffer-in-frame (&optional _window)
  "Add margins to center the EMMS buffer in the frame."
  (when (memq major-mode '(emms-browser-mode emms-playlist-mode))
    (let* ((win (selected-window))
           (window-width (window-total-width win))
           (desired-width 80)
           (margin (max 0 (/ (- window-width desired-width) 2))))
      (setq-local left-margin-width margin)
      (setq-local right-margin-width margin)
      (setq-local line-spacing 0.2)
      (set-window-margins win margin margin))))

(defun emms-cover-art-path ()
  "Return cover art path for the current track."
  (when (bound-and-true-p emms-playlist-buffer)
    (let* ((track (emms-playlist-current-selected-track))
           (path (emms-track-get track 'name))
           (dir (file-name-directory path))
           (standard-files '("cover.jpg" "cover.png" "folder.jpg" "folder.png"
                             "album.jpg" "album.png" "front.jpg" "front.png"))
           (standard-cover (cl-find-if
                            (lambda (file)
                              (file-exists-p (expand-file-name file dir)))
                            standard-files)))
      (if standard-cover
          (expand-file-name standard-cover dir)
        (let ((cover-files (directory-files dir nil ".*\\(jpg\\|png\\|jpeg\\)$")))
          (when cover-files
            (expand-file-name (car cover-files) dir)))))))

(defun emms-notify-song-change-with-artwork ()
  "Send song change notification with album artwork via notify-send."
  (when (bound-and-true-p emms-playlist-buffer)
    (let* ((track (emms-playlist-current-selected-track))
           (artist (or (emms-track-get track 'info-artist) "Unknown Artist"))
           (title  (or (emms-track-get track 'info-title)  "Unknown Title"))
           (album  (or (emms-track-get track 'info-album)  "Unknown Album"))
           (cover  (emms-cover-art-path)))
      (apply #'start-process
             "emms-notify" nil "notify-send"
             "-a" "EMMS"
             "-c" "music"
             (append
              (when cover (list "-i" cover))
              (list (format "Now Playing: %s" title)
                    (format "Artist: %s\nAlbum: %s" artist album)))))))

;; --- HOOKS & LAYOUT FIXES ---

(add-hook 'window-size-change-functions #'emms-center-buffer-in-frame)

(add-hook 'minibuffer-exit-hook
          (lambda ()
            (dolist (window (window-list))
              (with-selected-window window
                (when (memq major-mode '(emms-browser-mode emms-playlist-mode))
                  (emms-center-buffer-in-frame))))))

(with-eval-after-load 'emms-browser
  (add-hook 'emms-browser-mode-hook
            (lambda ()
              (face-remap-add-relative 'default '(:background "#1a1d21"))
              (my/sans-zen-mode)
              (emms-center-buffer-in-frame)
              )))

(with-eval-after-load 'emms-playlist-mode
  (add-hook 'emms-playlist-mode-hook
            (lambda ()
              (face-remap-add-relative 'default '(:background "#1a1d21"))
              (my/sans-zen-mode)
              (emms-center-buffer-in-frame)
              )))
