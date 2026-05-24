;;; keybinds.el -*- lexical-binding: t; -*-
(defun jb/elfeed-toggle ()
  "Toggle elfeed: if in elfeed, bury it; otherwise, open it."
  (interactive)
  (if (eq major-mode 'elfeed-search-mode)
      (quit-window)
    (elfeed)))
(map! :leader
      (:prefix ("o" . "open")
       :desc "Elfeed" "e" #'jb/elfeed-toggle))
(defun jb/elfeed-show-quit ()
  "Kill the current elfeed-show buffer and return to the search list."
  (interactive)
  (kill-current-buffer)
  ;; If the search buffer exists, switch to it
  (when (get-buffer "*elfeed-search*")
    (switch-to-buffer "*elfeed-search*")))

(map! :map elfeed-show-mode-map
      :nm "q" #'jb/elfeed-show-quit)

(map! :leader
      (:prefix ("e" . "emms")
       :desc "Play playlist" "p" #'emms-play-playlist))

(map! :leader
      (:prefix ("e" . "emms")
       :desc "Play/Pause" "x" #'emms-pause))
(map! :leader
      (:prefix ("e" . "emms")
       :desc "Browser" "B" #'emms-browser))

(map! :leader
      (:prefix ("e" . "emms")
       :desc "Main Page" "e" #'emms))

(map! :leader
      (:prefix ("e" . "emms")
       :desc "Next Track" "f" #'emms-next))

(map! :leader
      (:prefix ("e" . "emms")
       :desc "Previous Track" "b" #'emms-previous))
(defun qalc ()
  "Open a qalc REPL in an Emacs buffer."
  (interactive)
  (async-shell-command "qalc" "*qalc*"))
(map! :leader
      (:prefix ("o" . "open")
       :desc "Open Calculator" "q" #'qalc))

(map! :leader
      (:prefix ("o" . "open")
       :desc "Open Calculator" "q" #'qalc))

(map! :leader
      :desc "Org Drill" "D" #'org-drill)
