### Makefile for LaTeX under Mac OS X
### Author: Franco Maria Nardini (francomaria.nardini@isti.cnr.it)
# pdflatex, textmate, and skim are needed to run properly all the commands here.

# Some assumptions:
# ./img: is the directory containing images
# ./style: is the directory containing the .cls and .sty

# NAME OF THE MAIN FILE (WITHOUT .tex)
BASEFILENAME=paper

# NAME OF THE CAMERA READY FILE (WITHOUT .pdf)
DESTFILENAME=

# NAME OF THE COVER LETTER FILE (WITHOUT .pdf)
COVERFILENAME=


#NAME OF THE REVIEW ANSWER FILE (WITHOUT .pdf)

all:
	@make clean
	@make pdf
	@open -F -a skim ${BASEFILENAME}.pdf &
	@open -F -a skim ${REVIEWANSWER}.pdf &

pdf:
	@pdflatex ${BASEFILENAME}.tex
	@bibtex ${BASEFILENAME}
	@pdflatex ${BASEFILENAME}.tex
	@pdflatex ${BASEFILENAME}.tex

	

pdf-cameraready:
	@pdflatex ${BASEFILENAME}.tex
	@pdflatex ${BASEFILENAME}.tex
	@mv ${BASEFILENAME}.pdf ${DESTFILENAME}.pdf
	@open -F -a skim ${DESTFILENAME}.pdf

pdf-coverletter:
	@pdflatex ${COVERFILENAME}.tex
	@bibtex ${BASEFILENAME}
	@pdflatex ${COVERFILENAME}.tex
	@pdflatex ${COVERFILENAME}.tex
	@rm ${COVERFILENAME}.aux
	@rm ${COVERFILENAME}.log
	@open -F -a skim ${COVERFILENAME}.pdf

answer:
	@pdflatex ${REVIEWANSWER}.tex
	@bibtex ${REVIEWANSWER}
	@pdflatex ${REVIEWANSWER}.tex
	@pdflatex ${REVIEWANSWER}.tex
	@open -F -a skim ${REVIEWANSWER}.pdf &

images:
	@for filename in `ls ./img/*.eps`; do epstopdf $$filename; done;

count:
	@pdftotext ${BASEFILENAME}.pdf WORDS
	@wc --words WORDS
	@rm -f WORDS

clean:
	@rm -f ./img/*~ *~ *vtc *spl .*.lb *loa *aux *dvi *maf *mtc *mtc0 *log *fls *lof *lot *out *pdf *bbl *blg *ps *idx *toc *fdb_latexmk *synctex.gz *auxlock *cut *vtc *synctex* *vtc

chkrefs:
	@bibtex ${BASEFILENAME}

tgz:
	@tar -czf $(PWD)\ `date +%Y%m%d%H%M`.tar.gz *tex *tmproj *bib ./img/* ./style/*

svn-commit:
	@svn update
	@svn commit -m "`date +%Y%m%d%H%M` - FM"

svn-update:
	@svn update

git-commit-push:
	@git commit -am "`date +%Y%m%d%H%M` - FM"
	@git push origin master

git-pull:
	@git pull origin master

