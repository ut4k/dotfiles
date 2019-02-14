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
(setq inferior-lisp-program "sbcl")
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elpa/slime.el"))
(require 'slime)
(slime-setup '(slime-repl slime-fancy slime-banner)) 
