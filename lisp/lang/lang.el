;;; lang.el --- Tree-sitter、major-mode 与 Eglot -*- lexical-binding: t -*-

;;;; Tree-sitter grammar 源
;; `treesit-install-language-grammar' 等会按语言符号下载；名称须与 Emacs 内置 *-ts-mode 一致（如 c-sharp）

(setq treesit-language-source-alist
      '((bash "https://github.com/tree-sitter/tree-sitter-bash" "master" "src")
        (c "https://github.com/tree-sitter/tree-sitter-c" "master" "src")
        (cpp "https://github.com/tree-sitter/tree-sitter-cpp" "master" "src")
        (cmake "https://github.com/uyha/tree-sitter-cmake" "master" "src")
        (css "https://github.com/tree-sitter/tree-sitter-css" "master" "src")
        (c-sharp "https://github.com/tree-sitter/tree-sitter-c-sharp" "master" "src")
        (dockerfile "https://github.com/camdencheek/tree-sitter-dockerfile" "master" "src")
        (doxygen "https://github.com/tree-sitter-grammars/tree-sitter-doxygen" "master" "src")
        (elixir "https://github.com/elixir-lang/tree-sitter-elixir" "main" "src")
        (heex "https://github.com/phoenixframework/tree-sitter-heex" "main" "src")
        (go "https://github.com/tree-sitter/tree-sitter-go" "master" "src")
        (gomod "https://github.com/camdencheek/tree-sitter-go-mod" "master" "src")
        (gowork "https://github.com/omertuc/tree-sitter-go-work" "master" "src")
        (html "https://github.com/tree-sitter/tree-sitter-html" "master" "src")
        (java "https://github.com/tree-sitter/tree-sitter-java" "master" "src")
        (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
        (jsdoc "https://github.com/tree-sitter/tree-sitter-jsdoc" "master" "src")
        (json "https://github.com/tree-sitter/tree-sitter-json" "master" "src")
        (lua "https://github.com/tree-sitter-grammars/tree-sitter-lua" "master" "src")
        (php "https://github.com/tree-sitter/tree-sitter-php" "master" "php/src")
        (phpdoc "https://github.com/claytonrcarter/tree-sitter-phpdoc" "master" "src")
        (python "https://github.com/tree-sitter/tree-sitter-python" "master" "src")
        (ruby "https://github.com/tree-sitter/tree-sitter-ruby" "master" "src")
        (rust "https://github.com/tree-sitter/tree-sitter-rust" "master" "src")
        (toml "https://github.com/tree-sitter-grammars/tree-sitter-toml" "master" "src")
        (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
        (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
        (yaml "https://github.com/tree-sitter-grammars/tree-sitter-yaml" "master" "src")))

;;;; 打开 “旧” major-mode 文件时自动用内置 tree-sitter 版本（需已安装对应 grammar）

(setq major-mode-remap-alist
      (append
       '((c-mode . c-ts-mode)
         (c++-mode . c++-ts-mode)
         (c-or-c++-mode . c-or-c++-ts-mode)
         (sh-mode . bash-ts-mode)
         (python-mode . python-ts-mode)
         (ruby-mode . ruby-ts-mode)
         (rust-mode . rust-ts-mode)
         (go-mode . go-ts-mode)
         (go-mod-mode . go-mod-ts-mode)
         (go-work-mode . go-work-ts-mode)
         (java-mode . java-ts-mode)
         (csharp-mode . csharp-ts-mode)
         (js-mode . js-ts-mode)
         (typescript-mode . typescript-ts-mode)
         (tsx-mode . tsx-ts-mode)
         (js-json-mode . json-ts-mode)
         (json-mode . json-ts-mode)
         (css-mode . css-ts-mode)
         (yaml-mode . yaml-ts-mode)
         (php-mode . php-ts-mode)
         (lua-mode . lua-ts-mode)
         (dockerfile-mode . dockerfile-ts-mode)
         (cmake-mode . cmake-ts-mode)
         (elixir-mode . elixir-ts-mode)
         (conf-toml-mode . toml-ts-mode))
       (when (fboundp 'mhtml-ts-mode)
         '((mhtml-mode . mhtml-ts-mode)))))

;;;; 语言扩展（内置模式，勿从 ELPA 再装一份）

(use-package typescript-ts-mode
  :ensure nil
  :mode (("\\.ts\\'" . typescript-ts-mode)
         ("\\.tsx\\'" . tsx-ts-mode)))

(use-package kdl-mode
  :mode (("\\.kdl\\'" . kdl-mode)))

;;;; Eglot（内置 LSP 客户端）
;; guile-lsp-server：Scheme
;; Emacs ≥30.2：TS/TSX 由 eglot-typescript-preset 经 rass 同时拉起
;;   typescript-language-server 与 tailwindcss-language-server
;;   （PATH：rass、typescript-language-server、tailwindcss-language-server；项目或全局需有 typescript）
;; 较低版本：仅直连 typescript-language-server，无同 buffer Tailwind LSP

(use-package eglot
  :ensure nil
  :hook ((python-ts-mode . eglot-ensure)
         (rust-ts-mode . eglot-ensure)
         (typescript-ts-mode . eglot-ensure)
         (tsx-ts-mode . eglot-ensure)
         (scheme-mode . eglot-ensure))
  :config
  (add-to-list 'eglot-server-programs '(scheme-mode . ("guile-lsp-server")))
  (unless (version<= "30.2" emacs-version)
    (add-to-list 'eglot-server-programs
                 '((typescript-ts-mode tsx-ts-mode)
                   . ("typescript-language-server" "--stdio")))))

(when (version<= "30.2" emacs-version)
  (use-package eglot-typescript-preset
    :ensure nil
    :after eglot
    :vc (:url "https://github.com/mwolson/eglot-typescript-preset"
         :main-file "eglot-typescript-preset.el")
    ;; 须在 require 触发 preset 的 setup 之前写入（setup 在加载 el 末尾即执行）
    :init
    (setq eglot-typescript-preset-lsp-server 'rass)
    (setq eglot-typescript-preset-rass-tools
          '(typescript-language-server tailwindcss-language-server))))
