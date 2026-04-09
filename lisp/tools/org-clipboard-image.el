;;; org-clipboard-image.el --- Org：从剪贴板插入图片 -*- lexical-binding: t -*-
;;
;; `yank-media' 在 PGTK/Wayland 上可能在调用 Org 的 handler 之前就因剪贴板数据异常而报错。
;; 本模块绕过 yank-media，用 wl-paste / xclip / gui-get-selection 取二进制，再调用
;; `org--image-yank-media-handler'。

;;; Code:

(declare-function org--image-yank-media-handler "org" (mimetype data))

(defun my/org-clipboard-data-bogus-mime-string-p (data)
  "若像纯 MIME 类型字面量而非图片字节，则为 t。"
  (and (stringp data)
       (< (length data) 256)
       (string-match-p "\\`[[:alnum:].+-]+/[[:alnum:].+-]+\\'" data)))

(defun my/org-bytes-image-mime-type (data)
  "根据魔数猜测 MIME 类型（symbol）。"
  (cond
   ((and (>= (length data) 8)
         (equal (substring data 0 8) "\211PNG\r\n\032\n"))
    'image/png)
   ((and (>= (length data) 3)
         (equal (substring data 0 3) "\377\330\377"))
    'image/jpeg)
   ((and (>= (length data) 12)
         (equal (substring data 0 4) "RIFF")
         (equal (substring data 8 12) "WEBP"))
    'image/webp)
   (t 'image/png)))

(defun my/org--clipboard-bytes-from-wl-paste ()
  "用 wl-paste 取剪贴板图片（unibyte string），失败返回 nil。
不依赖 XDG_SESSION_TYPE：只要有 wl-paste 就试（混合会话也常见）。"
  (when (executable-find "wl-paste")
    (catch 'my/org-got
      (dolist (args '(nil ("-t" "image/png") ("-t" "image/jpeg") ("-t" "image/webp")))
        (let ((bin (with-temp-buffer
                     (set-buffer-multibyte nil)
                     (and (zerop (if args
                                     (apply #'call-process
                                            "wl-paste" nil t nil args)
                                   (call-process "wl-paste" nil t nil)))
                          (buffer-string)))))
          (when (and bin
                     (> (length bin) 32)
                     (not (my/org-clipboard-data-bogus-mime-string-p bin)))
            (throw 'my/org-got bin)))))))

(defun my/org--clipboard-bytes-from-xclip ()
  "用 xclip 取剪贴板图片，失败返回 nil。"
  (when (executable-find "xclip")
    (catch 'my/org-got
      (dolist (mime '("image/png" "image/jpeg" "image/webp"))
        (let ((bin (with-temp-buffer
                     (set-buffer-multibyte nil)
                     (and (zerop (call-process
                                  "xclip" nil t nil
                                  "-selection" "clipboard"
                                  "-t" mime "-o"))
                          (buffer-string)))))
          (when (and bin
                     (> (length bin) 32)
                     (not (my/org-clipboard-data-bogus-mime-string-p bin)))
            (throw 'my/org-got bin)))))))

(defun my/org--clipboard-bytes-from-gui ()
  "用 `gui-get-selection' 取图（在少数环境仍可用）。"
  (catch 'my/org-got
    (dolist (ty '(image/png image/jpeg image/webp))
      (let ((raw (gui-get-selection 'CLIPBOARD ty)))
        (when (and (stringp raw)
                   (not (my/org-clipboard-data-bogus-mime-string-p raw))
                   (> (length raw) 32))
          (throw 'my/org-got raw))))))

(defun my/org-get-clipboard-image-bytes ()
  "返回剪贴板图片二进制字符串，顺序：wl-paste、xclip、gui。"
  (or (my/org--clipboard-bytes-from-wl-paste)
      (my/org--clipboard-bytes-from-xclip)
      (my/org--clipboard-bytes-from-gui)))

(defun my/org-yank-clipboard-image ()
  "把剪贴板里的图片存到 `org-yank-image-save-method' 并插入 Org 链接。"
  (interactive)
  (unless (derived-mode-p 'org-mode)
    (user-error "仅在 Org 模式下使用"))
  (unless (display-graphic-p)
    (user-error "剪贴板插图需要图形界面 Emacs"))
  (let ((data (my/org-get-clipboard-image-bytes)))
    (unless data
      (user-error
       "剪贴板里没有可用的图片数据。请确认已复制图片；Linux 请安装 wl-clipboard（wl-paste）或 xclip，并在系统里试跑: wl-paste -t image/png | wc -c"))
    (let ((mime (my/org-bytes-image-mime-type data)))
      (org--image-yank-media-handler mime data))))

(with-eval-after-load 'org
  (setq org-yank-image-save-method "images")
  (define-key org-mode-map (kbd "C-M-y") #'my/org-yank-clipboard-image))

(provide 'org-clipboard-image)

;;; org-clipboard-image.el ends here
