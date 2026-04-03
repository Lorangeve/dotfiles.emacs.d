;;; init.el --- Emacs 配置入口 -*- lexical-binding: t -*-

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(let ((lisp-dir (expand-file-name "lisp" user-emacs-directory)))
  (add-to-list 'load-path lisp-dir)
  (dolist (file '("core"
		  "packages"
		  "completion"
		  "editing"
		  "lang"
		  "input"
		  "appearance"
		  "tools"
		  "llm-conf"))
    (load (expand-file-name (concat file ".el") lisp-dir) nil 'nomessage)))
(put 'set-goal-column 'disabled nil)
