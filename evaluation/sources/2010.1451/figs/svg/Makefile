.PHONY: all clean

%.pdf: %.svg
	inkscape -D --export-latex --export-filename=$@ $<
	sed -i '' 's/$@/figs\/svg\/$@/g' $@_tex

all: lasers1.pdf lasers2.pdf beamline_to_state_prep_b.pdf

clean:
	rm -f *.pdf *.pdf_tex
