;;; core.el --- 基础界面与编辑习惯 -*- lexical-binding: t -*-

;; 将备份文件集中存放到 ~/.emacs.d/backups 目录下
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;; 将自动保存文件集中存放到 ~/.emacs.d/autosave 目录下
(setq auto-save-file-name-transforms
      '((".*" "~/.emacs.d/autosave/" t)))

;; 创建目录（如果不存在）
(unless (file-exists-p "~/.emacs.d/backups")
  (make-directory "~/.emacs.d/backups"))
(unless (file-exists-p "~/.emacs.d/autosave")
  (make-directory "~/.emacs.d/autosave"))

;; 边栏数字显示
(global-display-line-numbers-mode)

;; 关开屏显示
(setq inhibit-startup-screen t)

(electric-pair-mode t)       ;; 括号成对
(column-number-mode t)       ;; 显示列数
(global-auto-revert-mode t)  ;; 自动刷新

(setq display-buffer-alist
      '(("\\*shell\\*" (display-buffer-below-selected))))
