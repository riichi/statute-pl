#set page(
  paper: "a4",
  margin: (x: 0.8in, y: 0.8in),
  numbering: "1",
)
#set text(
  size: 12pt,
  lang: "pl",
)
#set document(
  title: "Statut Stowarzyszenia Krakowski Klub Chombo",
  author: "Stowarzyszenie Krakowski Klub Chombo",
  date: none,
)
#set enum(numbering: "1.a)")

#show heading: it => {
  set align(center)
  if it.depth == 1 {
    smallcaps[
      #set text(size: 1.2em, weight: "bold")
      Rozdział #numbering("I", it.offset)\
      #it.body
    ]
  } else if it.depth == 2 [
    #set text(size: 0.9em, weight: "bold")
    #it.body
  ] else if it.depth == 3 [
    #set text(size: 0.8em, weight: "bold")
    #sym.section #it.body
  ] else {
    it
  }
}

#[
  #set align(center)
  #set text(size: 2em)
  Statut Stowarzyszenia Krakowski Klub Chombo
]

#v(2em)

#let render_atoms(atoms) = {
  let render_atom(type, value) = {

    if type == "text" {
      eval(value, mode: "markup")
    } else if type == "list" {
      for item in value {
        enum.item(int(item.id), [#render_atoms(item.content)])
      }
    } else {
      panic("unexpected atom type", type)
    }
  }

  for atom in atoms {
    for (key, value) in atom.pairs() {
      render_atom(key, value)
    }
  }
}

#for chapter in yaml("statut.yaml").chapters {
  set heading(level: 1, offset: int(chapter.id))
  [= #chapter.title]

  for paragraph in chapter.paragraphs {
    [=== #paragraph.id]

    render_atoms(paragraph.content)
  }
}
