;;; evil.el -*- lexical-binding: t; -*-

(with-eval-after-load 'evil
  (evil-define-key 'motion 'global "k" 'evil-previous-visual-line)
  (evil-define-key 'motion 'global "j" 'evil-next-visual-line))
(with-eval-after-load 'evil
  (define-key evil-normal-state-map (kbd "0") 'evil-beginning-of-visual-line)
  (define-key evil-visual-state-map (kbd "0") 'evil-beginning-of-visual-line))
(with-eval-after-load 'evil
  (define-key evil-normal-state-map (kbd "$") 'evil-end-of-visual-line)
  (define-key evil-visual-state-map (kbd "$") 'evil-end-of-visual-line))
