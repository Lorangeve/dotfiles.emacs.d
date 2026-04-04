(use-package project
  :ensure nil
  :custom
  (project-vc-extra-root-markers '(".jj"
				   "package.json"
				   "Cargo.toml"
				   "Makefile")))
