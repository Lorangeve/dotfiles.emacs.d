;;; packages.el --- straight.el + use-package -*- lexical-binding: t -*-

;; 官方引导：若无 straight 源码则下载 install.el 并检出 bootstrap
;; https://github.com/radian-software/straight.el#bootstrapping-straightel
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; 用 straight 安装带 :straight 集成的 use-package；此后 (use-package foo) 默认会 straight 安装 foo
(straight-use-package 'use-package)
(require 'use-package)
(setq straight-use-package-by-default t)

;; Org：要用内置版时须向 straight 声明 (:type built-in)。否则依赖链可能再装一份 ELPA/GNU 的
;; org，load-path 上两套混用会触发 *Warnings*（版本/宏不一致等）。
(straight-use-package '(org :type built-in))
