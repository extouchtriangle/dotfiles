(defun emacs-run-launcher ()
  "Emacs run-launcher equivalent to dmenu.

Create and select a frame called emacs-run-launcher which
  consists only of a minibuffer and has specific dimensions.  Run
  counsel-linux-app on that frame, which is an emacs command that
  prompts you to select an app and open it in a dmenu like
  behaviour.  Delete the frame after that command has exited."
  (interactive)
  (bookmark-selector-launcher "emacs-run-launcher" 120 11 'counsel-linux-app))
(defmacro bookmark-selector-launcher (NAME WIDTH HEIGHT FUNCTION)
  "Define a launcher command.

Bookmark-selector is a package revolving around using emacs
outside of emacs to browse your bookmarks. Most of the commands
defined, consist of opening an emacs frame with only a
minibuffer, with a specified NAME, WIDTH and HEIGHT and inside it
calling FUNCTION and deleting the frame after the function
completes or is canceled."
  `(with-selected-frame (make-frame '((name . ,NAME)
                                      (minibuffer . only)
                                      (width . ,WIDTH)
                                      (height . ,HEIGHT)))
     (unwind-protect
         (funcall ,FUNCTION)
       (delete-frame))))
