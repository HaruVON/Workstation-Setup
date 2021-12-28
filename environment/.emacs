(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-view-program-selection
   (quote
	(((output-dvi style-pstricks)
	  "dvips and gv")
	 (output-dvi "dvips and gv")
	 (output-pdf "Evince")
	 (output-html "xdg-open"))))
 '(backup-by-copying t)
 '(column-number-mode t)
 '(display-time-mode t)
 '(inhibit-startup-screen t)
 '(load-home-init-file t t)
 '(package-selected-packages (quote (markdown-mode)))
 '(save-place t nil (saveplace))
 '(show-paren-mode t nil (paren))
 '(text-mode-hook
   (quote
	(turn-on-auto-fill
	 (lambda nil
	   (auto-fill-mode 0)
	   (message ""))
	 text-mode-hook-identify)))
 '(transient-mark-mode t))
;; (custom-set-faces
;;   ;; custom-set-faces was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(font-lock-comment-face ((default nil) (nil (:foreground "green")))))

(set-scroll-bar-mode 'right)
(setq-default fill-column 80)
;(global-hl-line-mode 1)

(defun my-hook ()
  (local-set-key ";" 'self-insert-command))

(require 'tex-site)
;(require 'xcscope)
(setq TeX-source-specials-mode 1)

(setq TeX-source-specials-view-start-server t)

;;(require 'comint)
(define-key esc-map "g" 'goto-line)

;;; Display time and date on the status line
(setq display-time-day-and-date t)
(display-time)

; can't remember who I stole this from...
(defun x-hugh-reload-dot-emacs ()
(interactive)
(load-file "~/.emacs"))
(defun x-hugh-edit-dot-emacs ()
(interactive)
(find-file "~/.emacs"))
(global-set-key "\C-c\C-r" 'x-hugh-reload-dot-emacs)
(global-set-key "\C-c\C-e" 'x-hugh-edit-dot-emacs) 
;;(global-set-key "DEL" 'delete-char) 

;; mark current line:
(global-hl-line-mode 1)
;; color for current line:
;(set-face-background 'hl-line "#e0f8ff") 

(setq require-trailing-newline t)

(savehist-mode 1)

;(normal-erase-is-backspace-mode 0)

(setq sentence-end "[.?!][]\"')}]*\\($\\|[ \t]\\)[ \t\n]*")
(setq sentence-end-double-space nil)


(setq-default tab-width 4) ; or any other preferred value
(setq cua-auto-tabify-rectangles nil)
(defadvice align (around smart-tabs activate)
  (let ((indent-tabs-mode nil)) ad-do-it))
(defadvice align-regexp (around smart-tabs activate)
  (let ((indent-tabs-mode nil)) ad-do-it))
(defadvice indent-relative (around smart-tabs activate)
  (let ((indent-tabs-mode nil)) ad-do-it))
(defadvice indent-according-to-mode (around smart-tabs activate)
  (let ((indent-tabs-mode indent-tabs-mode))
    (if (memq indent-line-function
              '(indent-relative
                indent-relative-maybe))
        (setq indent-tabs-mode nil))
    ad-do-it))
(defmacro smart-tabs-advice (function offset)
  (defvaralias offset 'tab-width)
  `(defadvice ,function (around smart-tabs activate)
     (cond
      (indent-tabs-mode
       (save-excursion
         (beginning-of-line)
         (while (looking-at "\t*\\( +\\)\t+")
           (replace-match "" nil nil nil 1)))
       (setq tab-width tab-width)
       (let ((tab-width fill-column)
             (,offset fill-column))
         ad-do-it))
      (t
       ad-do-it))))
(smart-tabs-advice c-indent-line c-basic-offset)
(smart-tabs-advice c-indent-region c-basic-offset)

;(add-to-list 'load-path
 ;            "~/.emacs.d/plugins/yasnippet")
;(require 'yasnippet) ;; not yasnippet-bundle
;(yas/global-mode 1)


(smart-tabs-advice python-indent-line-1 python-indent)
(add-hook 'python-mode-hook
          (lambda ()
            (setq indent-tabs-mode t)
            (setq tab-width (default-value 'tab-width))))

(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

; Compilation : C-cC-c
(setq-default compile-command "make")
(global-set-key "\C-c\C-c" 'compile)

; To allow one different C-cC-c command per bufffer
(make-variable-buffer-local 'compile-command)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
