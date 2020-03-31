BUILD_DIR=build/

SRC_NAME=statut.md

DOCX_NAME=$(BUILD_DIR)/statut.docx
DOCX_REFERENCE=reference.docx

LATEX_NAME=$(BUILD_DIR)/statut.tex
LATEX_TEMPLATE=template.tex
PDF_NAME=$(BUILD_DIR)/statut.pdf

all: docx latex pdf

docx: $(DOCX_NAME)
latex: $(LATEX_NAME)
pdf: $(PDF_NAME)

$(DOCX_NAME): $(SRC_NAME) $(DOCX_REFERENCE)
	@mkdir -p $(@D)
	awk -v sec=1 '/^§$$/ { printf("### § %d\n\n", sec); sec += 1 }; !/^§$$/ { print }' $(SRC_NAME) | pandoc -s -f markdown -t docx --reference-doc $(DOCX_REFERENCE) -o $(DOCX_NAME) -

$(LATEX_NAME): $(SRC_NAME) $(LATEX_TEMPLATE)
	@mkdir -p $(@D)
	pandoc -s $(SRC_NAME) -o $(LATEX_NAME) --template=$(LATEX_TEMPLATE) -f markdown
	sed -i "s/\`\`/,,/g" $(LATEX_NAME)

$(PDF_NAME): $(LATEX_NAME)
	pdflatex -output-directory=$(dir $(PDF_NAME)) -jobname=$(patsubst %.pdf,%,$(notdir $(PDF_NAME))) $(LATEX_NAME)

clean:
	rm -rf $(BUILD_DIR)

.PHONY: docx latex pdf all clean
