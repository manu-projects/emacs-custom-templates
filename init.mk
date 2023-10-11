# TODO: problemas entre la lectura en la subshell de bash de create-new-project
CONFIG_FILES=init.mk .dir-locals.el

DIRECTORIES=pages articles
PAGES=articles courses books issues users-dotfiles documentation tasks videos
ORG_PAGES=$(addprefix pages/,\
					$(addsuffix .org,$(PAGES)))

$(DIRECTORIES):
	mkdir --verbose $@ \
	&& touch $@/.gitkeep

$(ORG_PAGES):
	touch $@

init: $(DIRECTORIES) $(ORG_PAGES)

create-new-project:
	@read -p "Ingrese la ruta del proyecto a crear/configurar: " NEW_PROJECT_PATH; \
	mkdir --verbose $${NEW_PROJECT_PATH}; \
	cp --verbose init.mk $${NEW_PROJECT_PATH}/Makefile; \
	cp --verbose .dir-locals.el $${NEW_PROJECT_PATH}; \
	make -C $${NEW_PROJECT_PATH} init

.PHONY: init create-new-project
