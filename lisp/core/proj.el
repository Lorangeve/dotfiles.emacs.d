;;; proj.el --- project.el 内置配置 -*- lexical-binding: t -*-

;; project-find-file 等除 .git 外，看到这些文件/目录也视为项目根
(use-package project
  :straight nil
  :custom
  (project-vc-extra-root-markers '(".jj"
                                   "package.json"
                                   "Cargo.toml"
                                   "Makefile")))
