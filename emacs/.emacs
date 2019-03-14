;;Don't delete
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (auto-complete ssh-deploy ssh-agency nginx-mode zenburn-theme theme-changer yaml-mode meghanada magit kill-ring-search tramp-term elpy company flycheck-demjsonlint anzu flycheck browse-kill-ring bash-completion slack logview use-package vlf nlinum))))
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; DISPLAY CONFIGURATION ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; change selected region color
(set-face-attribute 'region nil :background "#666" :foreground "#ffffff")

;; enable zenburn
;; (use-package zenburn-theme
;;   :ensure t
;;   :config
;;   (load-theme 'zenburn t))

(set-frame-parameter nil 'alpha nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; GENERAL CONFIGURATION ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; line numbers
(global-linum-mode 1)
                                        ; Swap line numbers using C-<f5>
(autoload 'linum-mode "linum" "toggle line numbers on/off" t)
(global-set-key (kbd "C-<f5>") 'linum-mode)
(line-number-mode 1)
(linum-mode 1)
(setq linum-format "%d  ")

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
(start-process-shell-command "ensure-emacs-saves-dir-existent" "mkdir -p ~/.emacs_saves")


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
(defun indent-file ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))


;;;;;;;;;;;;;;;;
;;; ORG MODE ;;;
;;;;;;;;;;;;;;;;

;; make sure org directory exists
(start-process-shell-command "ensure-emacs-org-dir-existent" "mkdir -p ~/.emacs.d/org")
(start-process-shell-command "ensure-emacs-org-dir-existent" "ln -s ~/.emacs.d/org ~/org > /dev/null 2>&1")

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
