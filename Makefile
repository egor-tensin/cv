include prelude.mk

MKDIR := mkdir -p --
RMDIR := rm -r --

name := cv
pdf := $(name)/$(name).pdf

.PHONY: DO
DO:

.PHONY: all
all: build

.PHONY: build
build: $(pdf)

.PHONY: build/docker
build/docker:
	docker compose run --rm build

$(pdf): $(name).tex img/face.jpg | $(name)/
	pdflatex -interaction=nonstopmode -halt-on-error '-output-directory=$(call escape,$(name))/' '$(call escape,$<)'

%/:
	$(MKDIR) '$(call escape,$@)'

.PHONY: view
view:
	xdg-open '$(call escape,$(pdf))' &> /dev/null

REMOTE_USER ?= who
REMOTE_HOST ?= where
REMOTE_PORT ?= 22
REMOTE_DIR  ?= /path/to/dir

$(eval $(call noexpand,REMOTE_USER))
$(eval $(call noexpand,REMOTE_HOST))
$(eval $(call noexpand,REMOTE_PORT))
$(eval $(call noexpand,REMOTE_DIR))

.PHONY: deploy
deploy:
	rsync -avh -e 'ssh -p $(call escape,$(REMOTE_PORT)) -o StrictHostKeyChecking=no' '$(call escape,$(name)/)' '$(call escape,$(REMOTE_USER)@$(REMOTE_HOST):$(REMOTE_DIR)/)' --delete

.PHONY: clean
clean:
	find '$(call escape,$(name))' '!' -name '$(call escape,$(name).pdf)' -type f -delete

.PHONY: clean-all
clean-all:
	$(RMDIR) '$(call escape,$(name))/'
