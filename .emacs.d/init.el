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
(show-paren-mode 1)
(setq create-lockfiles nil)
(setq-default left-margin-width 3) ; Define new widths.
(set-window-buffer nil (current-buffer)) ; Use them now.
(setq inhibit-startup-screen t) ; skip welcome buffer

;;SLIME--------------------------------------------------
(setq inferior-lisp-program "clisp")
; (setq inferior-lisp-program "sbcl")
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elpa/slime.el"))
(require 'slime)
(slime-setup '(slime-repl slime-fancy slime-banner)) 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(custom-enabled-themes (quote (spacemacs-dark)))
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "2540689fd0bc5d74c4682764ff6c94057ba8061a98be5dd21116bf7bf301acfb" default)))
 '(package-selected-packages
   (quote
    (auto-complete shell-pop spacemacs-theme afternoon-theme rainbow-identifiers slime htmlize helm))))
 '(fci-rule-color "#121212")
 '(package-selected-packages
   (quote
    (spacemacs-theme afternoon-theme rainbow-identifiers slime htmlize helm)))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#d54e53")
     (40 . "goldenrod")
     (60 . "#e7c547")
     (80 . "DarkOliveGreen3")
     (100 . "#70c0b1")
     (120 . "DeepSkyBlue1")
     (140 . "#c397d8")
     (160 . "#d54e53")
     (180 . "goldenrod")
     (200 . "#e7c547")
     (220 . "DarkOliveGreen3")
     (240 . "#70c0b1")
     (260 . "DeepSkyBlue1")
     (280 . "#c397d8")
     (300 . "#d54e53")
     (320 . "goldenrod")
     (340 . "#e7c547")
     (360 . "DarkOliveGreen3"))))
 '(vc-annotate-very-old-color nil)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(add-hook 'prog-mode-hook 'rainbow-identifiers-mode)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

 (setq-default left-margin-width 3) ; Define new widths.
 (set-window-buffer nil (current-buffer)) ; Use them now

;;
;; Auto Complete
;;
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-modes 'text-mode)         ;; text-modeでも自動的に有効にする
(add-to-list 'ac-modes 'fundamental-mode)  ;; fundamental-mode
(add-to-list 'ac-modes 'org-mode)
(add-to-list 'ac-modes 'yatex-mode)
(ac-set-trigger-key "TAB")
(setq ac-use-menu-map t)       ;; 補完メニュー表示時にC-n/C-pで補完候補選択
(setq ac-use-fuzzy t)          ;; 曖昧マッチ

;;htmlエクスポート時に画像をbase64変換
;;https://www.reddit.com/r/orgmode/comments/7dyywu/creating_a_selfcontained_html/
(defun org-html--format-image (source attributes info)
  (format "<img src=\"data:image/%s;base64,%s\"%s />"
      (or (file-name-extension source) "")
      (base64-encode-string
       (with-temp-buffer
	 (insert-file-contents-literally source)
	 (buffer-string)))
      (file-name-nondirectory source)))

(setq split-height-threshold nil)
(setq split-width-threshold 0)
