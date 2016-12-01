CC=pdflatex
SRC=.render
DST=../pdf

texdoc=$(wildcard $(SRC)/**/*.tex)
all: $(patsubst %.tex, %.pdf, $(texdoc))

%.pdf: %.tex
	$(CC) $<
	$(CC) $<
	mkdir -p $(DST)/$(dir $(patsubst .render/%, %, $@))
	cp $(patsubst %.tex, %.pdf, $(notdir $<)) $(patsubst .render/%, $(SRC)/%, $@)
	mv $(patsubst %.tex, %.pdf, $(notdir $<)) $(patsubst .render/%, $(DST)/%, $@)

render-clean:
	rm -Rf .render/*

clean:
	rm -f *.aux *.toc *.log *.out *.pdf *.lot *.lof
