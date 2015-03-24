exclude=*.ps *.brf *.acr *.alg *.acn *.ist *.lof *.lot *~ *.gls *.glsdefs  *.aux  *.nlo *.glo *.bbl \
*.blg *.log  *.out *.bak* *.toc *.glg *.ind *.nls *.idx  *.ilg *.xd

define newline

endef

tempfilespath=$(PWD)/.tmp
tempfilescmd=-output-directory=$(tempfilespath)
define printtex 
\\documentclass[a4paper]{article} \\usepackage{geometry} \\usepackage{pdfpages} \\includepdfset{pages=-,nup=2x3,frame,noautoscale=false,delta=5mm 5mm,pagecommand={\\thispagestyle{plain}}} \\geometry{vscale=.75,hscale=.925} \\usepackage{parskip} \\begin{document} \\includepdf[scale=.9]{.tmp/main.pdf} \\end{document}
endef

all:
	mkdir -p $(tempfilespath)/text 
#	ntlconfigdoc.sh
	make full
final:
	mkdir -p $(tempfilespath)/text
#	ntlconfigdoc.sh final
	make full	
full:
	make clean
	mkdir -p $(tempfilespath)/text
	pdflatex $(tempfilescmd)  --jobname=main -interaction=nonstopmode "$(def)\input{main.tex}"

#	makeindex main.idx
#	makeindex main.nlo -s nomencl.ist -o main.nls

	cp text/references.bib $(tempfilespath)/text/references.bib
#	ln -sf ../din $(tempfilespath)/din

	cd $(tempfilespath);bibtex "main.aux"
	pdflatex $(tempfilescmd)  --jobname=main -interaction=nonstopmode "$(def)\input{main.tex}"
#	cd $(tempfilespath);makeglossaries main	
#	pdflatex $(tempfilescmd) -synctex=1 -interaction=nonstopmode main.tex
#	cd $(tempfilespath);makeglossaries main
	pdflatex $(tempfilescmd)  --jobname=main -synctex=1 -interaction=nonstopmode  "$(def)\input{main.tex}"

devmain:
	make def="\def\modedev{}" main
 
main:
	mkdir -p $(tempfilespath)/text
	pdflatex  $(tempfilescmd)  -synctex=1  -interaction=nonstopmode "$(def)\input{main.tex}"
 
#	rm -fr **/*.gls **/*~ **/*.aux **/*.bbl **/*.nlo **/*.glo \
**/*.blg **/*.log **/*.out **/*.bak* **/*.toc
#	rm  -fr $(exclude)

printslides:
	make def="\def\modeprint{}" full 
	pdflatex $(tempfilescmd) --jobname=printslides  -interaction=nonstopmode $(printtex)
	mv "$(tempfilespath)/printslides.pdf" "$(tempfilespath)/main.pdf"


update:	
	make clean 
	git add .
ifneq ($(strip $(c)),)	
	
	git commit -am "$(c)"
else 
	git commit -a
endif
	
	git push -u origin master
	
#	@nohup ntlbkp.sh >/dev/null 2>&1 &
	 

clean:
	rm -fr $(tempfilespath)
	rm -fr **/*.lof **/*.lot **/*~ **/*.aux **/*.dvi \
**/*.bbl **/*.blg **/*.log   **/*.out **/*.bak* **/*.toc **/*.nlo **/*.glo
	rm -fr $(exclude) main.pdf *.synctex.gz main.dvi main.xdy main.upa
