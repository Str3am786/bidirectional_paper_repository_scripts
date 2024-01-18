TeX = xelatex

.PHONY: full clean figs

main.pdf: main.tex figs
	$(TeX) main

full: main.tex references.bib figs
	$(TeX) main
	bibtex main
	$(TeX) main
	$(TeX) main

clean:
	rm -f *.aux *.bbl *.blg *.log *.out *.pdf
	$(MAKE) clean -C figs

figs:
	$(MAKE) -C figs
