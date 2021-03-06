;; -*- mode: emacs-lisp -*-



;; add .emacs.d/packages to load-path
(add-to-list 'load-path "~/.emacs.d/packages/")
(add-to-list 'load-path "~/.emacs.d/use-pkg-packages/")

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

;; https://emacs.stackexchange.com/questions/26954/how-do-i-install-company-mode-via-ensure-packages-installed
; fetch the list of packages available
(or (file-exists-p package-user-dir)
  (package-refresh-contents))

(defun ensure-packages-installed (&rest packages)
  (mapcar (lambda (package)
    (unless (package-installed-p package)
      (package-install package))) packages))

(ensure-packages-installed
 'imenu-anywhere
 'flycheck
 'elpy
 'company-jedi
 'company-ansible
 'toml-mode
 )

(add-hook 'after-init-hook 'global-company-mode)
(global-flycheck-mode)
(elpy-enable)
(add-to-list 'company-backends 'company-jedi)

;;(package-refresh-contents)

;; start with use-package
;(eval-when-compile
;  (require 'use-package))
;;(require 'diminish)                ;; if you use :diminish
;(require 'bind-key)                ;; if you use any :bind variant

;(use-package imenu-anywhere
;  :ensure t
;  :bind (("C-c i" . imenu-anywhere)))

;(use-package flycheck
;  :ensure t
;  :init (global-flycheck-mode))

;(use-package company-mode
;  :ensure t)

;(use-package company-jedi
;  :ensure t)
  ;;:init (add-to-list 'company-backends 'company-jedi))

;(use-package elpy
;  :ensure t
;  :init (elpy-enable))



;; use debian-startup.el
(load "debian-startup")
(setq dotfiles-dir (file-name-directory (or load-file-name (buffer-file-name))))
(let ((user-site-start-dir (concat dotfiles-dir "/.emacs.d/site-start.d")))
    (debian-run-directories user-site-start-dir))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(line-number-mode t)
 '(load-home-init-file t t)
 '(mouse-drag-copy-region t)
 '(package-selected-packages (quote (imenu-anywhere)))
 '(python-mode-hook (quote (imenu-add-menubar-index)) t)
 '(select-enable-clipboard nil)
 '(select-enable-primary t)
 '(show-paren-style (quote expression)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#404040" :foreground "#e1e1e1" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :family "Noto Mono"))))
 '(font-lock-builtin-face ((((class color) (min-colors 88) (background dark)) (:foreground "gold"))))
 '(font-lock-comment-face ((((class color) (min-colors 88) (background dark)) (:foreground "chocolate1" :height 1.1))))
 '(font-lock-keyword-face ((((class color) (min-colors 88) (background dark)) (:foreground "yellow" :weight semi-bold :height 82))))
 '(font-lock-string-face ((((class color) (min-colors 88) (background dark)) (:foreground "pale green" :family "Monospace"))))
 '(font-lock-type-face ((((class color) (min-colors 88) (background dark)) (:foreground "coral" :weight bold :height 1.1))))
 '(rst-level-1-face ((t (:background "grey25"))) t)
 '(rst-level-2-face ((t (:background "grey25"))) t)
 '(rst-level-3-face ((t (:background "grey25"))) t)
 '(show-paren-match ((((class color) (background dark)) (:background "#333366")))))

;; auto-indent in python mode
(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map "\C-m" 'newline-and-indent)))
;; company-jedi https://github.com/syohex/emacs-company-jedi
(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi))

(add-hook 'python-mode-hook 'my/python-mode-hook)

(setq frame-background-mode (quote dark))

;; default size: By default the initial frame seem
;; to be larger than additional frames/
(add-to-list 'initial-frame-alist '(width . 81))
(add-to-list 'initial-frame-alist '(height . 36))
(add-to-list 'default-frame-alist '(width . 81))
(add-to-list 'default-frame-alist '(height . 39))


;; paella template tag keybinding
(global-set-key "\C-x\\" "<--||-->\C-b\C-b\C-b\C-b")


;; this mess is for fixing the fonts on the screen
;; It seems that I can't figure out how to use proportional fonts
;; at startup, so we have to use a keybinding to change it on the fly.


(defun my-fix-fonts-mono ()
  (interactive "*")
  (set-face-font 'default "Noto Mono-10")
)

(defun my-fix-fonts ()
  (interactive "*")
  (set-face-font 'default "Noto Sans-10")
)

(global-set-key "\C-xx" 'my-fix-fonts)
(global-set-key "\C-xc" 'my-fix-fonts-mono)
(global-set-key "\M-p" 'company-complete)
;; pressing \C-w by mistake and not noticing can hurt
(global-set-key "\C-w" 'self-insert-command)


;; start show-paren-mode
(show-paren-mode)


(autoload 'page-mode "page-mode" "Page-oriented display and editing" t)

(autoload 'coffee-mode "coffee-mode" "CoffeeScript mode" t)
(require 'coffee-mode)
;; '(coffee-tab-width 2)
(set-variable 'coffee-tab-width 2)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))


(autoload 'scss-mode "scss-mode")
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))

(autoload 'markdown-mode "markdown-mode" "MarkDown Mode" t)
(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.sls\\'" . yaml-mode))

(require 'jinja2-mode)
(add-to-list 'auto-mode-alist '("\\.j2\\'" . jinja2-mode))
(add-to-list 'auto-mode-alist '("\\.jinja\\'" . jinja2-mode))

(require 'nijinja2-mode)
(add-to-list 'auto-mode-alist '("\\.nijinja\\'" . nijinja2-mode))

(require 'nginx-mode)

;;(require 'magit)

(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(require 'gitconfig-mode)

(require 'jade-mode)
(add-to-list 'auto-mode-alist '("\\.jade\\'" . jade-mode))


(require 'flymake-coffee)
(add-hook 'coffee-mode-hook 'flymake-coffee-load)

(require 'json-mode)
(add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))
(defun my-json-hook nil
  "hook to set indent level."
  (setq js-indent-level 2))
(add-hook 'json-mode-hook 'my-json-hook)


(require 'csharp-mode)
(add-to-list 'auto-mode-alist '("\\.cs\\'" . csharp-mode))

(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

;;(require 'php-mode)
;;(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))
;;(eval-after-load 'php-mode
;;  '(require 'php-ext))

;; https://github.com/broccolijs/broccoli/issues/233#issuecomment-166018886
;; this helps with: https://github.com/webpack/webpack/issues/2156
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq create-lockfiles nil)

;;(setq spacemacs-start-directory "~/workspace/others/spacemacs/")
;;(load-file (concat spacemacs-start-directory "init.el"))

(provide 'emacs)
;;; emacs ends here

