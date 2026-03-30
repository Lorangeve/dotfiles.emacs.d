(global-display-line-numbers-mode)  ;（可选）显示相对行号
(global-set-key (kbd "C-j") nil) 
(global-set-key (kbd "<f4>") nil)

(setq inhibit-startup-screen t)  ; 关闭欢迎界面

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(electric-pair-mode t)  ; 自动括号补全
(column-number-mode t)  ; mode-line 上显示列号
(global-auto-revert-mode t) ; 自动刷新 buffer 文件
(add-hook 'prog-mode-hook #'hs-minor-mode) ; 代码折叠

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

;; 添加 tree-sitter 源
(setq treesit-language-source-alist
      '((typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
        (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
        (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")))

;; 让 Emacs 自动把某些后缀关联到 ts-mode
(setq major-mode-remap-alist
      '((typescript-mode . typescript-ts-mode)
        (tsx-mode . tsx-ts-mode)
        (js-mode . js-ts-mode)))

(use-package eglot
  :config
  (add-hook 'python-mode-hook 'eglot-ensure)
  (add-hook 'rust-mode-hook 'eglot-ensure)
  (add-hook 'typescript-ts-mode-hook 'eglot-ensure)
  (add-hook 'scheme-mode-hook 'eglot-ensure))

(use-package rime
  :ensure t
  :custom
  (default-input-method "rime")
  ;; 如果你是 MacOS 且使用 Squirrel，或者 Linux 使用ibus/fcitx，
  ;; 通常需要指定 librime 的共享库位置（以下为常见路径，需根据系统调整）
  (rime-librime-root "~/.local/share/fcitx5/rime")
  ;; (rime-show-candidate 'posframe) ;; 如果安装了 posframe，候选框会更好看
  :config
  ;; 常用快捷键：进入 RIME 菜单（选方案、切换简繁）
  :bind
  (:map rime-mode-map
        ("C-`" . rime-send-keybinding))) ;; 为了呼出 RIME 的方案选单

(set-face-attribute 'default nil
		    :height 130)
(use-package doom-themes
  :ensure t			    ; 如果本地没有安装，则自动下载安装
  :custom
  ;; 全局设置（默认值）
  (doom-themes-enable-bold t) ; 启用粗体；如果设为 nil，则全局禁用粗体
  (doom-themes-enable-italic t)	; 启用斜体；如果设为 nil，则全局禁用斜体
  ;; 针对 Treemacs 用户的设置
  (doom-themes-treemacs-theme "doom-atom") ; 设置 Treemacs 的主题为 "doom-atom" 
					; (若想要不那么简约的图标，可改为 "doom-colors")
  :config
  ;; 加载具体的配色方案（此处加载的是经典的 doom-one）
  (load-theme 'doom-one t)
  ;; 启用视觉铃铛（发生错误时状态栏会闪烁，而不是发出刺耳的蜂鸣声）
  (doom-themes-visual-bell-config)
  ;; 启用自定义的 NeoTree 主题（前提是必须安装了 nerd-icons 字体图标库！）
  (doom-themes-neotree-config)
  ;; 或者针对 Treemacs 用户的配置（启用 Treemacs 的主题集成）
  (doom-themes-treemacs-config)
  ;; 修正（并改善）Org-mode 原生的字体着色/高亮效果
  (doom-themes-org-config))

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
