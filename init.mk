# TODO: copiado/utilizado en cada proyecto nuevo
PAGES=articles courses books issues users-dotfiles documentation tasks videos
ORG_PAGES=$(addsuffix .org,$(PAGES))

init:
	mkdir pages \
	&& touch $(addprefix pages/,$(ORG_PAGES))

.PHONY: init
