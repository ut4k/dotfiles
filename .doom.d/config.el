;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun wsl-paste ()
  (interactive)
  (insert (shell-command-to-string "powershell.exe -command 'Get-Clipboard'")))
(global-set-key (kbd "C-c C-v") 'wsl-paste)

(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)
(load! "/usr/share/emacs/site-lisp/emacs-mozc/mozc.el")
(setq default-input-method "japanese-mozc")


(global-set-key (kbd "C-SPC") 'toggle-input-method)
(define-key isearch-mode-map (kbd "C-SPC") 'isearch-toggle-input-method)

(setq mozc-candidate-style 'echo-area)

(require 'dashboard)
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)
(setq dashboard-startup-banner "/home/yuta/.doom.d/doomEmacsTokyoNight.png")
(dashboard-setup-startup-hook)
;; Content is not centered by default. To center, set
(setq dashboard-center-content t)

;;; ~/.emacs.d/site-lisp/mozc_windows10_ubuntu_conf_query1000.el
;;; version 1.0 query1000@gmail.com
;;; Google日本語変換（mozc）のみを括りだしました

;;; www49.atwiki.jp/ntemacs/pages/48.html


;; (require 'mozc-im)
;; (require 'mozc-popup)
;; (load! "lisp/mozc-cursor-color")
;; 
;; (setq default-input-method "japanese-mozc-im")
;; 
;; ;; popupスタイル を使用する
;; (setq mozc-candidate-style 'popup)
;; 
;; ;; overlayスタイルを使用する
;; ;;(setq mozc-candidate-style 'overlay)
;; 
;; ;; ミニバッファに表示する
;; ;;(setq mozc-candidate-style 'echo-area)
;; 
;; ;; カーソルカラーを設定する
;; (setq mozc-cursor-color-alist '((direct        . "red")
;;                                 (read-only     . "yellow")
;;                                 (hiragana      . "green")
;;                                 (full-katakana . "goldenrod")
;;                                 (half-ascii    . "dark orchid")
;;                                 (full-ascii    . "orchid")
;;                                 (half-katakana . "dark goldenrod")))
;; 
;; ;; カーソルの点滅を OFF にする
;; (blink-cursor-mode 0)
;; 
;; ;; C-o で IME をトグルする
;; (global-set-key (kbd "C-o") 'toggle-input-method)
;; (define-key isearch-mode-map (kbd "C-o") 'isearch-toggle-input-method)
;; 
;; ;; mozc-cursor-color を利用するための対策
;; ;; 変更 2019-12-30
;; ;(make-variable-buffer-local 'mozc-im-mode)
;; (defvar mozc-im-mode nil)
;; (add-hook 'mozc-im-activate-hook (lambda () (setq mozc-im-mode t)))
;; (add-hook 'mozc-im-deactivate-hook (lambda () (setq mozc-im-mode nil)))
;; 
;; (advice-add 'mozc-cursor-color-update
;;             :around (lambda (orig-fun &rest args)
;;                       (let ((mozc-mode mozc-im-mode))
;;                         (apply orig-fun args))))
;; 
;; ;; isearch を利用する前後で IME の状態を維持するための対策
;; (defvar im-state nil) ;;; 追加 2019-12-30 https://qiita.com/tadsan/items/9d287a57c26711387043
;; (add-hook 'isearch-mode-hook
;;           (lambda ()
;;             (setq im-state mozc-im-mode)))
;; (add-hook 'isearch-mode-end-hook
;;           (lambda ()
;;             (unless (eq im-state mozc-im-mode)
;;               (if im-state
;;                   (activate-input-method default-input-method)
;;                 (deactivate-input-method)))))
;; 
;; ;; wdired 終了時に IME を OFF にする
;; (require 'wdired)
;; (advice-add 'wdired-finish-edit
;;             :after (lambda (&rest args)
;;                      (deactivate-input-method)))
;; 
;; ;; Windows の mozc では、セッション接続直後 directモード になるので hiraganaモード にする
;; (advice-add 'mozc-session-execute-command
;;             :after (lambda (&rest args)
;;                      (when (eq (nth 0 args) 'CreateSession)
;;                        ;; (mozc-session-sendkey '(hiragana)))))
;;                        (mozc-session-sendkey '(Hankaku/Zenkaku)))))
;; 
;; ;;; https://www49.atwiki.jp/ntemacs/sp/pages/61.html
;; (setq mozc-helper-program-name "/home/yuta/scripts/mozc_emacs_helper.sh")
;; 
;; ;; https://www49.atwiki.jp/ntemacs/pages/69.html
;; ;; 21)
;; ;; C-xC-fで「C:\」などと書けるようにする設定
;; ;; 以下のファイルを~/.emacs.d/site-lispにおいておくこと
;; ;; http://emacswiki.org/emacs/windows-path.el
;; ;; http://emacswiki.org/emacs/cygwin-mount.el
