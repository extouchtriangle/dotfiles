;;; dashboard.el --- Startup dashboard -*- lexical-binding: t; -*-
(require 'org)

(defconst jb-dashboard-buffer "*dashboard*")

(defun jb-dashboard--load-time ()
  (float-time (time-subtract after-init-time before-init-time)))

(defun jb-get-org-todos ()
  "Fetch tasks and deadlines from all files in org-agenda-files."
  (let ((todos '()))
    (when (boundp 'org-agenda-files)
      (dolist (file (org-agenda-files))
        (when (file-exists-p file)
          (with-current-buffer (find-file-noselect file)
            (org-element-map (org-element-parse-buffer) 'headline
              (lambda (headline)
                (let* ((todo-type (org-element-property :todo-keyword headline))
                       (title (org-element-property :title headline))
                       (deadline (org-element-property :deadline headline))
                       (deadline-str (if deadline
                                         (format " !! %s" (org-timestamp-format deadline "%Y-%m-%d"))
                                       "")))
                  ;; Match active TODOs
                  (when (and todo-type
                             (not (member todo-type org-done-keywords)))
                    (push (concat
                           (substring-no-properties (org-element-interpret-data title))
                           deadline-str)
                          todos)))))))))
    (if todos
        (mapcar (lambda (title) (format "• %s" (string-trim title)))
                (seq-take (reverse todos) 5))
      '("no active tasks"))))
(defun jb-dashboard-render ()
  (let ((buf (get-buffer-create jb-dashboard-buffer)))
    (with-current-buffer buf
      (let* ((inhibit-read-only t)
             (win (get-buffer-window buf t))
             (width (if win (window-body-width win) (frame-width)))
             (height (if win (window-body-height win) (frame-height)))
             (center (lambda (s)
                       (concat (make-string (max 0 (/ (- width (string-width s)) 2)) ?\s)
                               s)))
             (todo-list (jb-get-org-todos))
             (lines (append
                     (list (funcall center "extouchtriangle, welcome to emacs")
                           ""
                           (funcall center (format "emacs %s" emacs-version))
                           (funcall center (if (daemonp) "daemon" "standalone"))
                           ""
                           (funcall center (downcase (format-time-string "%a, %d %b %y")))
                           ""
                           (funcall center "--- tasks ---"))
                     (mapcar center todo-list)
                     (list ""
                           (funcall center (format "loaded in %.2fs" (jb-dashboard--load-time))))))
             (top-pad (max 0 (/ (- height (length lines)) 2))))
        (erase-buffer)
        (insert (make-string top-pad ?\n))
        (dolist (line lines)
          (insert line "\n")))
      (special-mode)
      (local-set-key (kbd "g") #'jb-dashboard-render)
      (goto-char (point-min)))))

;; Only set as initial buffer after Org is loaded
(after! org
  (setq initial-buffer-choice
        (lambda ()
          (let ((buf (get-buffer-create jb-dashboard-buffer)))
            (run-with-idle-timer 0 nil #'jb-dashboard-render)
            buf))))

(provide 'dashboard)
;;; dashboard.el ends here
