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
	(helm-mode-manager go-mode helm-projectile projectile helm-dash simpleclip helm cask-mode cask-package-toolset ## flycheck-elsa elsa transpose-frame ox-reveal org-link-minor-mode treemacs org-kanban elisp-lint aggressive-indent sly rudel navi-mode multi-term csv-mode smart-mode-line-powerline-theme smart-mode-line auto-complete ssh-deploy ssh-agency nginx-mode zenburn-theme theme-changer yaml-mode magit kill-ring-search tramp-term elpy company flycheck-demjsonlint anzu flycheck browse-kill-ring bash-completion logview use-package vlf nlinum)))
 '(safe-local-variable-values
   (quote
	((eval progn
		   (org-babel-goto-named-src-block "startup")
		   (org-babel-execute-src-block)
		   (outline-hide-sublevels 1))
	 (eval progn
		   (org-babel-goto-named-src-block "startup")
		   (org-babel-execute-src-block))
	 (org-confirm-babel-evaluate))))
 '(tab-width 4)
 '(term-bind-key-alist
   (quote
	(("M-f" . term-send-forward-word)
	 ("M-b" . term-send-backward-word)
	 ("M-d" . term-send-forward-kill-word)
	 ("M-DEL" . term-send-backward-kill-word)
	 ("C-c" . term-interrupt-subjob))))
 '(term-unbind-key-list (quote ("C-u" "C-x" "C-h" "<ESC>" "M-v" "C-v"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-hide ((t (:foreground "black")))))
;; increate cache size
(setq gc-cons-threshold 50000000)

;; increase minimum prime bits size for gnutls
(setq gnutls-min-prime-bits 4096)
;; file changed on disk save query
(setq revert-without-query '(".*"))
;; make sure .emacs_saves exists
;; (start-process-shell-command "ensure-emacs-saves-dir-existent" nil "mkdir -p ~/.emacs_saves") ; old way - pure elisp is better for this
(unless (file-directory-p "~/.emacs.d/.emacs_saves/")
  (make-directory "~/.emacs.d/.emacs_saves/"))

;; autosave directory
(setq backup-by-copying t      ; don't clobber symlinks
      backup-directory-alist '(("." . "~/.emacs.d/.emacs_saves"))
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t) ; versioned backups
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs.d/.emacs_saves/" t)))
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("cselpa" . "https://elpa.thecybershadow.net/packages/"))
(package-initialize)
(unless (package-installed-p 'use-package) ; install use-package
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(require 'bind-key)
;;(add-to-list 'package-archives '("sc" . "http://joseito.republika.pl/sunrise-commander/"))
(unless (file-directory-p "~/.emacs.d/lisp/")
  (make-directory "~/.emacs.d/lisp/"))
;; .el files go in ~/.emacs.d/lisp/
(add-to-list 'load-path "~/.emacs.d/lisp/")
(load "togetherly")
(load "multi-term-ext.el")
(load "ace-window")
(put 'narrow-to-region 'disabled nil)

;; change selected region color
;;(set-face-attribute 'region nil :background "#666" :foreground "#ffffff")

;; fix zenburn background
(set-frame-parameter nil 'alpha nil)

;; disable menu bar
(unless (display-graphic-p)
  (menu-bar-mode -1))
;; ;; set up powerline
;; (use-package smart-mode-line
;;   :ensure t)
;; (use-package smart-mode-line-powerline-theme
;;   :ensure t)
;; ;; (when (member "hack" (font-family-list)) (setq sml/theme 'powerline))
;; ;; (when (member "hack" (font-family-list)) (sml/setup))
;; (setq sml/theme 'powerline)
;; (sml/setup)

;; more powerline configs
                                        ;(setq powerline-default-separator-dir '(right . left))
;; line numbers
(global-nlinum-mode 1)
                                        ; Swap line numbers using C-<f5>
(autoload 'nlinum-mode "linum" "toggle line numbers on/off" t)
(global-set-key (kbd "C-<f5>") 'nlinum-mode)
(line-number-mode 1)
(nlinum-mode 1)
(setq nlinum-format "%d ")
;; tron theme
(deftheme tron
  "A theme by Ian Y.E. Pan. Licensed under GNU GPLv3.")
(custom-theme-set-faces
 `tron
 ;; `(default ((t (:background "#000000" :foreground "#6A8397" ))))
 `(cursor ((t (:background "#D7F0Ff"))))
 `(region ((t (:background "#3E5668"))))
 `(bold ((t (:weight normal :foreground "DarkGoldenrod2"))))
 `(fringe ((t (:background "#000000"))))
 `(mode-line ((t (:foreground "#CBECFF" :background "#3D5666"))))
 `(mode-line-inactive ((t (:foreground "#444444" :background "#1e1e1e"))))
 `(highlight ((t (:background "#262F36"))))
 `(ido-first-match ((t (:foreground "#D7F0Ff" :weight bold))))
 `(ido-only-match ((t (:foreground "#31C0C0"))))
 `(ido-subdir ((t (:foreground "#5DC4FF"))))
 `(isearch ((t (:background "#4D4FBB" :foreground "#fffafa"))))
 `(lazy-highlight ((t (:background "#659f93" :foreground "#fffafa"))))
 `(isearch ((t (:background "#4D4FBB" :foreground "#bb584d"))))
 `(lazy-highlight ((t (:background "#659f93" :foreground "#bb584d"))))
 `(linum ((t (:background "#000000" :foreground "#36424C"))))
 `(nlinum-relative-current-face ((t (:inherit linum :background "#000000" :foreground "#c6c6c6" :weight normal))))
 `(font-lock-builtin-face ((t (:foreground "#5FC4FF"))))
 `(font-lock-doc-face ((t (:foreground "#828D9C" :italic t))))
 `(font-lock-comment-face ((t (
                               :foreground "#CBEBFF"
                               :background nil
                               :italic t))))
 `(font-lock-string-face ((t (:foreground "#387AAA"))))
 `(font-lock-variable-name-face ((t (:foreground "#9BBDD6"))))
 `(font-lock-function-name-face ((t (:foreground "#4BB5BE"))))
 `(font-lock-keyword-face ((t (:foreground "#5EC4FF"))))
 `(font-lock-negation-char-face ((t (:foreground "#5EC4FF"))))
 `(font-lock-preprocessor-face ((t (:foreground "#5EC4FF"))))
 `(font-lock-type-face ((t (:foreground"#DEB45B"))))

 `(font-lock-constant-face ((t (:foreground "#B62D66"))))
 `(minibuffer-prompt ((t (:foreground "#729fcf" ))))
 `(font-lock-warning-face ((t (:foreground "red" :bold t))))
 `(dashboard-banner-logo-title-face ((t (
                                         :inherit default
                                         :overline t
                                         :height 1.15
                                         :family "Monaco"))))
 `(dashboard-heading-face ((t (
                               :inherit default
                               :foreground "#CBEBFF"
                               :height 1.1))))
 `(org-block ((t (:background "#20282F" :foreground "#839DB2"))))
 `(org-document-title ((t (:height 2.0 :foreground "#9bbdd6"
                                   :family "Georgia"))))
 `(org-level-1 ((t (
                    :inherit outline-1
                    :weight bold
                    :foreground "#94DCFE"
                    :height 1.3))))
 `(org-level-2 ((t (
                    :inherit outline-2
                    :weight bold
                    :foreground "#80E3E2"
                    :height 1.1))))
 `(org-level-3 ((t (
                    :inherit outline-3
                    :weight bold
                    :foreground "#528BD1"
                    :height 1.1))))
 `(org-table ((t (:background "#002831" :foreground "#9bbdd6"))))

 `(rainbow-delimiters-depth-1-face ((t (:foreground "#80E3E2"))))
 `(rainbow-delimiters-depth-2-face ((t (:foreground "#6BB9FE"))))
 `(rainbow-delimiters-depth-3-face ((t (:foreground "#B5DEFF"))))
 `(rainbow-delimiters-depth-4-face ((t (:foreground "#80E3E2"))))
 `(rainbow-delimiters-depth-5-face ((t (:foreground "#6BB9FE"))))
 `(rainbow-delimiters-depth-6-face ((t (:foreground "#B5DEFF"))))
 `(rainbow-delimiters-depth-7-face ((t (:foreground "#80E3E2"))))
 `(rainbow-delimiters-depth-8-face ((t (:foreground "#6BB9FE"))))
 `(rainbow-delimiters-depth-9-face ((t (:foreground "#B5DEFF"))))

 )

(provide-theme 'tron)

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
;; req
(require 'ace-window)
;; add ace-window keybind
(global-set-key (kbd "M-o") 'ace-window)
;; change window labels
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

;; fix the comint buffer size
(defun comint-fix-window-size ()
  "Change process window size."
  (interactive)
  (when (and (derived-mode-p 'comint-mode)
             (equal (major-mode "term-mode"))) ;; only fix size for term-mode for now
    (set-process-window-size (get-buffer-process (current-buffer))
                             (window-height)
                             (- (window-width) 1))))

;; hook to run the buffer size fix
(defun fix-comint-buffer-size-hook ()
  ;;(add-hook 'window-configuration-change-hook 'comint-fix-window-size nil t))
  (comint-fix-window-size))

;; attach hook to comint creation event and window resize
(add-hook 'shell-mode-hook 'fix-comint-buffer-size-hook)
(add-hook 'window-size-change-functions 'fix-comint-buffer-size-hook)
(add-hook 'term-mode-hook 'fix-comint-buffer-size-hook)
(eval-after-load "multi-term"
  '(defun multi-term ()
     "Create new term buffer.
Will prompt you shell name when you type `C-u' before this command."
     (interactive)
     (progn (let (term-buffer)
              ;; Set buffer.
              (setq term-buffer (multi-term-get-buffer current-prefix-arg))
              (setq multi-term-buffer-list (nconc multi-term-buffer-list (list term-buffer)))
              (set-buffer term-buffer)
              ;; Internal handle for `multi-term' buffer.
              (multi-term-internal)
              ;; Switch buffer
              (switch-to-buffer term-buffer))
            (fix-comint-buffer-size-hook)
            (setq truncate-lines t)
            )))

;; make sure flyspell is installed
(use-package flyspell
  :ensure t)

;; turn on flyspell for text buffer
(dolist (hook '(text-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))

;; enable flyspell programming mode for certain languages (plus org mode)
;; (dolist (mode '(emacs-lisp-mode-hook
;;                 inferior-lisp-mode-hooek
;;                 sh-mode-hook
;;                 python-mode-hook
;;                 ;; org-mode-hook
;;                 ))
;;   (add-hook mode
;;             '(lambda ()
;;                (flyspell-prog-mode))))

;; install helm package
(use-package helm
  :ensure t)

;; override M-x with helm-M-x
(global-set-key (kbd "M-x") 'helm-M-x)

;; override find file with helm-find-files
(global-set-key (kbd "C-x C-f") #'helm-find-files)

;; fix colors in selection menu
(set-face-attribute 'helm-selection nil
                    :background "#3E5668"
                    :foreground "white")

;; add function to open buffer menu fast
(defun bume ()
  "open helm buffer menu"
  (interactive)
  (helm-buffers-list))

;; override C-x C-b
;;(key-chord-define-global "xb" 'bume)
(global-set-key (kbd "C-x C-b") 'bume)

;; helm everywhere
;; helm kill ring
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
;; helm info
(global-set-key (kbd "C-h f") 'helm-apropos)
(global-set-key (kbd "C-h r") 'helm-info-emacs)
(global-set-key (kbd "C-h C-l") 'helm-locate-library)
;; helm projectile
(helm-projectile-on)
;; ensure latest version
(use-package org
  :ensure t)

;; use old style source block expansion
(require 'org-tempo)

;; ;; ensure control keywords are always all caps
;; (defun cc/org-mode-buffer-force-uppercase-keywords ()
;;   "Uppercase Org keywords and block identifiers."
;;   (interactive)
;;   (save-excursion
;;     (goto-char (point-min))
;;     (let ((case-fold-search nil))
;;       (while (re-search-forward "\\(?1:#\\+[a-z_]+\\(?:_[[:alpha:]]+\\)*\\)\\(?:[ :=~’”]\\|$\\)" nil :noerror)
;;         (replace-match (upcase (match-string-no-properties 1)) :fixedcase nil nil 1)))))
;; (add-hook 'cc/org-mode-buffer-force-uppercase-keywords 'org-babel-after-execute-hook)
;; ;; org-tab-before-tab-emulation-hook

;; (defcustom org-tempo-after-block-created-hook nil
;;   "Hook run after expanding a source block structure."
;;   :type 'hook
;;   :options nil
;;   :group 'wp)


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

;; babel new window control
;; (setq org-src-window-setup 'split-window-below)
(setq org-src-window-setup 'reorganize-frame)

;; load babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (shell . t)
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
   ;; (R . t)
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
    (string= lang "elisp")
    (string= lang "sh")
    (string= lang "shell")
    (string= lang "bash")
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

;; nice spacing when folded
(setq org-cycle-separator-lines 1)

;; do nice indenting
(use-package org
  :config
  (setq org-startup-indented t))
;; the face attribute 'org-indent' will need to be changed once this is set up; there's no way to easily configure it via an emacs conf change, so you have to do M-x customize-face RET org-mode RET. there is also (set-face-attribute 'foo nil :weight 'bold :slant 'italic) but I don't know what goes where in that

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
(projectile-mode +1)
;; (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(local-set-key [3 112] (quote helm-projectile))

(setq projectile-project-search-path '("~/dev/"))
;; install dash package
(use-package helm-dash
  :ensure t)
(require 'helm-dash)

;; auto-assign docsets
(add-hook 'shell-mode-hook
          '(lambda ()
             (setq-local helm-dash-docsets '("Bash"))
             (setq helm-current-buffer (current-buffer))))
(add-hook 'python-mode-hook
          '(lambda ()
             (setq-local helm-dash-docsets '("Python_2" "Python_3"))
             (setq helm-current-buffer (current-buffer))))
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (setq-local helm-dash-docsets '("Emacs Lisp"))
             (setq helm-current-buffer (current-buffer))))
(add-hook 'ruby-mode-hook
          '(lambda ()
             (setq-local helm-dash-docsets '("Redis" "Ruby on Rails" "Ruby"))
             (setq helm-current-buffer (current-buffer))))
(add-hook 'clojure-mode-hook
          '(lambda ()
             (setq-local helm-dash-docsets '("Clojure"))
             (setq helm-current-buffer (current-buffer))))

;; set docs path to something else
(unless (file-directory-p "~/.emacs.d/docs/")
  (make-directory "~/.emacs.d/docs"))
(setq helm-dash-docsets-path "~/.emacs.d/docs/")

;; open docs in EWW instead of OS default browse
;; idk why this doesnt work :(
(setq helm-dash-browser-func 'eww-browse-url
      helm-dash-enable-debugging nil)
;; ;; lsp
;; (use-package lsp-mode :ensure t)
;; (use-package lsp-ui :ensure t)
;; (use-package lsp-common :ensure t)
;; (use-package lsp-clangd :ensure t)
;; (use-package lsp-python :ensure t)
;; (use-package lsp-sh :ensure t)
;; (use-package lsp-html :ensure t)
;; (use-package lsp-treemacs :ensure t)
;;slack placeholder
(require 'key-chord)
(key-chord-mode +1)
;;(key-chord-define-global "ql" 'helm-slack)

;; company
(use-package company
  :ensure t)

;; flycheck
(use-package flycheck
  :ensure t)

;; gtags
(use-package gtags
  :ensure t)
(use-package helm-gtags
  :ensure t)
(require 'gtags)
(unless (file-directory-p "~/.emacs.d/gtags/")
  (make-directory  "~/.emacs.d/gtags/")) ;; make gtags abbrevs dir exists
(setq gtags-rootdir "~/.emacs.d/gtags/") ;; set gtags abbrevs dir

;; auto-complete
(use-package auto-complete
  :ensure t)
(require 'auto-complete)

;; global dev mode
(defun confdef-global-dev-mode-hook ()
  "Turn on useful dev syntax checking for any dev mode."
  (interactive)
  (progn
    (flycheck-mode)
    (company-mode)
    (gtags-mode)
    (auto-complete-mode)))
;; shellcheck hook
;; (add-hook 'sh-mode-hook 'flycheck-mode)
;; superceded by global dev mode hook

;; autocomplete
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)

;;global dev mode hook
(add-hook 'sh-mode-hook 'confdef-global-dev-mode-hook)
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
;;global dev mode hook
(add-hook 'python-mode-hook 'confdef-global-dev-mode-hook)
;; paren match
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

;; turn on company and flycheck for elisp
;; actually don't, it is annoying for elisp
;; (add-hook 'emacs-lisp-mode-hook 'global-dev-mode-hook)

;; paredit
(use-package paredit
  :ensure t)

;;global dev mode hook
(add-hook 'emacs-lisp-mode-hook 'confdef-global-dev-mode-hook)
;; ;; meghanada
;; (use-package meghanada
;;   :ensure t)
;; (use-package meghanada
;;   :bind
;;   (:map meghanada-mode-map
;;         (("C-M-o" . meghanada-optimize-import)
;;          ("C-M-t" . meghanada-import-all)
;;          )))
;; (defun tkj-java-meghanda-mode-hook ()
;;   (meghanada-mode)
;;   (flycheck-mode))
;; (add-hook 'java-mode-hook 'tkj-java-meghanda-mode-hook)
;; (add-hook 'tkj-java-meghanda-mode-hook 'confdef-global-dev-mode-hook)
(use-package go-mode
  :ensure t)
(use-package auto-complete
  :ensure t)
(use-package go-autocomplete
  :ensure t)
(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)

;;global dev mode hook
(add-hook 'go-mode-hook 'confdef-global-dev-mode-hook)

(defun testytest-hook ()
  "set testvar - testytest"
  (interactive)
  (setq testytest t))
(add-hook 'go-mode-hook 'testytest-hook)

;; none of this code actually needs to happen, because the tab-width is set via custom instead
;; (add-hook 'go-mode-hook (lambda ()
;;                           (setq tab-width 4)
;;                           (setq indent-tabs-mode nil) ))
;; (defun fix-go-indent ()
;;   "fix indentation to 4 instead of 8 in go mode"
;;   (interactive)
;;   (progn (
;;           (setq tab-width 4)
;;           (setq standard-indent 4))))
;; (add-hook 'go-mode-hook 'fix-go-indent)

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
(global-set-key [C-M-S-down] 'scroll-other-window-down) ;
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
(defun copy-region-to-other-window (start end)
  "Copy selected text to other window"
  (interactive "r")
  (if (use-region-p)
      (let ((count (count-words-region start end)))
        (save-excursion
          (kill-ring-save start end)
          (other-window 1)
          (yank)
          (newline))
        (other-window -1)
        (message "Moved %s words" count))
    (message "No region selected")))
(defun copy-entire-buffer-to-other-window ()
  "Copy contents of buffer to other window"
  (interactive "r")
  (
   (mark-whole-buffer)
   (copy-region-to-other-window point-min point-max)))
;; Toggle window split
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

;; browse-kill-ring
(use-package browse-kill-ring
  :ensure t)

;; anzu
(use-package anzu
  :ensure t)
(global-anzu-mode +1)
(anzu-mode +1)

;; vlf
(use-package vlf
  :ensure t)

;; nlinum
(use-package nlinum
  :ensure t)

;; auto-complete
(use-package auto-complete
  :ensure t)

;; simpleclip
(use-package simpleclip
  :ensure t)

(setq warning-minimum-level :warning)
