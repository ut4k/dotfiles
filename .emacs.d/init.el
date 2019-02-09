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


(menu-bar-mode 0)
<<<<<<< HEAD
(tool-bar-mode 0)(menu-bar-mode -1)
=======
>>>>>>> c4d4475dfe18c8c164096bc567ceb7df138cf4d5
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
<<<<<<< HEAD
 '(package-selected-packages (quote (slime helm))))
=======
 '(package-selected-packages (quote (htmlize helm))))
>>>>>>> c4d4475dfe18c8c164096bc567ceb7df138cf4d5
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
<<<<<<< HEAD

(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files

(windmove-default-keybindings)

;; use clisp for common-lisp
(setq inferior-lisp-program "clisp")
;; ~/.emacs.d/slimeをload-pathに追加
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elpa/slime.el"))
;; SLIMEのロード
(require 'slime)
(slime-setup '(slime-repl slime-fancy slime-banner)) 

(global-linum-mode 1) ; always show line numbers
=======
>>>>>>> c4d4475dfe18c8c164096bc567ceb7df138cf4d5
