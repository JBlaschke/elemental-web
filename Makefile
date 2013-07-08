# Makefile for FEniCS documentation

# You can set these variables from the command line
SPHINXOPTS  =
SPHINXBUILD = sphinx-build
PAPER       =

# Internal variables
PAPEROPT_a4     = -D latex_paper_size=a4
PAPEROPT_letter = -D latex_paper_size=letter
ALLSPHINXOPTS   = -d build/doctrees $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) source

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo ""
	@echo "  all          to build all targets: html, doc, publish"
	@echo "  web          to build web pages"
	@echo "  import_docs  to import documentation for projects"
	@echo "  publish      to publish everything on libelemental.org"
	@echo "  clean        to clean out everything (build directory)"
	@echo "  fetch_news   to fetch the news"
	@echo ""
	@echo "In addition, the targets 'latex' and 'pdf' exist but are not used."

all:	web import_docs publish

web:
	$(SPHINXBUILD) -b html $(ALLSPHINXOPTS) build/html
	cp source/.htaccess build/html/
	chmod +x build/html/index.html
	@echo
	@echo "Build finished. HTML generated in build/html."

import_docs:
	scripts/import_docs

publish:
	scripts/publish
	@echo ""
	@echo "If you didn't run 'make fetch_news', please do so and 'make publish' again"

clean:
	-rm -rf build

fetch_news:
	cd scripts && ./fetch_news

latex:
	$(SPHINXBUILD) -b latex $(ALLSPHINXOPTS) build/latex
	@echo
	@echo "Build finished. LaTeX generated in build/latex."

pdf:
	make -C build/latex all-pdf
