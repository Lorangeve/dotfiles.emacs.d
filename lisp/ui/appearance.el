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

;;;; doom-modeline + Nerd（**只**在 mode-line 用符号字体，不改全局 fontset）

;; `nerd-icons-*' 插入图标时会给字符加 `face' 里的 **:family**（Symbols Nerd Font Mono），
;; 一般只作用于那一段 mode-line 文本即可显示，**无需** `nerd-icons-set-font'。
;; 后者会对整帧 `set-fontset-font' prepend 大段码位，易与 Rime 等冲突——本配置永远不调用它。
;; 系统需已安装 Nerd 字体（如 M-x nerd-icons-install-fonts）；无图形帧时图标自动关。
(use-package doom-modeline
  :after doom-themes
  :custom
  (doom-modeline-minor-modes nil)
  (doom-modeline-lsp t)
  (doom-modeline-check 'auto)
  :config
  ;; GUI 开图标（靠 :family，不动 fontset）；`-nw' 关闭避免豆腐块
  (setq doom-modeline-icon (display-graphic-p))
  (doom-modeline-mode 1))
