;;; clipboard.el --- 终端下系统剪贴板（GUI 通常无需） -*- lexical-binding: t -*-
;;
;; `-nw` 或 SSH 终端里 Emacs 默认不桥接系统剪贴板，此处用平台命令行工具补齐。

(defun my/clipboard-copy (text)
  (let ((process-connection-type nil)) ;; 子进程用 pipe，避免 pty 吃掉二进制/大量文本
    (cond
     ;; Wayland：需安装 wl-clipboard
     ((and (eq system-type 'gnu/linux) (getenv "WAYLAND_DISPLAY"))
      (let ((proc (start-process "wl-copy" nil "wl-copy" "--trim-newline")))
        (process-send-string proc text)
        (process-send-eof proc)))
     ((eq system-type 'darwin)
      (let ((proc (start-process "pbcopy" nil "pbcopy")))
        (process-send-string proc text)
        (process-send-eof proc)))
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
    (shell-command-to-string "powershell.exe -command Get-Clipboard"))))

(unless (display-graphic-p)
  (setq interprogram-cut-function #'my/clipboard-copy)
  (setq interprogram-paste-function #'my/clipboard-paste))

(provide 'clipboard)
