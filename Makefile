# Please make sure that you have installed mactex via `brew install` as well
install:
	mkdir -p ~/Library/texmf/tex/latex
	cp ./latex/twentysecondcv.cls ~/Library/texmf/tex/latex/twentysecondcv.cls
resume: 
	R -e "rmarkdown::render('Resume.Rmd')"

