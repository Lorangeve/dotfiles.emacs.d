;;; appearance.el --- 主题、字体与 mode-line -*- lexical-binding: t -*-

(set-face-attribute 'default nil
                    :height 130)

(use-package doom-themes
  :ensure t
  :custom
  (doom-themes-enable-bold t)
  (doom-themes-enable-italic t)
  (doom-themes-treemacs-theme "doom-atom")
  :config
  (load-theme 'doom-one t)
  (doom-themes-visual-bell-config)
  (doom-themes-neotree-config)
  (doom-themes-treemacs-config)
  (doom-themes-org-config))

(setq custom-safe-themes t)

(use-package smart-mode-line
  :ensure t
  :config
  ;; 显式设置主题，避免它乱猜
  ;; 如果用暗色主题，就把 'light 改成 'dark 或 'respectful
  (setq sml/theme 'light)
  (sml/setup))
