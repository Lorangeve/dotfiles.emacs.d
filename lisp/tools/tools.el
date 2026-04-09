;;; tools.el --- 窗口、Shell 显示、历史、Org、剪贴板 -*- lexical-binding: t -*-

;; *shell* 默认开在选中窗口下方，而不是占满半屏等默认行为
(setq display-buffer-alist
      '(("\\*shell\\*" (display-buffer-below-selected))))

;;;; 窗口切换：在多个窗口上标字母，按键直达

(use-package ace-window
  :bind (("C-x o" . ace-window)))

;;;; M-x 历史增强（依赖 s.el：字符串工具库）

(use-package s)

(use-package amx
  :after s
  :config (amx-mode 1))

;;;; 撤销树：分支式撤销/重做

(use-package undo-tree
  :custom
  (undo-tree-mode-lighter nil)
  ;; 撤销历史文件不要散落在各目录
  (undo-tree-history-directory-alist
   `(("." . ,(expand-file-name ".undo-tree-history" user-emacs-directory))))
  :config (global-undo-tree-mode))

;;;; Org：远程图片内嵌显示
;; 新版 Org（如 Emacs 30 内置）默认 `org-display-remote-inline-images' 为 `skip'，
;; 会禁止 http(s) 内联图；须设为 `cache' 或 `download'，org-remoteimg 才会去拉取。

(use-package org-remoteimg
  :ensure nil
  :vc (:url "https://github.com/gaoDean/org-remoteimg"
       :main-file "org-remoteimg.el")
  :after org
  :config
  (setq org-display-remote-inline-images 'cache))

;;;; Org：光标移到内联图上时临时隐藏预览，离开后再显示（与 org-remoteimg 搭配见上游说明）

(use-package org-imgtog
  :ensure nil
  :vc (:url "https://github.com/gaoDean/org-imgtog"
       :main-file "org-imgtog.el")
  :after org
  :hook (org-mode . org-imgtog-mode))

;;;; Org：剪贴板图片（wl-paste / xclip，见 `org-clipboard-image'）

(require 'org-clipboard-image)

;;;; Org 标题/列表等现代排版

(use-package org-modern
  :hook ((org-mode . org-modern-mode)))

;;;; 多处光标批量编辑

(use-package multiple-cursors
  :config (multiple-cursors-mode 1)
  :bind (("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C-<" . mc/mark-all-like-this)))

;; 终端下若剪贴板异常，可尝试包 clipetty（Wayland/X11 依环境而定）

(require 'clipboard)

;; hide-show：代码块折叠；内置变量 hs-minor-mode
(add-hook 'prog-mode-hook #'hs-minor-mode)

;;;; Hydra：按住前缀后单键连续调窗口大小

(use-package hydra
  :bind ("C-c w" . hydra-window-resize/body)
  :config
  (defhydra hydra-window-resize ()
    "Resize Windows"
    ("h" shrink-window-horizontally "shrink width")
    ("j" shrink-window "shrink height")
    ("k" enlarge-window "enlarge height")
    ("l" enlarge-window-horizontally "enlarge width")
    ("q" nil "quit" :exit t)))
