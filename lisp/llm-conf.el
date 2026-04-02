(use-package ellama
  :ensure t
  :custom
  (ellama-language "Chinese") ; 建议改成中文
  (llm-warn-on-nonfree nil)
  :config
  (require 'llm-openai)
  
  ;; 定义 DeepSeek Provider
  (let ((deepseek-provider
         (make-llm-openai-compatible ; <--- 使用这个兼容函数
          :key "sk-4edf7f8afebc4ba581ce6b7b4878e4c5" ; 再次提醒：更换已泄露的 Key
          :chat-model "deepseek-chat"
          :url "https://api.deepseek.com/v1"))) ; 这个函数是支持 :url 的
    
    ;; 将所有的 provider 都统一设置为 DeepSeek
    (setq ellama-provider deepseek-provider)
    (setq ellama-naming-provider deepseek-provider)
    (setq ellama-translation-provider deepseek-provider)
    (setq ellama-summarization-provider deepseek-provider)
    (setq ellama-coding-provider deepseek-provider))

  ;; 其他界面配置
  (ellama-context-header-line-global-mode +1)
  (ellama-session-header-line-global-mode +1))
