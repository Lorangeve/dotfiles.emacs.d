;;; completion.el --- Minibuffer 与 Ivy/Counsel -*- lexical-binding: t -*-

;;;; 按前缀键后短暂提示后续可接按键

(use-package which-key
  :config (which-key-mode))

;;;; Ivy：minibuffer 补全与缓冲切换

(use-package ivy
  ;; after-init：等基础 UI 就绪再开，减少启动顺序问题
  :hook (after-init . ivy-mode)
  :bind (("C-c C-r" . ivy-resume)
         ("<f6>"    . ivy-resume)
         :map minibuffer-local-map
         ;; 在 minibuffer 里用 C-r 搜历史（配合 counsel）
         ("C-r" . counsel-minibuffer-history))
  :custom
  (ivy-use-virtual-buffers t)      ;; 缓冲列表含 recentf
  (enable-recursive-minibuffers t) ;; 允许 minibuffer 里再开 minibuffer
  :config (ivy-mode t))

;;;; Swiper：缓冲区内 isearch 换成带概览的搜索

(use-package swiper
  :bind (("C-s" . swiper-isearch)
         ("C-r" . swiper-isearch-backward)))

;;;; Counsel：把常用命令接到 Ivy 完成上（依赖 ivy）

(use-package counsel
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
