;;; init.el --- Emacs 配置入口 -*- lexical-binding: t -*-
;;
;; 目录 layout（lisp/）：
;;   packages.el     → straight + use-package
;;   core/           → 路径、project、全局习惯
;;   ui/             → 外观、补全界面
;;   editing/        → 结构化编辑、输入法
;;   lang/           → 语言与 LSP
;;   tools/          → 窗口、Org、剪贴板等工具
;;   llm/            → Ellama 等
;;
;; 各子目录已加入 `load-path`，模块内可用 `(require '…)` 引用同目录特征。

;; Customize 写入单独文件，避免污染本仓库中的 init
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(let ((lisp-dir (expand-file-name "lisp" user-emacs-directory)))
  (add-to-list 'load-path lisp-dir)
  (dolist (sub '("core" "ui" "editing" "lang" "tools" "llm"))
    (add-to-list 'load-path (expand-file-name sub lisp-dir)))
  (dolist (pair '(("packages" . "")
                  ("core" . "core")
                  ("proj" . "core")
                  ("completion" . "ui")
                  ("editing" . "editing")
                  ("lang" . "lang")
                  ("input" . "editing")
                  ("appearance" . "ui")
                  ("tools" . "tools")
                  ("llm-conf" . "llm")))
    (let ((dir (if (equal (cdr pair) "")
                   lisp-dir
                 (expand-file-name (cdr pair) lisp-dir))))
      (load (expand-file-name (concat (car pair) ".el") dir) nil 'nomessage))))

;; 允许 C-x C-n 设置 goal-column（默认被禁用以免新手误触）
(put 'set-goal-column 'disabled nil)
