(global-display-line-numbers-mode)  ;（可选）显示相对行号
(global-set-key (kbd "C-j") nil) 
(global-set-key (kbd "<f4>") nil)

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

(use-package rime
  :ensure t
  :custom
  (default-input-method "rime")
  ;; 如果你是 MacOS 且使用 Squirrel，或者 Linux 使用ibus/fcitx，
  ;; 通常需要指定 librime 的共享库位置（以下为常见路径，需根据系统调整）
  (rime-librime-root "~/.local/share/fcitx5/rime")
  (rime-show-candidate 'posframe) ;; 如果安装了 posframe，候选框会更好看
  :config
  ;; 常用快捷键：进入 RIME 菜单（选方案、切换简繁）
  :bind
  (:map rime-mode-map
        ("C-`" . rime-send-keybinding))) ;; 为了呼出 RIME 的方案选单

(setq custom-safe-themes t)
(use-package smart-mode-line
  :ensure t
  :config
  ;; 显式设置主题，避免它乱猜
  ;; 如果用暗色主题，就把 'light 改成 'dark 或 'respectful
  (setq sml/theme 'light) 
  (sml/setup))

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
