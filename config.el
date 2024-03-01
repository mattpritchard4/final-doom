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
  (setq org-roam-directory "~/roam")
  (require 'org-bullets)
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  )

(use-package! org-glossary
  :hook (org-mode . org-glossary-mode))

(after! company
  (setq company-tooltip-align-annotations t)
)
