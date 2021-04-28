;;; lisa_utils.el 


;;;;;;;;;;;;;;
;; org-mode ;;
;;;;;;;;;;;;;;


(use-package org-roam-bibtex
  :after org-roam
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :custom
  (orb-preformat-keywords '("citekey" "title" "url" "author-or-editor" "keywords" "file"))
  (orb-file-field-extensions '("pdf" "epub" "html"))

  (orb-templates
   '(("r" "ref" plain (function org-roam-capture--get-point)
      ""
      :file-name "${citekey}"
      :head "#+TITLE: ${citekey}: ${title}
#+ROAM_KEY: ${ref}
- tags ::
- keywords :: ${keywords}
* ${title}
  :PROPERTIES:
  :Custom_ID: ${citekey}
  :URL: ${url}
  :AUTHOR: ${author-or-editor}
  :NOTER_DOCUMENT: ${file}
  :NOTER_PAGE:
  :END:"))))

(use-package org-pdftools
  :hook (org-load . org-pdftools-setup-link))

(use-package org-noter
  :after (:any org pdf-view)
  :custom
  (org-noter-always-create-frame nil)
  (org-noter-separate-notes-from-heading t)
  (org-noter-default-notes-file-names '("notes.org"))
  (org-noter-notes-search-path (list org-roam-directory)))

(use-package org-noter-pdftools
  :after org-noter
  :config
  (with-eval-after-load 'pdf-annot
    (add-hook 'pdf-annot-activate-handler-functions #'org-noter-pdftools-jump-to-note)))

(provide 'lisa_utils)
