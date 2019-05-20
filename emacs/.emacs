;;Don't delete
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" default)))
 '(multi-term-program nil)
 '(multi-term-scroll-to-bottom-on-output t)
 '(package-selected-packages
   (quote
    (sly rudel navi-mode multi-term csv-mode smart-mode-line-powerline-theme smart-mode-line auto-complete ssh-deploy ssh-agency nginx-mode zenburn-theme theme-changer yaml-mode meghanada magit kill-ring-search tramp-term elpy company flycheck-demjsonlint anzu flycheck browse-kill-ring bash-completion slack logview use-package vlf nlinum)))
 '(term-bind-key-alist
   (quote
    (("M-f" . term-send-forward-word)
     ("M-b" . term-send-backward-word)
     ("M-d" . term-send-forward-kill-word)
     ("M-=" . term-send-backward-kill-word)
     ("C-c" . term-interrupt-subjob))))
 '(term-unbind-key-list (quote ("C-x" "C-h" "<ESC>"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-hide ((t (:foreground "black")))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; HW RESOURCES CONFIGURATION ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; increate cache size
(setq gc-cons-threshold 50000000)

;;; increase minimum prime bits size for gnutls
(setq gnutls-min-prime-bits 4096)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; PACKAGE REPO CONFIGURATION ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
;;(add-to-list 'package-archives '("sc" . "http://joseito.republika.pl/sunrise-commander/"))
(add-to-list 'package-archives '("cselpa" . "https://elpa.thecybershadow.net/packages/"))
(package-initialize)
(unless (package-installed-p 'use-package) ; install use-package
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(require 'bind-key)

;; .el files go in ~/.emacs.d/lisp/
(add-to-list 'load-path "~/.emacs.d/lisp/")
(load "togetherly")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; DISPLAY CONFIGURATION ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; change selected region color
(set-face-attribute 'region nil :background "#666" :foreground "#ffffff")

;; fix zenburn background
(set-frame-parameter nil 'alpha nil)

;; disable menu bar
(unless (display-graphic-p)
  (menu-bar-mode -1))

;; set up powerline
(use-package smart-mode-line
  :ensure t)
(use-package smart-mode-line-powerline-theme
  :ensure t)
;; (when (member "hack" (font-family-list)) (setq sml/theme 'powerline))
;; (when (member "hack" (font-family-list)) (sml/setup))
(setq sml/theme 'powerline)
(sml/setup)

;; more powerline configs
                                        ;(setq powerline-default-separator-dir '(right . left))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; GENERAL CONFIGURATION ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; line numbers
(global-nlinum-mode 1)
                                        ; Swap line numbers using C-<f5>
(autoload 'nlinum-mode "linum" "toggle line numbers on/off" t)
(global-set-key (kbd "C-<f5>") 'nlinum-mode)
(line-number-mode 1)
(nlinum-mode 1)
(setq nlinum-format "%d ")

;; tab width
(setq tab-width 4)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80))
(setq indent-tabs-mode nil)
(setq-default c-basic-offset 4)

;; bsd style
(setq c-default-style "bsd"
      c-basic-offset 4)

;; smooth scrolling
(setq scroll-step            1
      scroll-conservatively  10000)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; FS/SAVING CONFIGURATION ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; file changed on disk save query
(setq revert-without-query '(".*"))

;; autosave directory
(setq backup-by-copying t      ; don't clobber symlinks
      backup-directory-alist '(("." . "~/.emacs_saves"))
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t) ; versioned backups
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs_saves/" t)))

;; make sure .emacs_saves exists
(start-process-shell-command "ensure-emacs-saves-dir-existent" nil "mkdir -p ~/.emacs_saves")


;;;;;;;;;;;;;;;;;;;;;;;;
;;; USEFUL FUNCTIONS ;;;
;;;;;;;;;;;;;;;;;;;;;;;;

;; other-window scrolling
(defun scroll-other-window-up ()
  "Scroll the other window one line up."
  (interactive)
  (scroll-other-window -1)
  )
(defun scroll-other-window-down ()
  "Scroll the other window one line down."
  (interactive)
  (scroll-other-window 1)
  )
(global-set-key [C-M-S-up] 'scroll-other-window-up)
(global-set-key [C-M-S-down] 'scroll-other-window-down)

;; move text between windows
(defun move-region-to-other-window (start end)
  "Move selected text to other window"
  (interactive "r")
  (if (use-region-p)
      (let ((count (count-words-region start end)))
        (save-excursion
          (kill-region start end)
          (other-window 1)
          (yank)
          (newline))
        (other-window -1)
        (message "Moved %s words" count))
    (message "No region selected")))

;; toggle window split
(defun swap-window-split () ; www.emacswiki.org/emacs/ToggleWindowSplit
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))
(define-key ctl-x-4-map "t" 'swap-window-split)
(put 'narrow-to-region 'disabled nil)

;; browse-kill-ring
(use-package browse-kill-ring
  :ensure t)

;; search region
(defun search-region-cleanup ()
  "turn off variable, widen"
  (if search-region
      (widen))
  (setq search-region nil))
(defvar search-region nil
  "variable used to indicate we're in region search")
(add-hook 'isearch-mode-end-hook 'search-region-cleanup)
(defun search-region (&optional regexp-p no-recursive-edit)
  "Do an isearch-forward, but narrow to region first."
  (interactive "P\np")
  (narrow-to-region (point) (mark))
  (goto-char (point-min))
  (setq search-region t)
  (isearch-mode t (not (null regexp-p)) nil (not no-recursive-edit)))

;; autoformat and fix tabs in buffer
(defun region-reindent ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))
(define-key ctl-x-map "t" 'region-reindent)


;;;;;;;;;;;;;;;;
;;; ORG MODE ;;;
;;;;;;;;;;;;;;;;

;; make sure org directory exists
(start-process-shell-command "ensure-emacs-org-dir-existent" nil "mkdir -p ~/.emacs.d/org")
(start-process-shell-command "ensure-emacs-org-dir-existent" nil "ln -s ~/.emacs.d/org ~/org > /dev/null 2>&1")

;; keyboard shortcuts for store-link and agenda
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;; add toggle line wrap binding
(define-key org-mode-map "\M-q" 'toggle-truncate-lines)

;; load babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (sh . t)
   (awk . t)
   (screen . t)
   (C . t)
   (ditaa . t)
   (gnuplot . t)
   (haskell . t)
   (java . t)
   (js . t)
   (latex . t)
   (ledger . t)
   (lisp . t)
   (org . t)
   (perl . t)
   (python . t)
   (ruby . t)
   (scheme . t)
   (sql . t)
   (sqlite . t)
   (R . t)
   ;; (lua . t)
   ;; (matlab . t)
   ;; (processing . t)
   ;; (sed . t)
   ;; (C++ . t)
   ))

;; allow automatic code execution of certain code blocks
(defun my-org-confirm-babel-evaluate (lang body)
  (not
   (or
    (string= lang "emacs-lisp")
    (string= lang "sh")
    (string= lang "awk")
    (string= lang "ditaa")
    (string= lang "gnuplot")
    (string= lang "js")
    (string= lang "latex")
    (string= lang "ledger")
    (string= lang "lisp")
    (string= lang "org")
    (string= lang "perl")
    (string= lang "python")
    (string= lang "ruby")
    (string= lang "scheme")
    (string= lang "R")
    )))
(setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)

;; do nice indenting
(use-package org
  :config
  (setq org-startup-indented t))
                                        ; the face attribute 'org-indent' will need to be changed once this is set up; there's no way to easily configure it via an emacs conf change, so you have to do M-x customize-face RET org-mode RET. there is also (set-face-attribute 'foo nil :weight 'bold :slant 'italic) but I don't know what goes where in that

;; allow open links in browser
(defun my-org-open-at-point (&optional arg)
  (interactive "P")
  (if (not arg)
      (org-open-at-point)
    (let ((browse-url-browser-function #'browse-url-chromium))
      (org-open-at-point))))
(define-key org-mode-map (kbd "C-c C-o") #'my-org-open-at-point)

;; render terminal colors in org result buffers
(require 'ansi-color)
(defun display-ansi-colors ()
  (interactive)
  (ansi-color-apply-on-region (point-min) (point-max)))
(display-ansi-colors) ;; render initially when buffer is opened
(add-hook 'org-babel-after-execute-hook 'display-ansi-colors)


;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; EXTRA MODE CONFIGS ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

;; anzu
(use-package anzu
  :ensure t)
(global-anzu-mode +1)
(anzu-mode +1)

;; vlf
(use-package vlf
  :ensure t)


;;;;;;;;;;;;;;;;;;;;;;;;
;;; DEV MODE CONFIGS ;;;
;;;;;;;;;;;;;;;;;;;;;;;;

;; - IDE CONFIGS - ;;

;; set parameters
(defvar parameters
  '(window-parameters . ((no-other-window . t)
                         (no-delete-other-windows . t))))
(setq fit-window-to-buffer-horizontally t)
(setq window-resize-pixelwise t)

;; start dired in left hand sidebar
(defun dired-sidebar ()
  "Display `default-directory' in side window on left, hiding details."
  (interactive)
  (let ((buffer (dired-noselect default-directory)))
    (with-current-buffer buffer (dired-hide-details-mode t))
    (display-buffer-in-side-window
     buffer `((side . left) (slot . 0)
              (window-width . fit-window-to-buffer)
              (preserve-size . (t . nil)) ,parameters))))

;; start multi-term dedicated debugger window
(defun debugger-terminal ()
  "open dedicated debugger terminal window"
  (interactive)
  (let ((buffer (multi-term-dedicated-open)))
    (with-current-buffer buffer)
    (display-buffer
     buffer `(parameters))
    ))

;; open IDE mode (dired-sidebar and debugger-terminal)
(defun ide-mode ()
  "open IDE window layout"
  (interactive)
  (let ((dired_buffer (dired-noselect default-directory)) (multiterm_buffer (multi-term-dedicated-open)))
    (with-current-buffer dired_buffer (dired-hide-details-mode t))
    (display-buffer-in-side-window
     dired_buffer `((side . left) (slot . 0)
                    (window-width . fit-window-to-buffer)
                    (preserve-size . (t . nil)) ,parameters))
    (with-current-buffer multiterm_buffer)
    (display-buffer
     multiterm_buffer `(parameters)))
  )


;; - GENERAL DEV - ;;

;; company
(use-package company
  :ensure t)

;; flycheck
(use-package flycheck
  :ensure t)

;; flycheck syntax checker modes
                                        ; todo

;; global dev mode
(defun confdef-global-dev-mode-hook ()
  (flycheck-mode)
  (company-mode))

;; - BASH - ;;

;; shellcheck hook
(add-hook 'sh-mode-hook 'flycheck-mode)

;; autocomplete
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)

;; - PYTHON - ;;

;; elpy
(use-package elpy
  :ensure t)
(defun confdef-elpy-mode-hook ()
  (elpy-mode))
(add-hook 'python-mode-hook 'confdef-elpy-mode-hook)
(add-hook 'confdef-elpy-mode-hook 'confdef-global-dev-mode-hook)
(add-hook 'python-mode-hook (function (lambda ()
                                        (setq indent-tabs-mode nil
                                              tab-width 4))))

;; - JAVA - ;;

;; meghanada
(use-package meghanada
  :ensure t)
(use-package meghanada
  :bind
  (:map meghanada-mode-map
        (("C-M-o" . meghanada-optimize-import)
         ("C-M-t" . meghanada-import-all)
         )))
(defun tkj-java-meghanda-mode-hook ()
  (meghanada-mode)
  (flycheck-mode))
(add-hook 'java-mode-hook 'tkj-java-meghanda-mode-hook)
(add-hook 'tkj-java-meghanda-mode-hook 'confdef-global-dev-mode-hook)


;;; END PREDEFINED CONFIG
