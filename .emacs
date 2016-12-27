;; ~/.emacs

;; Basics

(defvar required-packages '(better-defaults
                            solarized-theme) "Default Packages")

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24) (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

(setq inhibit-splash-screen t)
(setq initial-scratch-message nil)

(setq auto-save-default nil)
(setq make-backup-files nil)

(setq kill-whole-line t)
(delete-selection-mode t)
(fset 'yes-or-no-p 'y-or-n-p)
(setq ring-bell-function 'ignore)

;; Functions

(defun backward-kill-line (arg)
  "Kill chars backward until encountering the beginning of a line.  If the
  cursor is already at the beginning, delete the newline.  Acts like the reverse
  of kill-line (C-k)."
  (interactive "p")
  (kill-line 0))

(defun backward-kill-line-or-newline ()
  "Same as backward-kill-line except if the cursor is at the beginning of the
  line, kill the character after the cursor.  Effectively the reverse of
  kill-line (C-k)"
  (interactive)
  (if (equal (point) (line-beginning-position))
    (backward-delete-char 1) (backward-kill-line 1)))

(defun kill-line-or-region ()
  "kill region if active only or kill line normally"
  (interactive)
  (if (region-active-p)
    (call-interactively 'kill-region)
    (call-interactively 'kill-line)))

(defun backward-kill-line-or-region ()
  "kill region if active only or kill line normally"
  (interactive)
  (if (region-active-p)
    (call-interactively 'kill-region)
    (call-interactively 'backward-kill-line-or-newline)))

(require 'cl)

(defun packages-installed-p ()
  (loop for p in required-packages when (not (package-installed-p p))
    do (return nil) finally (return t)))

(unless (packages-installed-p)
  (message "%s" "Emacs is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  (dolist (p required-packages)
    (when (not (package-installed-p p)) (package-install p))))

;; Keybindings

(global-set-key (kbd "C-k") 'kill-line-or-region)
(global-set-key (kbd "C-u") 'backward-kill-line-or-region)

;; Packages

(load-theme 'solarized-dark t)
