exclude=*.ps *.lof *.lot *~ *.gls *.glsdefs  *.aux  *.nlo *.glo  \
*.blg *.log  *.out *.bak* *.bbl *.toc *.glg *.ind *.nls *.idx  *.ilg *.xdy *.nav *.snm *.vrb 
all:	
	make mess
mess:	
	pdflatex  -src -interaction=nonstopmode main.tex
	bibtex main.aux
#	makeindex main.idx
#	makeindex main.nlo -s nomencl.ist -o main.nls
#	makeglossaries main
	pdflatex   -src -interaction=nonstopmode main.tex
	make main
main:
	pdflatex  -src -interaction=nonstopmode main.tex 
		
clean:
	rm -fr **/*.lof **/*.lot **/*~ **/*.aux **/*.dvi \
	**/*.bbl **/*.blg **/*.log **/*.ps  **/*.out **/*.bak* **/*.toc **/*.nlo **/*.glo
	rm -fr $(exclude) 

cleanall:
	rm -fr **/*.lof **/*.lot **/*~ **/*.aux **/*.dvi \
	**/*.bbl **/*.blg **/*.log **/*.ps  **/*.out **/*.bak* **/*.toc **/*.nlo **/*.glo
	rm -fr $(exclude) main.pdf

update:
	make cleanall
	git add -A
	echo "comente sua atualizacao";  \
	read comment; \
	git commit -am "$$comment"
	git push -u origin master
