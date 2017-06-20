MD_FILE = notes.md
PDF_FILE = $(MD_FILE:%.md=%.pdf)

all: pdf

pdf: $(PDF_FILE)

%.pdf: %.md
	pandoc -o $@ $^
