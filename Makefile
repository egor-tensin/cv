MAKEFLAGS += --no-builtin-rules --no-builtin-variables --warn-undefined-variables
.DEFAULT_GOAL := all
.DELETE_ON_ERROR:
.SUFFIXES:
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c

MKDIR := mkdir -p --
RMDIR := $(RM) -r --

name := cv
pdf := $(name)/$(name).pdf

.PHONY: DO
DO:

.PHONY: all
all: $(pdf)

$(pdf): $(name).tex img/selfie_face.jpg | $(name)/
	pdflatex -interaction=nonstopmode -halt-on-error -output-directory=$(name)/ $<

%/:
	$(MKDIR) $@

.PHONY: clean
clean:
	find $(name) '!' -name cv.pdf -type f -delete

.PHONY: clean-all
clean-all:
	$(RMDIR) $(name)/
