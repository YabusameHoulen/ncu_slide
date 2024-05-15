// This theme is based on "Clean" theme, which contains ideas from the former "bristol" theme, contributed by
// https://github.com/MarkBlyth


#import "@preview/polylux:0.3.1": *

#let ncu-footer = state("ncu-footer", [])
#let ncu-short-title = state("ncu-short-title", none)
#let ncu-color = state("ncu-color", teal)
#let ncu-logo = state("ncu-logo", none)


#let ncu-theme(
  aspect-ratio: "16-9",
  footer: [],
  short-title: none,
  logo: image("assets/南昌大学_logo.svg", height: 4cm, width: 12.5cm),
  background-logo: image("assets/南昌大学.svg", width: 11.5cm),
  color: blue,
  body,
) = {
  let background = if background-logo != none {
    place(
      top + left,
      dx: 53.2% - background-logo.at("width", default: 12cm) / 2,
      dy: 23.7%,
      background-logo,
    )
  } else { none }
  set page(
    paper: "presentation-" + aspect-ratio,
    margin: 0em,
    header: none,
    footer: none,
    background: background,
  )
  set text(size: 25pt)
  show footnote.entry: set text(size: .6em)
   
  ncu-footer.update(footer)
  ncu-color.update(color)
  ncu-short-title.update(short-title)
  ncu-logo.update(logo)
   
  body
}


#let title-slide(
  title: none,
  subtitle: none,
  authors: (),
  date: none,
  watermark: none,
  secondlogo: none,
) = {
  let content = locate(loc => {
    let color = ncu-color.at(loc)
    let logo = ncu-logo.at(loc)
    let authors = if type(authors) in ("string", "content") {
      (authors,)
    } else {
      authors
    }
     
    if watermark != none {
      set image(width: 100%)
      place(watermark)
    }
     
    v(5%)
    grid(columns: (5%, 1fr, 1fr, 5%), [], if logo != none {
      set align(bottom + left)
      set image(height: 3em)
      logo
    } else { [] }, if secondlogo != none {
      set align(bottom + right)
      set image(height: 3em)
      secondlogo
    } else { [] }, [])
     
    v(-10%)
    align(center + horizon)[
      #block(stroke: (y: 1mm + color), inset: 1em, breakable: false, [
        #text(1.3em)[*#title*] \
        #{
          if subtitle != none {
            parbreak()
            text(.9em)[#subtitle]
          }
        }
      ])
      #set text(size: .8em)
      #grid(
        columns: (1fr,) * calc.min(authors.len(), 3),
        column-gutter: 1em,
        row-gutter: 1em,
        ..authors,
      )
      #v(1em)
      #date
    ]
  })
  logic.polylux-slide(content)
}

#let slide(title: none, columns: none, gutter: none, ..bodies) = {
  set page(
    paper: "presentation-" + "16-9",
    margin: 0em,
    header: none,
    footer: none,
    background: none,
  )
  let header = align(
    top,
    locate(
      loc => {
        let color = ncu-color.at(loc)
        let logo = ncu-logo.at(loc)
        let short-title = ncu-short-title.at(loc)
         
        show: block.with(stroke: (bottom: 1mm + color), width: 100%, inset: (y: .3em))
        set text(size: .5em)
         
        grid(columns: (1fr, 1fr), if logo != none {
          set align(left)
          set image(height: 4em)
          logo
        } else { [] }, if short-title != none {
          align(horizon + right, grid(
            columns: 1,
            rows: 1em,
            gutter: .5em,
            short-title,
            utils.current-section,
          ))
        } else {
          align(horizon + right, utils.current-section)
        })
      },
    ),
  )
   
   
  let footer = locate(
    loc => {
      let color = ncu-color.at(loc)
       
      block(stroke: (top: 1mm + color), width: 100%, inset: (y: .3em), text(.5em, {
        ncu-footer.display()
        h(1fr)
        logic.logical-slide.display()
      }))
    },
  )
   
  set page(
    margin: (top: 4em, bottom: 2em, x: 1em),
    header: header,
    footer: footer,
    footer-descent: 1em,
    header-ascent: 1.5em,
  )
   
  let bodies = bodies.pos()
  let gutter = if gutter == none { 1em } else { gutter }
  let columns = if columns == none { (1fr,) * bodies.len() } else { columns }
  if columns.len() != bodies.len() {
    panic("number of columns must match number of content arguments")
  }
   
  let body = pad(x: .0em, y: .5em, grid(columns: columns, gutter: gutter, ..bodies))
   
   
  let content = {
    if title != none {
      heading(level: 2, title)
    }
    body
  }
   
  logic.polylux-slide(content)
}

#let end-slide(
  background_color:none,
  background_logo: image("assets/南昌大学.svg", width: 11.5cm),
  foreground: yellow,
  body,
) = {
  let background = if background_logo != none {
    place(
      top + left,
      dx: 80% - background_logo.at("width", default: 12cm) / 2,
      dy: 23.7%,
      background_logo,
    )
  } else { none }
  set page(
    fill: background_color,
    paper: "presentation-" + "16-9",
    margin: 2em,
    header: none,
    footer: none,
    background: background,
  )
  // set page(fill: background, margin: 2em)
  set text(fill: foreground, size: 1.5em)
  logic.polylux-slide(align(horizon, body))
}

#let new-section-slide(name) = {
  set page(margin: 2em)
  let content = locate(loc => {
    let color = ncu-color.at(loc)
    set align(center + horizon)
    show: block.with(stroke: (bottom: 1mm + color), inset: 1em)
    set text(size: 1.5em)
    strong(name)
    utils.register-section(name)
  })
  logic.polylux-slide(content)
}
