
### DEFINE FILE NAMES ###
# set latexfile to the name of the main file without the .tex
latexfile = report

# optionaly define bibfile
# bibfile = bibliography

### DEFINE CONVERTERS ###
# define the latex to pdf converter
TEX = pdflatex

# define the bibtex compiler
BIB = bibtex


##############################################################
####################### DO NOT CHANGE ########################
##############################################################


# check if bibfile is defined, else use latex file
ifndef bibfile
	bibfile = $(latexfile)
endif
	

# create pdf and remove temp files
all: remove pdf clean

# create the pdf
pdf : $(latexfile).pdf

# remove the temporary files
clean: 
	rm -f *.log 
	rm -f *.aux
	rm -f *.toc
	rm -f *.bbl
	rm -f *.blg

# remove the generated pdf file
remove:
	rm -f $(latexfile).pdf

# run latex to pdf converter
ifeq ($(wildcard $(bibtex).bib),)

$(latexfile).pdf : $(latexfile).tex
	while ($(TEX) $(latexfile).tex ; \
	grep -q "Rerun to get cross" $(latexfile).log ) do true ; \
	done
	$(TEX) $(latexfile).tex
		
else		

$(latexfile).pdf : $(latexfile).tex $(latexfile).bbl
	while ($(TEX) $(latexfile).tex ; \
	grep -q "Rerun to get cross" $(latexfile).log ) do true ; \
	done
	$(TEX) $(latexfile).tex

endif 

# generate bbl
$(latexfile).bbl : $(latexfile).aux $(latexfile).bib
	$(BIB) $(latexfile)

# genette aux
$(latexfile).aux : $(latexfile).tex
	$(TEX) $(latexfile).tex



PHONY: pdf clean remove all
