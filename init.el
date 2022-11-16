;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; archives 

(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; use-package 

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package command-log-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; display

(setq inhibit-startup-message t)
(scroll-bar-mode -1)	 
(tool-bar-mode -1)	 
(menu-bar-mode -1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; meta key

(setq mac-command-modifier 'meta)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; font

(set-face-attribute 'default nil :font "IBM Plex Mono" :height 165)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; open this file

(global-set-key (kbd "C-x .") (lambda () (interactive) (find-file "~/Developer/ben-maclaurin.github.io/content-org/all-posts.org")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; reload init file

(global-set-key (kbd "C-x r .") (lambda () (interactive) (load-file "~/.emacs.d/init.el")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org todo keywords

(setq org-todo-keywords
    '((sequence "TODO" "IN PROGRESS" "|" "DONE" "DELEGATED")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org agenda mode

(global-set-key (kbd "C-c a") (lambda () (interactive) (org-agenda)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; movement mnemonics

(global-set-key (kbd "M-n") (lambda () (interactive) (next-line 8)))
(global-set-key (kbd "M-p") (lambda () (interactive) (previous-line 8)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; visual line mode

(global-set-key (kbd "C-x v l") (lambda () (interactive) (visual-line-mode 'toggle)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org agenda files location

(setq org-agenda-files '("~/org/task.org"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; line numbers

(global-display-line-numbers-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; save place

(save-place-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; allow hash key entry on macOS

(global-set-key (kbd "M-3") '(lambda () (interactive) (insert "#")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; tree-sitter

(global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; rust-mode

(use-package rust-mode
    :config
  (require 'rust-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ef-themes

(use-package ef-themes :config (load-theme 'ef-light))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ox-hugo

(use-package ox-hugo
    :config
  (with-eval-after-load 'ox
    (require 'ox-hugo)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; magit

(use-package magit
    :config
  (global-set-key (kbd "C-x m") (lambda () (interactive) (split-window-right) (other-window-prefix) (magit-status))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; avy

(use-package avy
    :config
  (global-set-key (kbd "C-;") 'avy-goto-char)
  (global-set-key (kbd "C-l") 'avy-goto-line))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; swiper

(use-package swiper)
(global-set-key "\C-s" 'swiper)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; vertico

(use-package vertico
    :init
  (vertico-mode)
  (setq vertico-count 20))

;; Configure directory extension.
(use-package vertico-directory
    :after vertico
    :ensure nil
    ;; More convenient directory navigation commands
    :bind (:map vertico-map
                ("RET" . vertico-directory-enter)
                ("DEL" . vertico-directory-delete-char)
                ("M-DEL" . vertico-directory-delete-word))
    ;; Tidy shadowed file names
    :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; marginalia

(use-package marginalia
    :init
  (marginalia-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; counsel

(use-package counsel)

(global-set-key (kbd "C-q") nil)
(global-set-key (kbd "C-c g") 'counsel-git-grep)
(global-set-key (kbd "C-SPC") 'counsel-git)
(global-set-key (kbd "M-SPC") 'switch-to-buffer)
(global-set-key (kbd "C-x b") nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; elfeed

(use-package elfeed
    :config
  (setq elfeed-feeds
        '("https://ben-maclaurin.github.io/index.xml"
          "https://ciechanow.ski/atom.xml"
          "https://fasterthanli.me/index.xml"
          "https://hnrss.org/frontpage"
          "https://nitter.net/hlissner/rss"
          "https://nitter.net/karpathy/rss"
          "https://nitter.net/aratramba/rss"
          "https://nitter.net/ohhdanm/rss"
          "https://lexfridman.com/feed/podcast/"
          "https://nitter.net/ukutaht/rss"
          "https://nitter.net/chris_mccord/rss"
          "https://nitter.net/josevalim/rss"
          "https://nitter.net/jonhoo/rss"
          "https://nitter.net/rich_harris/rss")))

(global-set-key (kbd "C-x w") 'elfeed)

(global-set-key (kbd "C-x u") 'elfeed-update)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; which-key

(use-package which-key
    :config
  (require 'which-key)
  (which-key-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-roam

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; eglot

(use-package eglot)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; expand-region

(use-package expand-region
    :bind ("C-." . 'er/expand-region))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; company-mode

(use-package company
    :config
  (add-hook 'after-init-hook 'global-company-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; meow

(defun meow-setup ()
(setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
(meow-motion-overwrite-define-key
 '("j" . meow-next)
 '("k" . meow-prev)
 '("<escape>" . ignore))
(meow-leader-define-key
 ;; SPC j/k will run the original command in MOTION state.
 '("j" . "H-j")
 '("k" . "H-k")
 ;; Use SPC (0-9) for digit arguments.
 '("1" . meow-digit-argument)
 '("2" . meow-digit-argument)
 '("3" . meow-digit-argument)
 '("4" . meow-digit-argument)
 '("5" . meow-digit-argument)
 '("6" . meow-digit-argument)
 '("7" . meow-digit-argument)
 '("8" . meow-digit-argument)
 '("9" . meow-digit-argument)
 '("0" . meow-digit-argument)
 '("/" . meow-keypad-describe-key)
 '("?" . meow-cheatsheet))
(meow-normal-define-key
 '("0" . meow-expand-0)
 '("9" . meow-expand-9)
 '("8" . meow-expand-8)
 '("7" . meow-expand-7) 
 '("6" . meow-expand-6)
 '("5" . meow-expand-5)
 '("4" . meow-expand-4)
 '("3" . meow-expand-3)
 '("2" . meow-expand-2)
 '("1" . meow-expand-1)
 '("-" . negative-argument)
 '(";" . meow-reverse)
 '("," . meow-inner-of-thing)
 '("." . meow-bounds-of-thing)
 '("[" . meow-beginning-of-thing)
 '("]" . meow-end-of-thing)
 '("a" . meow-append)
 '("A" . meow-open-below)
 '("b" . meow-back-word)
 '("B" . meow-back-symbol)
 '("c" . meow-change)
 '("x" . meow-delete)
 '("X" . meow-backward-delete)
 '("w" . meow-next-word)
 '("W" . meow-next-symbol)
 '("f" . meow-find)
 '("g" . meow-cancel-selection)
 '("G" . meow-grab)
 '("h" . meow-left)
 '("H" . meow-left-expand)
 '("i" . meow-insert)
 '("I" . meow-open-above)
 '("j" . meow-next)
 '("J" . meow-next-expand)
 '("k" . meow-prev)
 '("K" . meow-prev-expand)
 '("l" . meow-right)
 '("L" . meow-right-expand)
 '("m" . meow-join)
 '("n" . meow-search)
 '("o" . meow-open-below)
 '("O" . meow-open-above)
 '("p" . meow-yank)
 '("q" . meow-quit)
 '("Q" . meow-goto-line)
 '("r" . meow-replace)
 '("R" . meow-swap-grab)
 '("d" . meow-kill)
 '("t" . meow-till)
 '("u" . meow-undo)
 '("U" . meow-undo-in-selection)
 '("/" . meow-visit)
 '("e" . meow-mark-word)
 '("E" . meow-mark-symbol)
 '("v" . meow-line)
 '("X" . meow-goto-line)
 '("y" . meow-save)
 '("Y" . meow-sync-grab)
 '("z" . meow-pop-selection)
 '("'" . repeat)
 '("s" . meow-hyper-mode)
 '("\"" . meow-hyper-string)
 '("(" . meow-hyper-paren)
 '(")" . meow-hyper-paren)
 '("<escape>" . ignore)))

(use-package meow
    :config
  (require 'meow)
  (meow-setup)
  (meow-global-mode 1)
  (setq meow-expand-hint-remove-delay 2.0)
  (meow-setup-indicator))

(meow-thing-register 'tag '(pair ("<") (">")) '(pair ("<") (">")))

(add-to-list 'meow-char-thing-table '(?\" . string))
(add-to-list 'meow-char-thing-table '(?\( . round))
(add-to-list 'meow-char-thing-table '(?\) . round))

(add-to-list 'meow-char-thing-table '(?\{ . curly))
(add-to-list 'meow-char-thing-table '(?\} . curly))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; meow-hyper

(setq meow-hyper-keymap (make-keymap))
(meow-define-state hyper
  "a hyper mode for meow insertions"
  :lighter " [H]"
  :keymap meow-hyper-keymap)

;; meow-define-state creates the variable
(setq meow-cursor-type-hyper 'hollow)

(meow-define-keys 'hyper
  '("<escape>" . meow-normal-mode)
  '("h" . meow-hyperhtml-mode))

(defun meow-hyper-string () (interactive)
       (let (pos1 pos2 bds)
         (if (and transient-mark-mode mark-active)
             (progn
               (goto-char (region-end))
               (insert "\"")
               (goto-char (region-beginning))
               (insert "\""))
             (insert "\"\"")
             (meow-normal-mode))))

(defun meow-hyper-paren () (interactive)
       (let (pos1 pos2 bds)
         (if (and transient-mark-mode mark-active)
             (progn
               (goto-char (region-end))
               (insert ")")
               (goto-char (region-beginning))
               (insert "("))
             (insert "()")
             (meow-normal-mode))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; meow-hyper-html

(setq meow-hyperhtml-keymap (make-keymap))
(meow-define-state hyperhtml
  "a hyper mode for meow insertions"
  :lighter " [HH]"
  :keymap meow-hyperhtml-keymap)

;; meow-define-state creates the variable
(setq meow-cursor-type-hyperhtml 'hbar)

(meow-define-keys 'hyperhtml
  '("<escape>" . meow-normal-mode)
  '("d" . meow-hyper-html-div-class)
  '("D" . meow-hyper-html-div)
  '("p" . meow-hyper-html-p-class)
  '("P" . meow-hyper-html-p))

(defun meow-hyper-html-div () (interactive)
       (let (pos1 pos2 bds)
         (if (and transient-mark-mode mark-active)
             (progn
               (goto-char (region-end))
               (insert "</div>")
               (goto-char (region-beginning))
               (insert "<div>") (meow-normal-mode))
             (insert "<div></div>")
             (meow-normal-mode))))

(defun meow-hyper-html-div-class () (interactive)
       (let (pos1 pos2 bds)
         (if (and transient-mark-mode mark-active)
             (progn
               (goto-char (region-end))
               (insert "</div>")
               (goto-char (region-beginning))
               (insert "<div className=\"\">") (meow-normal-mode))
             (insert "<div className=\"\"></div>")
             (meow-normal-mode))))

(defun meow-hyper-html-p () (interactive)
       (let (pos1 pos2 bds)
         (if (and transient-mark-mode mark-active)
             (progn
               (goto-char (region-end))
               (insert "</p>")
               (goto-char (region-beginning))
               (insert "<p>") (meow-normal-mode))
             (insert "<p></p>")
             (meow-normal-mode))))

(defun meow-hyper-html-p-class () (interactive)
       (let (pos1 pos2 bds)
         (if (and transient-mark-mode mark-active)
             (progn
               (goto-char (region-end))
               (insert "</p>")
               (goto-char (region-beginning))
               (insert "<p className=\"\">") (meow-normal-mode))
             (insert "<p className=\"\"></p>")
             (meow-normal-mode))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; typescript-mode

(use-package typescript-mode
    :after tree-sitter
    :config
    ;; we choose this instead of tsx-mode so that eglot can automatically figure out language for server
    ;; see https://github.com/joaotavora/eglot/issues/624 and https://github.com/joaotavora/eglot#handling-quirky-servers
    (define-derived-mode typescriptreact-mode typescript-mode
      "TypeScript TSX")

    ;; use our derived mode for tsx files
    (add-to-list 'auto-mode-alist '("\\.tsx?\\'" . typescriptreact-mode))
    ;; by default, typescript-mode is mapped to the treesitter typescript parser
    ;; use our derived mode to map both .tsx AND .ts -> typescriptreact-mode -> treesitter tsx
    (add-to-list 'tree-sitter-major-mode-language-alist '(typescriptreact-mode . tsx)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; aphelia  

;; auto-format different source code files extremely intelligently
;; https://github.com/radian-software/apheleia
(use-package apheleia
    :ensure t
    :config
    (apheleia-global-mode +1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; go-mode

(use-package go-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; savehist

(use-package savehist
    :init
  (savehist-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; elixir-mode

(use-package elixir-mode)

(require 'eglot)

(add-to-list 'eglot-server-programs '(elixir-mode "~/elixir-ls/language_server.sh"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; pulsar

(use-package pulsar
    :init
  (setq pulsar-pulse t)
  (setq pulsar-delay 0.055)
  (setq pulsar-iterations 10)
  (setq pulsar-face 'pulsar-magenta)
  (setq pulsar-highlight-face 'pulsar-yellow)

  (pulsar-global-mode 1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; move-text

(use-package move-text
    :init
  (global-set-key (kbd "M-j") 'move-text-line-down)
  (global-set-key (kbd "M-k") 'move-text-line-up)
  (global-set-key (kbd "C-S-j") 'move-text-down)
  (global-set-key (kbd "C-S-k") 'move-text-up)

  (move-text-default-bindings))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; devdocs

(use-package devdocs
    :config
  (global-set-key (kbd "C-h D") 'devdocs-lookup))
