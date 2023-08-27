BUILD_DIR=./build

SRC_NAME=statut.yaml

LATEX_NAME=$(BUILD_DIR)/statut.tex
LATEX_TEMPLATE=template.tex
PDF_NAME=$(BUILD_DIR)/statut.pdf

POETRY_CMD=poetry

all: $(PDF_NAME)

$(PDF_NAME): $(LATEX_NAME)
	@mkdir -p $(@D)
	pdflatex -output-directory=$(dir $(PDF_NAME)) -jobname=$(patsubst %.pdf,%,$(notdir $(PDF_NAME))) $(LATEX_NAME)

$(LATEX_NAME): $(SRC_NAME) install_renderer_deps
	@mkdir -p $(@D)
	$(POETRY_CMD) run python3 -m render_tex $(SRC_NAME) $(LATEX_TEMPLATE) > $(LATEX_NAME)

install_renderer_deps:
	$(POETRY_CMD) install --sync

clean:
	rm -rf $(BUILD_DIR)
	$(POETRY_CMD) env remove --all

.PHONY: all clean install_renderer_deps
