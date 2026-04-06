;;; appearance.el --- 主题、字体、行号与 mode-line -*- lexical-binding: t -*-

(global-display-line-numbers-mode)
(column-number-mode t)

;; 字体高度（1/10 pt）；可按显示器 DPI 调整
(set-face-attribute 'default nil :height 130)

;;;; Doom 主题套件

(use-package doom-themes
  :custom
  (doom-themes-enable-bold t)
  (doom-themes-enable-italic t)
  ;; 若不用 treemacs/neotree，下列 doom-themes-*-config 仅为无操作或轻量钩子
  (doom-themes-treemacs-theme "doom-atom")
  :config
  (load-theme 'doom-one t)
  (doom-themes-visual-bell-config)
  (doom-themes-neotree-config)
  (doom-themes-treemacs-config)
  (doom-themes-org-config))

;; 跳过 “安全主题” 确认（自行承担风险；主题来自已声明包时通常可接受）
(setq custom-safe-themes t)

;;;; doom-modeline（与 doom-themes 同系；GUI 首次可 M-x nerd-icons-install-fonts）

(use-package doom-modeline
  :after doom-themes
  :custom
  (doom-modeline-minor-modes nil)
  (doom-modeline-lsp t)
  (doom-modeline-check 'auto)
  :config
  (setq doom-modeline-icon (display-graphic-p))
  (doom-modeline-mode 1))
