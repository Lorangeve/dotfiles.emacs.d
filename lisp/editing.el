;;; editing.el --- 结构化编辑与 Company -*- lexical-binding: t -*-

(use-package paredit
  :ensure t
  :hook ((emacs-lisp-mode . paredit-mode)
         (lisp-mode       . paredit-mode)
         (clojure-mode    . paredit-mode)
         (scheme-mode     . paredit-mode)))

(use-package company
  :ensure t
  :init
  (global-company-mode))
