;;; input.el --- 输入法（RIME） -*- lexical-binding: t -*-
;;
;; 依赖系统已安装 librime 与对应方案；emacs-rime 通过 liberime 与 RIME 通信。

(use-package rime
  :custom
  (default-input-method "rime")
  ;; librime 共享数据目录：Linux fcitx5 常见如下；macOS 多为 Squirrel 安装路径
  (rime-librime-root "~/.local/share/fcitx5/rime")
  :bind (:map rime-mode-map
              ;; 与 RIME 默认一致：方案选单、简繁切换等
              ("C-`" . rime-send-keybinding)))
