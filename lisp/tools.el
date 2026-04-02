;;; tools.el --- 窗口、命令历史、撤销树 -*- lexical-binding: t -*-A

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

(use-package org-modern
  :ensure t
  :hook ((org-mode . org-modern-mode)))

(use-package multiple-cursors
  :ensure t
  :init (multiple-cursors-mode)
  :bind (("C->" . mc/mark-next-like-this)
	 ("C-<" . mc/mark-previous-lik-this)
	 ("C-c C-<" . mc/mark-all-like-this)))

;; wayland 环境下可用
;; (use-package clipetty
;;   :config
;;   (global-clipetty-mode))

(load "./clipboard.el")

;; 代码折叠
(use-package hs-minor
  :hook (prog-mode . hs-minor-mode))

;; 这是一个简单的 Hydra 示例，让你按住一个键后进入调整模式
(use-package hydra
  :ensure t
  :bind ("C-c w" . hydra-window-resize/body)
  :config
  (defhydra hydra-window-resize ()
    "Resize Windows"
    ("h" shrink-window-horizontally "shrink width")
    ("j" shrink-window "shrink height")
    ("k" enlarge-window "enlarge height")
    ("l" enlarge-window-horizontally "enlarge width")
    ("q" nil "quit" :exit t)))
