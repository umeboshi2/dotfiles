(custom-set-variables
 '(line-number-mode t)
 '(load-home-init-file t t)
 '(python-mode-hook (quote (imenu-add-menubar-index)) t)
 '(show-paren-style (quote expression)))
 '(coffee-tab-width 2)
(custom-set-faces
 '(default ((t (:inherit nil :stipple nil :background "#404040" :foreground "#e1e1e1" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 90 :width normal :foundry "bitstream" :family "Bitstream Vera Sans"))) t)
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

(setq frame-background-mode (quote dark))



;; paella template tag keybinding
(global-set-key "\C-x\\" "<--||-->\C-b\C-b\C-b\C-b")


;; this mess is for fixing the fonts on the screen
;; It seems that I can't figure out how to use proportional fonts
;; at startup, so we have to use a keybinding to change it on the fly.


(defun my-fix-fonts-mono ()
  (interactive "*")
  (set-face-font 'default "Mono-9")
)

(defun my-fix-fonts ()
  (interactive "*")
  (set-face-font 'default "DejaVu Sans-9")
)

(global-set-key "\C-xx" 'my-fix-fonts)
(global-set-key "\C-xc" 'my-fix-fonts-mono)

;; start show-paren-mode
(show-paren-mode)

;; add .emacs.d/packages to load-path
(add-to-list 'load-path "~/.emacs.d/packages/")

(autoload 'page-mode "page-mode" "Page-oriented display and editing" t)

(autoload 'coffee-mode "coffee-mode" "CoffeeScript mode" t)


;; jade-mode
(require 'sws-mode)
(require 'jade-mode)    
(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))
