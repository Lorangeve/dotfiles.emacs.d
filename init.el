(global-display-line-numbers-mode)  ; （可选）显示相对行号
(setq inhibit-startup-screen t)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(use-package which-key
  :config
  (which-key-mode))

(use-package ivy
  :ensure t
  :pin melpa
  :hook (after-init . ivy-mode)		; 建议在初始化完成后开启
  :bind (("C-c C-r" . ivy-resume)
         ("<f6>"    . ivy-resume)
         :map minibuffer-local-map
         ("C-r" . counsel-minibuffer-history))
  :custom
  (ivy-use-virtual-buffers t)
  (enable-recursive-minibuffers t)
  :config
  (ivy-mode t))

(use-package swiper
  :ensure t
  :bind (("C-s" . swiper-isearch)))

(use-package counsel
  :ensure t
  :after ivy
  :bind (("M-x"     . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("<f1> f"  . counsel-describe-function)
         ("<f1> v"  . counsel-describe-variable)
         ("<f1> o"  . counsel-describe-symbol)
         ("<f1> l"  . counsel-find-library)
         ("<f2> i"  . counsel-info-lookup-symbol)
         ("<f2> u"  . counsel-unicode-char)
         ("C-c g"   . counsel-git)
	 ("C-c j"   . counsel-git-grep)
         ("C-c k"   . counsel-ag)
         ("C-x l"   . counsel-locate)
         ("C-S-o"   . counsel-rhythmbox)))

(use-package paredit
  :ensure t
  :hook ((emacs-lisp-mode . paredit-mode)
         (lisp-mode       . paredit-mode)
         (clojure-mode    . paredit-mode)
         (scheme-mode     . paredit-mode)))

(use-package company
  :ensure t
  :init
  (global-company-mode))

(use-package ace-window
  :ensure t
  :bind (("C-x o" . ace-window)))

(use-package amx
  :ensure
  :init (amx-mode))

(use-package undo-tree
  :ensure t
  :init
  (global-undo-tree-mode))
