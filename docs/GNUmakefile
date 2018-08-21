# Make documentation using mingw32-make
#
# Need additional programs: pandoc, gvim


SHELL=cmd.exe

TARGETS=index.html thkmc_sample_ini.html

RM=del

all: $(TARGETS)

index.html: index.md
	pandoc -f markdown+multiline_tables+table_captions -sS --toc --toc-depth=4 --email-obfuscation=references -V lang=zh --css=style.css -o $@ $<

thkmc_sample_ini.html: ../thkmc_sample.ini | tohtmlhelper.vim
	gvim -S tohtmlhelper.vim $<

.INTERMEDIATE: tohtmlhelper.vim
tohtmlhelper.vim:
	@echo ---- Creating $@ ...
	echo set nonumber nofoldenable > $@
	echo TOhtml >> $@
	echo g/^<title^>/normal cc^<title^>THKMC_SAMPLE^</title^> >> $@
	echo sav! thkmc_sample_ini.html >> $@
	echo qa! >> $@
	@echo ---- END


clean:
	-$(RM) $(TARGETS)


.SUFFIXES:

.PHONY: clean
