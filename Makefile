include ~/.makefile-utils/Makefile
include init.mk

SETUP_CONFIG_FILE=config.org
PROJECT_NAME=emacs-custom-templates

DIRECTORIES=$(shell cat directories.cfg | xargs)

MAKEFILE_INIT= init.mk
MAKEFILE_INIT_HIDDEN = $(addprefix .,$(MAKEFILE_INIT))

##@ Acciones (Configuración global de Emacs)

# - evaluará todos los bloques de código de un archivo .org (Org Mode) y generará un código fuente .el (Elisp)
# - cargar el código fuente .el en la configuración de .spacemacs
emacs-run-tangle: ## crea/actualiza la configuración de config.org en ~/.emacs.d
	emacs --batch \
				--eval "(require 'org)" \
				--eval '(org-babel-tangle-file "${SETUP_CONFIG_FILE}")'

share-templates: ## genera un enlace simbólico de los templates en ~/org-files a modo de punto de acceso global/compartido
	mkdir --verbose --parents ~/org-files/ \
	&& ln --verbose --symbolic ${PWD}/templates ~/org-files/

##@ Acciones (Crear/Inicializar proyectos)

# Notas
#  1. generalizamos la dependencia del target/objetivo,
#     pero de luego evaluarse/expandirse quedaría: update-projects: $(addsuffix /.init.mk,$(DIRECTORIES))
#
update-projects: $(addsuffix /$(MAKEFILE_INIT_HIDDEN),$(DIRECTORIES)) ## inicializa los proyectos de directories.cfg (recomendado)

# Notas
#  1. el target/objetivo + dependencia lo generalizamos,
#     pero de luego evaluarse/expandirse quedaría: $(addsuffix /.init.mk,$(DIRECTORIES)): init.mk
#
#  2. lo utilizará el target/objetivo llamado update-porjects
$(addsuffix /$(MAKEFILE_INIT_HIDDEN),$(DIRECTORIES)): $(MAKEFILE_INIT)
	@WHIPTAIL_DESCRIPTION="Archivo:\n $(notdir $@) \n\nRuta origen:\n $(dir $<) \n\nRuta destino:\n $(dir $@)"; \
	$(WHIPTAIL_CONFIRM_COPY_ACTION) \
	&& echo "Copiando de $< en $(dir $@)" \
		&& cp --verbose $< $@ \
		&& make --no-print-directory --directory=$(dir $@) --file=$(notdir $@) init \
	|| echo "Confirmación cancelada"

# TODO: notificar la creación del makefile oculto
# TODO: evaluar necesidad copiar la configuración de .dir-locals.el
create-new-project: ## crea una estructura de directorios con los templates (no tan recomendado, no persiste en directories.cfg)
	echo "Proyecto a crear/configurar" \
	&& read -p " > Ingrese la ruta : " NEW_PROJECT_PATH \
	&& mkdir --verbose --parents $${NEW_PROJECT_PATH} \
	&& cp --verbose $(MAKEFILE_INIT) $${NEW_PROJECT_PATH}/$(MAKEFILE_INIT_HIDDEN) \
	&& make --no-print-directory --directory=$${NEW_PROJECT_PATH} --file=$(MAKEFILE_INIT_HIDDEN) init

.PHONY: all emacs-run-tangle create-symbolic-link create-new-project
