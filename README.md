# statute-pl
[![Build Status](https://travis-ci.com/riichi/statute-pl.svg?branch=master)](https://travis-ci.com/riichi/statute-pl)

## How to build the document locally

1. Install [poetry](https://python-poetry.org/)
2.
```shell
cd renderer
poetry install
poetry run main.py ../statut.yaml ../template.tex > out.tex
pdflatex out.tex
```