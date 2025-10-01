# statute-pl
[![Build Status](https://github.com/riichi/statute-pl/workflows/Build%20PDF/badge.svg)](https://github.com/riichi/statute-pl/actions/workflows/build.yml)

## How to build the document locally

1. Install [typst](https://typst.app/),
2. Run `typst compile statut.typ` – the output file will be named `statut.pdf`.

Typical tasks are also available as [just](https://just.systems/) recipes:
- `just build` – compile the document
- `just watch` – watch and auto-rebuild on changes
- `just clean` – remove generated PDF
- `just lint` – run `pre-commit` checks
- `just install-hooks` – install `pre-commit` hooks

## Publishing a release

Push a tag to the main branch.
