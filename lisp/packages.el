;;; packages.el --- package.el（MELPA）+ use-package -*- lexical-binding: t -*-
;;
;; early-init.el 将 `package-enable-at-startup' 设为 nil，以便在此处先加入 MELPA 再
;; `package-initialize'，避免在仅含 GNU ELPA 时先初始化一次、后改 archive 导致行为混乱。

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

;; 首次无 archive 缓存时拉取包索引，否则 :ensure 解析不到 MELPA 包名
(unless package-archive-contents
  (package-refresh-contents))

;; Emacs 28：需从 ELPA 安装 use-package；29+ 内置。
(unless (locate-library "use-package")
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; 原先 straight 用 (org :type built-in) 避免再从 ELPA 装一份 Org。package.el 无同名开关：
;; 一般不主动安装 org 即可。若 *Warnings* 出现两套 Org，删除 elpa 下 org-* 目录后重启。
