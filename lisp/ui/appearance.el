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

;;;; doom-modeline（默认 **不用** Nerd 图标，避免 `nerd-icons-set-font' 改 fontset 与输入法冲突）

;; `doom-modeline' 包仍依赖 `nerd-icons'，但不会在本配置里调用 `nerd-icons-set-font'。
;; 若要 mode-line 图标：设 `doom-modeline-icon' 为 t，并自行承担 fontset 与 Rime 等交互风险。
(use-package doom-modeline
  :after doom-themes
  :custom
  (doom-modeline-icon nil)
  (doom-modeline-minor-modes nil)
  (doom-modeline-lsp t)
  (doom-modeline-check 'auto)
  :config
  (doom-modeline-mode 1))
