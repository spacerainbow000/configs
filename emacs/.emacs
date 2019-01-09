;;Don't delete
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (yaml-mode meghanada magit kill-ring-search tramp-term elpy company flycheck-demjsonlint anzu flycheck browse-kill-ring bash-completion slack logview use-package vlf nlinum))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

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
(add-to-list 'package-archives '("sc" . "http://joseito.republika.pl/sunrise-commander/"))
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
(start-process-shell-command "mkdir -p ~/.emacs_saves")

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
(start-process-shell-command "mkdir -p ~/.emacs/org")
(start-process-shell-command "ln -s ~/.emacs/org ~/org > /dev/null 2>&1")

;; keyboard shortcuts for store-link and agenda
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)


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

;; - PYTHON - ;;

;; elpy
(use-package elpy
  :ensure t)
(defun confdef-elpy-mode-hook ()
  (elpy-mode))
;(defun confdef-elpy-ensure-dependencies-installed ()
;  (start-process-shell-command "elpy-ensure-dependencies-installed" "*Messages*" "if [[ ! $(pip freeze 2>/dev/null | egrep -i 'rope|jedi' | wc -l) == 2 ]] ; then echo 'INSTALLING ROPE + JEDI' ; pip install --user rope jedi ; fi"))
(add-hook 'python-mode-hook 'confdef-elpy-mode-hook)
;(add-hook 'confdef-elpy-mode-hook 'confdef-elpy-ensure-dependencies-installed)
(add-hook 'confdef-elpy-mode-hook 'confdef-global-dev-mode-hook)
;stuff commented out for performance reasons

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

