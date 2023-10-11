include init.mk

SETUP_CONFIG_FILE=config.org

all: emacs-run-tangle create-symbolic-link

emacs-run-tangle:
	emacs --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "${SETUP_CONFIG_FILE}")'

create-symbolic-link:
	ln --symbolic ${PWD}/templates ~/org-files/
#	ln --verbose --symbolic ~/org-files/templates/ templates

create-new-project:
	@read -p "Ingrese la ruta del proyecto a crear/configurar: " NEW_PROJECT_PATH; \
	mkdir --verbose $${NEW_PROJECT_PATH}; \
	cp --verbose init.mk $${NEW_PROJECT_PATH}/Makefile; \
	cp --verbose .dir-locals.el $${NEW_PROJECT_PATH}; \
	cp --verbose README.org $${NEW_PROJECT_PATH}; \
	make -C $${NEW_PROJECT_PATH} init

.PHONY: all emacs-run-tangle create-symbolic-link create-new-project
