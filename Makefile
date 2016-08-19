.PHONY: clean clean-all

cv.pdf : cv.tex img/selfie_face.jpg
	pdflatex -interaction=nonstopmode -halt-on-error $<

clean :
	$(RM) *.aux *.log *.out

clean-all : clean
	$(RM) *.pdf
