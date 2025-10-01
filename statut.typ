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
#set enum(numbering: "1.a)", indent: 1.5em)
#set par(justify: true, leading: 0.78em)

#show heading: it => {
  set align(center)
  if it.depth == 1 [
    #set text(size: 17pt, weight: "bold")
    #v(3.5 * 0.43056 * 12pt)
    #smallcaps[
      Rozdział #numbering("1", it.offset)\
      #it.body
    ]
  ] else if it.depth == 2 [
    #set text(size: 14pt, weight: "bold")
    #v(3.25 * 0.43056 * 12pt)
    #it.body
  ] else if it.depth == 3 [
    #set text(size: 12pt, weight: "bold")
    #v(3.25 * 0.43056 * 12pt)
    #sym.section #it.body
  ] else {
    panic("Unsupported heading")
  }
}

#[
  #set align(center)
  #set text(size: 2em)
  #v(.4em)
  Statut Stowarzyszenia Krakowski Klub Chombo
]

#let render_atoms(atoms) = {
  let render_atom(type, value) = {
    if type == "text" {
      eval(value, mode: "markup")
    } else if type == "list" {
      for item in value {
        enum.item(int(item.id), [#render_atoms(item.content)])
      }
    } else {
      panic("Unexpected atom type", type)
    }
  }

  for atom in atoms {
    for (key, value) in atom {
      render_atom(key, value)
    }
  }
}

#for chapter in yaml("statut.yaml").chapters {
  set heading(level: 1, offset: int(chapter.id))
  block(width: 100%, sticky: true, [= #chapter.title])

  for paragraph in chapter.paragraphs {
    block(width: 100%, sticky: true, [=== #paragraph.id])
    render_atoms(paragraph.content)
  }
}
