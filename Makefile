include init.mk

SETUP_CONFIG_FILE=config.org

all: emacs-run-tangle create-symbolic-link

emacs-run-tangle:
	emacs --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "${SETUP_CONFIG_FILE}")'

create-symbolic-link:
	ln --symbolic ${PWD}/templates ~/org-files/
#	ln --verbose --symbolic ~/org-files/templates/ templates

.PHONY: all emacs-run-tangle create-symbolic-link
