MKDIR = mkdir -p
RMDIR = $(RM) -r

name = cv

$(name)/$(name).pdf : $(name).tex $(name)/ img/*
	pdflatex -interaction=nonstopmode -halt-on-error -output-directory=$(name)/ $<

$(name)/ :
	$(MKDIR) $@

.PHONY : clean clean-all

clean :

clean-all : clean
	$(RMDIR) $(name)/
