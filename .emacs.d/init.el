;; this includes the marmalade package repo
(require 'package)
(add-to-list 'package-archives 
    '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; stop making backup files
(setq make-backup-files nil)

;; disable auto save
(setq auto-save-default nil)

;; this starts up evil mode
(unless (package-installed-p 'evil)
	(package-refresh-contents) (package-install 'evil))
(require 'evil)
(evil-mode 1)
;; don't change cursor
;(setq evil-default-cursor t)
;; make insert mode emacs mode
(setcdr evil-insert-state-map nil)
(define-key evil-insert-state-map
  (read-kbd-macro evil-toggle-key) 'evil-emacs-state)
;; trying to rebind esc to go into normal mode
(global-set-key (kbd "<escape>") 'evil-normal-state)

;; trying to get zenburn here
(unless (package-installed-p 'zenburn-theme)
	(package-refresh-contents) (package-install 'zenburn-theme))
(load-theme 'zenburn t)

;; trying to get auto-complete
(unless (package-installed-p 'auto-complete)
	(package-refresh-contents) (package-install 'auto-complete))
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")
(define-key ac-completing-map "\C-m" nil)
(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-m" nil)

;; trying yasnippet
(unless (package-installed-p 'yasnippet)
	(package-refresh-contents) (package-install 'yasnippet))
(require 'yasnippet) ;; not yasnippet-bundle
(yas-global-mode 1)
	     
;; using f11 for fullscreen
(defun toggle-fullscreen ()
  "Toggle full screen on X11"
  (interactive)
  (when (eq window-system 'x)
    (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth))))

(global-set-key [f11] 'toggle-fullscreen)

;; Don't display the 'Welcome to GNU Emacs' buffer on startup
(setq inhibit-startup-message t)

;; Don't insert instructions in the *scratch* buffer
(setq initial-scratch-message nil)

;; Display this instead of "For information about GNU Emacs and the
;; GNU system, type C-h C-a.". This has been made intentionally hard
;; to customize in GNU Emacs so I have to resort to hackery.
(defun display-startup-echo-area-message ()
  "If it wasn't for this you'd be GNU/Spammed by now"
  (message ""))

;; Show matching parens (mixed style)
(show-paren-mode 1)
(setq show-paren-delay 0.0)
(require 'paren)
(set-face-background 'show-paren-match-face (face-background 'default))
(set-face-foreground 'show-paren-match-face "#FF0000")
(set-face-attribute 'show-paren-match-face nil :weight 'ultra-bold)

;; Display the line and column number in the modeline
(setq line-number-mode t)
(setq column-number-mode t)
(line-number-mode t)
(column-number-mode t)
;;(global-linum-mode 1)
;; adds a 1 column margin to the left side
(add-hook 'window-configuration-change-hook
          (lambda ()
            (set-window-margins (car (get-buffer-window-list (current-buffer) nil t)) 1 1)))
(setq-default line-spacing 0.5)

;; make all "yes or no" prompts show "y or n" instead
(fset 'yes-or-no-p 'y-or-n-p)

;; some new functionality stolen from stanford startup class and the respective original authors
(add-to-list 'load-path "~/.emacs.d")
(require 'linum)
(require 'smooth-scrolling)
(require 'whitespace)
(require 'cl)
(require 'ido)
(require 'ffap)
(require 'uniquify)
(require 'ansi-color)
(require 'recentf)
(require 'dired-x)
(require 'compile)
;; ok gonna try some of these modes
(ido-mode t)
(menu-bar-mode -1)
(setq show-trailing-whitespace t)
(setq vc-follow-symlinks t)

;; JS Mode configuration
(load "js-config.el")
(add-to-list 'load-path "~/.emacs.d/jade-mode") ;; github.com/brianc/jade-mode
(require 'sws-mode)
(require 'jade-mode)    
(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))

;; multiple cursors
(unless (package-installed-p 'multiple-cursors)
	(package-refresh-contents) (package-install 'multiple-cursors))
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; paredit
(unless (package-installed-p 'paredit)
  (package-refresh-contents) (package-install 'paredit))
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)

;; highlight-parentheses
(unless (package-installed-p 'highlight-parentheses)
  (package-refresh-contents) (package-install 'highlight-parentheses))
(require 'highlight-parentheses)
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

;; haskell-mode
(unless (package-installed-p 'haskell-mode)
  (package-refresh-contents) (package-install 'haskell-mode))
(require 'haskell-mode)
;; trying to figure out my prefered indentation
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

;; erlang
(unless (package-installed-p 'erlang)
  (package-refresh-contents) (package-install 'erlang))
(require 'erlang-start)

;; elixir-mode
(unless (package-installed-p 'elixir-mode)
  (package-refresh-contents) (package-install 'elixir-mode))
(require 'elixir-mode)
