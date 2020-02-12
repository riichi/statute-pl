#!/bin/bash

set -e
pandoc -s statut.md -o statut.tex --template=template.tex -f markdown
sed -i "s/\`\`/,,/g" statut.tex
pdflatex statut.tex
