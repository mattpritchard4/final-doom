;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq doom-theme 'doom-one)
(setq display-line-numbers-type t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(setq doom-font (font-spec :family "DejaVuSansMono Nerd Font" :size 14))

(global-subword-mode 1)

(setq mac-command-modifier 'meta)
(setq mac-function-modifier 'control)

(map! "<f7>" #'toggle-frame-fullscreen
      "C-x m" #'magit-status
      "C-c SPC" #'avy-goto-char-2
      "M-g M-g" #'avy-goto-line
      "\C-s" #'swiper
      "C-S-c C-S-c" #'mc/edit-lines
      "C-<" #'mc/mark-previous-like-this
      "C->" #'mc/mark-next-like-this
      "C-c C-<" #'mc/mark-all-like-this
      "M-o" #'ace-window
      "M-s M-s" #'ace-swap-window
      "C-c s" #'lsp-ui-sideline-toggle-symbols-info
      "C-c C-r" #'lsp-rename
      "C-c L" #'lsp-ui-flycheck-list
      "<f8>" #'treemacs
      "C-j" #'emmet-expand-line
      "C-S-R" #'sp-rewrap-sexp
      "C-S-U" #'sp-unwrap-sexp
      "C-<tab>" #'+fold/toggle
)

(setq +format-with-lsp nil)

(add-hook! 'js2-mode-hook
           'js-mode-hook
           'rjsx-mode-hook
           'web-mode-hook
           'typescript-mode-hook #'prettier-js-mode)

(add-hook! 'typescript-mode-hook (local-unset-key "\'"))
(add-hook! 'typescript-mode-hook (local-unset-key "\""))
(add-hook! 'typescript-mode-hook (local-unset-key "("))

(after! typescript
  (defun typescript-mode-setup ()
    "Custom setup for Typescript mode"
    (setq flycheck-checker 'javascript-eslint)
  )
  (add-hook 'typescript-mode-hook 'typescript-mode-setup)
)

(add-to-list 'projectile-globally-ignored-directories "*/node_modules/")
(setq projectile-indexing-method 'native)

(after! org
  (setq org-directory "~/org/")
  (setq org-log-done 'time)
  (setq org-log-done 'note)
  )

(use-package! org-glossary
  :hook (org-mode . org-glossary-mode))

(use-package! org-roam
              :ensure t
              :custom
              (org-roam-directory (file-truename "~/org/roam/"))
              :config
              (org-roam-db-autosync-mode))

(setq org-latex-toc-command "\\tableofcontents \\clearpage")

(defun yas/org-very-safe-expand ()
  (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))

(add-hook 'org-mode-hook
          (lambda ()
            (make-variable-buffer-local 'yas/trigger-key)
            (setq yas/trigger-key [tab])
            (add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)
            (define-key yas/keymap [tab] 'yas/next-field)))

;; set up tikz as one of the default packages for LaTeX
(setq org-latex-packages-alist
      (quote (("" "color" t)
          ("" "minted" t)
          ("" "parskip" t)
          ("" "tikz" t))))

(after! company
  (setq company-tooltip-align-annotations t)
)

(after! rescript-mode
  (setq lsp-rescript-server-command
        '("rescript-language-server" "--stdio"))
  ;; Tell `lsp-mode` about the `rescript-vscode` LSP server
  (require 'lsp-rescript)
  ;; Enable `lsp-mode` in rescript-mode buffers
  (add-hook 'rescript-mode-hook 'lsp-deferred)
  ;; Enable display of type information in rescript-mode buffers
  (require 'lsp-ui)
  (add-hook 'rescript-mode-hook 'lsp-ui-doc-mode))
