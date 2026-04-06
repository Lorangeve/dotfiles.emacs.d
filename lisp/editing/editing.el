;;; editing.el --- 结构化编辑（Lisp / Scheme） -*- lexical-binding: t -*-

;;;; Paredit：Lisp 结构编辑（括号平衡、拖拽 S 表达式等）

(use-package paredit
  :hook ((emacs-lisp-mode . paredit-mode)
         (lisp-mode       . paredit-mode)
         (clojure-mode    . paredit-mode)
         (scheme-mode     . paredit-mode)))

;;;; Geiser + Guile：Scheme 交互与补全（geiser 由 geiser-guile 依赖拉取）

(use-package geiser-guile
  :after geiser)
