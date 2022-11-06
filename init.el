(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package command-log-mode)

(setq inhibit-startup-message t)
(scroll-bar-mode -1)	 
(tool-bar-mode -1)	 
(menu-bar-mode -1)

(setq mac-command-modifier 'meta)

(set-face-attribute 'default nil :font "JetBrains Mono" :height 180)

(global-set-key (kbd "C-x .") (lambda () (interactive) (find-file "~/Developer/ben-maclaurin.github.io/content-org/all-posts.org")))

(global-set-key (kbd "C-x r .") (lambda () (interactive) (load-file "~/.emacs.d/init.el")))

(global-set-key (kbd "C-c a") (lambda () (interactive) (org-agenda)))

(global-set-key (kbd "M-n") (lambda () (interactive) (next-line 8)))
(global-set-key (kbd "M-p") (lambda () (interactive) (previous-line 8)))

(global-set-key (kbd "C-x v l") (lambda () (interactive) (visual-line-mode 'toggle)))

(hl-line-mode)

(global-tree-sitter-mode)

(use-package rust-mode
    :config
  (require 'rust-mode))

(use-package ef-themes
    :config
  (load-theme 'ef-autumn))

(use-package ox-hugo
    :config
  (with-eval-after-load 'ox
    (require 'ox-hugo)))

(use-package magit
    :config
  (global-set-key (kbd "C-x m") 'magit-status))

(use-package avy
    :config
  (global-set-key (kbd "C-;") 'avy-goto-char))

(use-package counsel)

(use-package ivy
    :config
  (ivy-mode)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  ;; enable this if you want `swiper' to use it
  ;; (setq search-default-mode #'char-fold-to-regexp)
  (global-set-key "\C-s" 'swiper)
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (global-set-key (kbd "<f6>") 'ivy-resume)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  (global-set-key (kbd "<f1> o") 'counsel-describe-symbol)
  (global-set-key (kbd "<f1> l") 'counsel-find-library)
  (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
  (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
  (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c j") 'counsel-git-grep)
  (global-set-key (kbd "C-c k") 'counsel-ag)
  (global-set-key (kbd "C-x l") 'counsel-locate)
  (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
  (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history))

(use-package elfeed
    :config
  (setq elfeed-feeds
        '("https://ben-maclaurin.github.io/index.xml"
          "https://ciechanow.ski/atom.xml"
          "https://fasterthanli.me/index.xml"
          "https://hnrss.org/frontpage")))

(global-set-key (kbd "C-x w") 'elfeed)

;; (use-package embark
;;     :config
;;   (global-set-key (kbd "C-.") (lambda () (interactive) (embark-act))))

(use-package which-key
    :config
  (require 'which-key)
  (which-key-mode))

(use-package org-roam
    :ensure t
    :custom
    (org-roam-directory (file-truename "~/org/roam"))
    :bind (("C-c n l" . org-roam-buffer-toggle)
           ("C-c n f" . org-roam-node-find)
           ("C-c n g" . org-roam-graph)
           ("C-c n i" . org-roam-node-insert)
           ("C-c n c" . org-roam-capture)
           ("C-c n j" . org-roam-dailies-capture-today))
    :config
    (org-roam-setup))

(use-package eglot)

(use-package org-bullets
    :config
  (require 'org-bullets)
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package expand-region
    :bind ("C-." . 'er/expand-region))

(use-package company
    :config
  (add-hook 'after-init-hook 'global-company-mode))
