;;; Emacs 29+ 引入的 terminal-set-clipboard-handler

(defun my/clipboard-copy (text)
  (let ((process-connection-type nil))
    (cond
     ;; Wayland (Arch Linux)
     ((and (eq system-type 'gnu/linux) (getenv "WAYLAND_DISPLAY"))
      (let ((proc (start-process "wl-copy" nil "wl-copy" "--trim-newline")))
        (process-send-string proc text)
        (process-send-eof proc)))
     ;; macOS
     ((eq system-type 'darwin)
      (let ((proc (start-process "pbcopy" nil "pbcopy")))
        (process-send-string proc text)
        (process-send-eof proc)))
     ;; Windows
     ((eq system-type 'windows-nt)
      (let ((proc (start-process "clip" nil "clip")))
        (process-send-string proc text)
        (process-send-eof proc))))))

(defun my/clipboard-paste ()
  (cond
   ((and (eq system-type 'gnu/linux) (getenv "WAYLAND_DISPLAY"))
    (shell-command-to-string "wl-paste --no-newline"))
   ((eq system-type 'darwin)
    (shell-command-to-string "pbpaste"))
   ((eq system-type 'windows-nt)
    ;; Windows 下使用 powershell 处理剪贴板比较稳妥
    (shell-command-to-string "powershell.exe -command Get-Clipboard"))))

;; 只有在终端模式下才手动接管（GUI 模式通常自带支持）
(unless (display-graphic-p)
  (setq interprogram-cut-function 'my/clipboard-copy)
  (setq interprogram-paste-function 'my/clipboard-paste))
