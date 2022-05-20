MAKEFLAGS += --no-builtin-rules --no-builtin-variables --warn-undefined-variables
unexport MAKEFLAGS
.DEFAULT_GOAL := all
.DELETE_ON_ERROR:
.SUFFIXES:
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c

escape = $(subst ','\'',$(1))

define noexpand
ifeq ($$(origin $(1)),environment)
    $(1) := $$(value $(1))
endif
ifeq ($$(origin $(1)),environment override)
    $(1) := $$(value $(1))
endif
ifeq ($$(origin $(1)),command line)
    override $(1) := $$(value $(1))
endif
endef

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
	docker-compose run --rm build

$(pdf): $(name).tex img/face2020_warm.jpg | $(name)/
	pdflatex -interaction=nonstopmode -halt-on-error '-output-directory=$(call escape,$(name))/' '$(call escape,$<)'

%/:
	$(MKDIR) '$(call escape,$@)'

.PHONY: view
view:
	xdg-open '$(call escape,$(pdf))' &> /dev/null

.PHONY: clean
clean:
	find '$(call escape,$(name))' '!' -name '$(call escape,$(name).pdf)' -type f -delete

.PHONY: clean-all
clean-all:
	$(RMDIR) '$(call escape,$(name))/'
