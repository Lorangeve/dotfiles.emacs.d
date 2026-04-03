;;; core.el --- 基础界面与编辑习惯 -*- lexical-binding: t -*-

;; 将备份文件集中到 ~/.emacs.d/backups/
(setq backup-directory-alist
      `(("." . ,(expand-file-name ".backups" user-emacs-directory))))

;; 将自动保存文件集中到 ~/.emacs.d/auto-save-list/
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name ".auto-save-list" user-emacs-directory) t)))

;; 防止初次打开时因为缩放倍率切换导致的抖动
(setq frame-inhibit-implied-resize t)

;; 边栏数字显示
(global-display-line-numbers-mode)

;; 关开屏显示
(setq inhibit-startup-screen t)

(electric-pair-mode t)       ;; 括号成对
(column-number-mode t)       ;; 显示列数
(global-auto-revert-mode t)  ;; 自动刷新

(setq frame-resize-pixelwise t)

(setq display-buffer-alist
      '(("\\*shell\\*" (display-buffer-below-selected))))
