include prelude.mk

MKDIR := mkdir -p --
RMDIR := rm -r --

name := cv
pdf := out/$(name).pdf

.PHONY: DO
DO:

.PHONY: all
all: build

.PHONY: build
build: $(pdf)

.PHONY: build/docker
build/docker:
	docker compose run --build --rm build

$(pdf): $(name).tex img/face.jpg | out/
	pdflatex -interaction=nonstopmode -halt-on-error -output-directory=out/ '$(call escape,$<)'

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
	rsync -avh -e 'ssh -p $(call escape,$(REMOTE_PORT)) -o StrictHostKeyChecking=no' out/ '$(call escape,$(REMOTE_USER)@$(REMOTE_HOST):$(REMOTE_DIR)/)' --delete

.PHONY: clean
clean:
	find out/ '!' -name '$(call escape,$(name).pdf)' -type f -delete

.PHONY: clean-all
clean-all:
	$(RMDIR) out/
