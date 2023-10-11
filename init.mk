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

.PHONY: init
