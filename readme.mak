# Make readme.html using mingw32-make


SHELL=cmd.exe

TARGETS=README.html

RM=del

all: $(TARGETS)

README.html: README.md
	pandoc -f markdown+multiline_tables+table_captions-implicit_figures -s --toc --toc-depth=4 --email-obfuscation=references -V lang=zh --css=docs/style.css --metadata pagetitle="THKMC Readme" -o $@ $<


clean:
	-$(RM) $(TARGETS)


.SUFFIXES:

.PHONY: clean
