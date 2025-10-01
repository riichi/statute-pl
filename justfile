# Build the PDF document
build:
    typst compile statut.typ

# Watch and auto-rebuild on changes
watch:
    typst watch statut.typ

# Remove generated PDF
clean:
    rm -f statut.pdf

# Run pre-commit checks
lint:
    pre-commit run --all-files

# Install pre-commit hooks
install-hooks:
    pre-commit install
