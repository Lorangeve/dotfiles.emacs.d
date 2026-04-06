;;; llm-conf.el --- Ellama / LLM -*- lexical-binding: t -*-
;;
;; API Key 请勿提交到公开仓库；宜改用 (getenv "…") 或 auth-source。

(use-package ellama
  ;; 不在启动时 require；首次执行任一列出的命令（或包自带的 M-x）时再加载并执行 :config
  :commands (ellama-chat ellama-ask-about ellama-code-complete)
  :custom
  (ellama-language "Chinese")
  ;; 部分 llm 包协议非 OSI 认证；关闭警告以免刷屏
  (llm-warn-on-nonfree nil)
  :config
  (require 'llm-openai)
  ;; DeepSeek 提供 OpenAI 兼容 HTTP API，故用 make-llm-openai-compatible
  (let ((deepseek-provider
         (make-llm-openai-compatible
          ;; TODO: 轮换已泄露密钥并改为从环境变量读取
          :key "sk-4edf7f8afebc4ba581ce6b7b4878e4c5"
          :chat-model "deepseek-chat"
          :url "https://api.deepseek.com/v1")))
    (setq ellama-provider deepseek-provider)
    (setq ellama-naming-provider deepseek-provider)
    (setq ellama-translation-provider deepseek-provider)
    (setq ellama-summarization-provider deepseek-provider)
    (setq ellama-coding-provider deepseek-provider))
  ;; 全局 header 会在所有缓冲区显示 session/context；按需请手动：
  ;; M-x ellama-session-header-line-global-mode / ellama-context-header-line-global-mode
  )
