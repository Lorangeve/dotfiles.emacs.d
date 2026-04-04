;;; editing.el --- 结构化编辑与补全 -*- lexical-binding: t -*-

;;;; Paredit：Lisp 结构编辑（括号平衡、拖拽 S 表达式等）

(use-package paredit
  :hook ((emacs-lisp-mode . paredit-mode)
         (lisp-mode       . paredit-mode)
         (clojure-mode    . paredit-mode)
         (scheme-mode     . paredit-mode)))

;;;; Company：在光标处弹出补全

(use-package company
  :config (global-company-mode))

;;;; Geiser + Guile：Scheme 交互与补全（geiser 由 geiser-guile 依赖拉取）

(use-package geiser-guile
  :after geiser)
