;;package--------------------------------------------------
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)
;;basic--------------------------------------------------
(menu-bar-mode 0)
(global-linum-mode 1)
(setq make-backup-files nil)
(setq auto-save-default nil)
(windmove-default-keybindings)
;;SLIME--------------------------------------------------
(setq inferior-lisp-program "clisp")
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elpa/slime.el"))
(require 'slime)
(slime-setup '(slime-repl slime-fancy slime-banner)) 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (afternoon)))
 '(custom-safe-themes
   (quote
    ("2540689fd0bc5d74c4682764ff6c94057ba8061a98be5dd21116bf7bf301acfb" default)))
 '(package-selected-packages
   (quote
    (afternoon-theme rainbow-identifiers slime htmlize helm))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(add-hook 'prog-mode-hook 'rainbow-identifiers-mode)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

 (setq-default left-margin-width 3) ; Define new widths.
 (set-window-buffer nil (current-buffer)) ; Use them now.
