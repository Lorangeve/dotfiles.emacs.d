;;; input.el --- 输入法 (RIME) -*- lexical-binding: t -*-

(use-package rime
  :ensure t
  :custom
  (default-input-method "rime")
  ;; 如果你是 MacOS 且使用 Squirrel，或者 Linux 使用ibus/fcitx，
  ;; 通常需要指定 librime 的共享库位置（以下为常见路径，需根据系统调整）
  (rime-librime-root "~/.local/share/fcitx5/rime")
  ;; (rime-show-candidate 'posframe) ;; 如果安装了 posframe，候选框会更好看
  ;; 常用快捷键：进入 RIME 菜单（选方案、切换简繁）
  :bind
  (:map rime-mode-map
        ("C-`" . rime-send-keybinding))) ;; 为了呼出 RIME 的方案选单
