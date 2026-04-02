;; 使用 Emacs 29+ 引入的 terminal-set-clipboard-handler
(defun wayland-copy (text)
  (let ((process-connection-type nil))
    (let ((proc (start-process "wl-copy" nil "wl-copy" "--trim-newline")))
      (process-send-string proc text)
      (process-send-eof proc))))

(defun wayland-paste ()
  (shell-command-to-string "wl-paste --no-newline"))

;; 针对终端环境的特殊优化
(unless (display-graphic-p)
  (setq interprogram-cut-function 'wayland-copy)
  (setq interprogram-paste-function 'wayland-paste))
