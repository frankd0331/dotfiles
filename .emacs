;; this includes the marmalade package repo
(require 'package)
(add-to-list 'package-archives 
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(package-initialize)

;; stop making backup files
(setq make-backup-files nil)

;; disable auto save
(setq auto-save-default nil)

;; scala mode 2
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)
(unless (package-installed-p 'scala-mode2)
  (package-refresh-contents) (package-install 'scala-mode2))

(require 'scala-mode2)

;; ensime setup
;; load the ensime lisp code...
(add-to-list 'load-path "/home/frankd/bin/ensime_2.10.0-0.9.8.9/elisp/")
(require 'ensime)

;; This step causes the ensime-mode to be started whenever
;; scala-mode is started for a buffer. You may have to customize this step
;; if you're not using the standard scala mode.
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

;; this starts up evil mode
(unless (package-installed-p 'evil)
	(package-refresh-contents) (package-install 'evil))
(require 'evil)
(evil-mode 1)
;; don't change cursor
(setq evil-default-cursor t)
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
	(package-refresh-contents) (package-install 'autocomplete))
(add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")
(require 'auto-complete-config)
(ac-config-default)
(define-key ac-completing-map "\C-m" nil)
(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-m" nil)

;; trying yasnippet
(unless (package-installed-p 'yasnippet)
	(package-refresh-contents) (package-install 'yasnippet))
(require 'yasnippet) ;; not yasnippet-bundle
(yas-global-mode 1)

;; js2-mode
(unless (package-installed-p 'js2-mode)
	(package-refresh-contents) (package-install 'js2-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;; js-comint
(unless (package-installed-p 'js-comint)
	(package-refresh-contents) (package-install 'js-comint))
(require 'js-comint)
;; Use node as our repl
(setq inferior-js-program-command "node --interactive")
(setq inferior-js-mode-hook
      (lambda ()
        ;; We like nice colors
        (ansi-color-for-comint-mode-on)
        ;; Deal with some prompt nonsense
        (add-to-list
         'comint-preoutput-filter-functions
         (lambda (output)
           (replace-regexp-in-string "\033\\[[0-9]+[GK]" "" output))))) 
(setenv "NODE_NO_READLINE" "1")
(add-hook 'js2-mode-hook '(lambda () 
	  (local-set-key "\C-x\C-e" 'js-send-last-sexp)
	  (local-set-key "\C-\M-x" 'js-send-last-sexp-and-go)
	  (local-set-key "\C-cb" 'js-send-buffer)
	  (local-set-key "\C-c\C-b" 'js-send-buffer-and-go)
	  (local-set-key "\C-cl" 'js-load-file-and-go)))


	     
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
(show-paren-mode t)
(setq show-paren-delay 0.0)

;; Display the line and column number in the modeline
(setq line-number-mode t)
(setq column-number-mode t)
(line-number-mode t)
(column-number-mode t)
;;(global-linum-mode 1)
(add-hook 'window-configuration-change-hook
          (lambda ()
            (set-window-margins (car (get-buffer-window-list (current-buffer) nil t)) 1 1)))
(setq-default line-spacing 0.5)

;; make all "yes or no" prompts show "y or n" instead
(fset 'yes-or-no-p 'y-or-n-p)

