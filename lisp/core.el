;;; core.el --- 基础界面与编辑习惯 -*- lexical-binding: t -*-

(global-display-line-numbers-mode)
(global-set-key (kbd "C-j") nil)
(global-set-key (kbd "<f4>") nil)

(setq inhibit-startup-screen t)

(electric-pair-mode t)
(column-number-mode t)
(global-auto-revert-mode t)
(add-hook 'prog-mode-hook #'hs-minor-mode)
