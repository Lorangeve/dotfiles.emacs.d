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

;; (setq geiser-active-implementations '(guile))

(use-package geiser-guile
  :ensure t
  :after geiser
  ;; :custom
  ;; 如果你的 guile 可执行文件不在 PATH 中，可以在这里指定路径
  ;; (geiser-guile-binary "guile")
  ;; 开启智能辅助，比如在输入时自动显示函数签名
  ;; (geiser-guile-load-init-file t)
  )
