# Make documentation using mingw32-make
#
# Need additional programs: pandoc 2.7.2, gvim


SHELL=cmd.exe

TARGETS=help.html thkmc_sample_ini.html

RM=del

all: $(TARGETS)

help.html: help.md
	pandoc -f markdown+multiline_tables+table_captions-implicit_figures -s --toc --toc-depth=4 --email-obfuscation=references -V lang=zh --css=style.css --metadata pagetitle="THKMC Help" -o $@ $<

thkmc_sample_ini.html: ../thkmc_sample.ini | tohtmlhelper.vim
	gvim -S tohtmlhelper.vim $<

.INTERMEDIATE: tohtmlhelper.vim
tohtmlhelper.vim:
	@echo ---- Creating $@ ...
	echo set nonumber nofoldenable > $@
	echo set fenc=utf-8 bomb >> $@
	echo TOhtml >> $@
	echo g/^<title^>/normal cc^<title^>THKMC_SAMPLE^</title^> >> $@
	echo sav! thkmc_sample_ini.html >> $@
	echo qa! >> $@
	@echo ---- END


clean:
	-$(RM) $(TARGETS)


.SUFFIXES:

.PHONY: clean
