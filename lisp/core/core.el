;;; core.el --- 路径、缓冲与全局编辑习惯 -*- lexical-binding: t -*-

;;;; 文件与备份

;; 备份集中存放，避免工作目录出现 file~
(setq backup-directory-alist
      `(("." . ,(expand-file-name ".backups" user-emacs-directory))))

;; auto-save #file# 集中到单独目录
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name ".auto-save-list" user-emacs-directory) t)))

;; url.el 缓存（如 org 拉远程资源）；需目录存在时可自行 mkdir -p
(setq url-cache-directory "~/.cache/emacs/url")

;;;; 帧与启动

;; 避免首次设字体/缩放时帧尺寸反复变化造成闪烁
(setq frame-inhibit-implied-resize t)
(setq inhibit-startup-screen t)
;; 用像素级调整窗口边缘，避免某些系统下 “拖不动到整数列”
(setq frame-resize-pixelwise t)

;;;; 界面

(global-display-line-numbers-mode)
(column-number-mode t)

;;;; 编辑行为

(electric-pair-mode t)
;; 磁盘上文件被外部修改时自动重载缓冲区
(global-auto-revert-mode t)

;;;; 窗口

;; *shell* 默认开在选中窗口下方，而不是占满半屏等默认行为
(setq display-buffer-alist
      '(("\\*shell\\*" (display-buffer-below-selected))))

;;;; Org：远程图片内嵌显示

(use-package org-remoteimg
  :straight (org-remoteimg :type git :host github :repo "gaoDean/org-remoteimg"))
