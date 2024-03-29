from __future__ import annotations

import sys
from pathlib import Path
from typing import Iterable

from pydantic import BaseModel
from yaml import CLoader, load


class Text(BaseModel):
    text: str


class ListElement(BaseModel):
    id: str
    content: list[ContentAtom]


class List(BaseModel):
    list: list[ListElement]


class Paragraph(BaseModel):
    id: str
    content: list[ContentAtom]


ContentAtom = List | Text

ListElement.model_rebuild()
Paragraph.model_rebuild()


class Chapter(BaseModel):
    id: str
    title: str
    paragraphs: list[Paragraph]


class Statute(BaseModel):
    chapters: list[Chapter]


def read_statute(filename: str) -> Statute:
    with open(filename) as input_file:
        data = load(input_file, Loader=CLoader)
    return Statute.model_validate(data)


def render_atom(atom: ContentAtom) -> Iterable[str]:
    if isinstance(atom, Text):
        yield atom.text
        return
    yield "\\begin{enumerate}"
    for item in atom.list:
        yield f"\\item[{item.id})]"
        for atom in item.content:
            yield from render_atom(atom)
    yield "\\end{enumerate}"


def render_paragraph(paragraph: Paragraph) -> Iterable[str]:
    yield from [
        "",
        f"\\renewcommand\\thesubsubsection{{\\S~{paragraph.id}}}",
        f"\\subsubsection{{\\texorpdfstring{{}}{{§{paragraph.id}}}}}",
        "",
    ]
    for atom in paragraph.content:
        yield from render_atom(atom)


def render_chapter(chapter: Chapter) -> Iterable[str]:
    yield from [
        "",
        f"\\renewcommand\\thesection{{{chapter.id}}}",
        f"\\section{{{chapter.title}}}",
        "",
    ]
    for paragraph in chapter.paragraphs:
        yield from render_paragraph(paragraph)


def render(statute: Statute) -> str:
    lines = []
    for chapter in statute.chapters:
        lines.extend(render_chapter(chapter))
    return "\n".join(lines)


def main() -> None:
    statute = read_statute(sys.argv[1])
    rendered_statute = render(statute)
    template = Path(sys.argv[2]).read_text()
    print(template.replace("$body$", rendered_statute))


if __name__ == "__main__":
    main()
