MAKEFLAGS += --no-builtin-rules --no-builtin-variables --warn-undefined-variables
unexport MAKEFLAGS
.DEFAULT_GOAL := all
.DELETE_ON_ERROR:
.SUFFIXES:
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c

.PHONY: DO
DO:

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

.PHONY: all
all: $(pdf)

$(pdf): $(name).tex img/selfie_face.jpg | $(name)/
	pdflatex -interaction=nonstopmode -halt-on-error '-output-directory=$(call escape,$(name))/' '$(call escape,$<)'

%/:
	$(MKDIR) '$(call escape,$@)'

.PHONY: clean
clean:
	find '$(call escape,$(name))' '!' -name cv.pdf -type f -delete

.PHONY: clean-all
clean-all:
	$(RMDIR) '$(call escape,$(name))/'
