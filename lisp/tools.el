;;; tools.el --- 窗口、命令历史、撤销树 -*- lexical-binding: t -*-

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
