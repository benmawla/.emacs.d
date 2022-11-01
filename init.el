;; These lines initialise the package archives.
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; The following lines make several modifications to the default Emacs interface. These are designed to make the display less cluttered with more room for the buffer.
(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

(require 'use-package)
(setq use-package-always-ensure t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("73a183da135380d11ea344ccfe4e78dfe0a6ddcf09f59f050d373f7b4c397c19" "6a4ec7c23828609753b252d3fa543f153ddd0852a0f724ec31b5f579458c54f0" "a55c6f55eacfa36389dffc8672420b80454db33b59843a1923f3e3054a4643ca" "fb3f55ac1ca4d5ba0d35b5507e28fa392b59e796a40d25497b23fd857892f74d" "2e59c24f4daea67be42e30f1e9b40b3169708c5dc97c55e94347380be783499b" "33cd1d4d57fdad620c7578ddf7372acb9a7ea106903c152b06781f8554b8e4c9" "88550f210943832ace0ab1655c541f3912ceaab30e83843682d623c6808502ad" "d97092d4087a2a1455121ad6ff299130083853ba3c4c6b325685a59d68f8e596" "23fc3954a54fd384904994b6b4088f73b57bd9e75b12a1c965306915da8c242a" "5d7bf3ce124535c2415b69c7e017a6258150a11cdfc3029b53310ff50e794967" default))
 '(package-selected-packages
   '(counsel ivy evil-collection linum-relative avy magit ox-hugo ef-themes evil rust-mode tree-sitter-langs tree-sitter use-package eglot)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Enables ~tree-sitter-mode~ globally. Treesitter is an incremental parsing library. 
(global-tree-sitter-mode)

;; Instantiates a major mode for the [[https://www.rust-lang.org/][Rust programming language]]. 
(require 'rust-mode)

;; This line maps ~C-u~ to ~PageUp~ in evil mode:
(setq evil-want-C-u-scroll t) 

;; Enable evil mode, which provides Vim keybinding support for Emacs:
(require 'evil)
(evil-mode 0)

;; I use the key-chord package to remap ~jk~ key presses in quick succession to escape:
(setq key-chord-two-keys-delay 0.3)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-mode 1)

;; I use the accessible ~ef-themes~ collection by [[https://protesilaos.com/][Protesilaos Stavrou]]. 
(load-theme 'ef-light)

;; The following line remaps the Emacs meta <M> modifier to the slightly more erognomic macOS command key.
(setq mac-command-modifier 'meta)

;; This line sets the editor font size and face.
(set-face-attribute 'default nil :font "Iosevka Comfy" :height 195)

;; ~ox-hugo~ provides a convenient way to export `.org` files to Hugo-compatible markdown. It is used in the generation of [[https://ben-maclaurin.github.io/][my personal blog]].
(with-eval-after-load 'ox
  (require 'ox-hugo))

;; The [[https://magit.vc/][magit]] package is an interface for Git inside Emacs. I use it for all Git-related operations.
;;
;; I have bound ~C-x m~ to ~magit-status~ for quicker access to Magit:
(global-set-key (kbd "C-x m") 'magit-status)

;; This line opens the ~emacs.d~ directory with ~C-x .~
(global-set-key (kbd "C-x .") (lambda () (interactive) (find-file "~/.emacs.d/init.el")))

;; Change the cursor type to bar, as I prefer it in non-modal editors.
;; (setq-default cursor-type 'box)

;; avy allows you to jump around text. When a single char is entered, avy highlights candidates.
;;
;; ~C-;~ is bound to ~avy-goto-line~ to enable a shortcut for this functionality:
(global-set-key (kbd "C-;") 'avy-goto-char)

;; A convenient key binding for line jumping in avy...
(global-set-key (kbd "C-'") 'avy-goto-line)

;; Remap ~C-j~ and ~C-k~ to ~PageUp~ and ~PageDn~ respectively (via evil):
;; (global-set-key (kbd "C-j") (lambda () (interactive) (evil-scroll-down 0)))
;; (global-set-key (kbd "C-k") (lambda () (interactive) (evil-scroll-up 0)))

;; I use evil exclusively for text editing. For any other arbitrary buffer I use the default Emacs keybindings. To quickly toggle between the modes I use ~C-z~:
;; (global-set-key (kbd "C-z" (lambda () (interactive) (evil-mode))))

;; This package provides relative line numbers globally and plays well with evil.
(require 'linum-relative)
(linum-on)

;; Ivy is an advance and extensive completion mechanism. Out of the box it provides helpful completions for commands, dired, swiper, buffers and more...
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
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

;;(require 'god-mode)
;;(god-mode)

;;(global-set-key (kbd "<escape>") #'god-mode-all)

(setq elfeed-feeds
      '("https://ben-maclaurin.github.io/index.xml"
	"https://ciechanow.ski/atom.xml"
	"https://fasterthanli.me/index.xml"
        "https://hnrss.org/frontpage"))

(setq org-capture-templates
      '(("t" "Subin Task" entry (file+headline "~/org/subin.org" "Tasks")
         "* TODO %?\n  %i\n  %a")))

(global-set-key (kbd "C-x w") 'elfeed)

(global-set-key (kbd "C-x n s") (lambda () (interactive) (find-file "~/org/subin.org")))

(global-set-key (kbd "M-n") (lambda () (interactive) (next-line 10)))
(global-set-key (kbd "M-p") (lambda () (interactive) (previous-line 10)))
