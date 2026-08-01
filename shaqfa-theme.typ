// ============================================================
// Shaqfa theme  —  Touying presentation theme
// ============================================================
#import "@preview/touying:0.5.3": *

// ---- Color Palette (exact RGB values from Beamer) ----
#let shaqfa-red    = rgb("#A32034")   // beamerbackgroundred
#let shaqfa-black  = rgb("#433C3A")   // beamerbackgroundblack
#let shaqfa-cyan   = rgb("#00AFA1")   // beamerbackgroundcyan
#let grad-pink     = rgb("#F8A399")   // beamerfooter1
#let grad-dpink    = rgb("#F57566")   // beamerfooter2
#let grad-red      = rgb("#ED3019")   // beamerfooter3
#let green-dark    = rgb("#007378")   // green1
#let green-light   = rgb("#BAE1D1")   // green2
#let violet-dark   = rgb("#961463")   // violet1
#let violet-light  = rgb("#D9C7D9")   // violet2

// ---- Section tracking (for header breadcrumb) ----
#let sec-state  = state("shaqfa-sec",  [])
#let sub-state  = state("shaqfa-sub",  [])
#let ssub-state = state("shaqfa-ssub", [])

// ---- Header: white bold breadcrumb on dark-gray bar ----
#let header-text(self) = context {
  let s   = sec-state.get()
  let sb  = sub-state.get()
  let ssb = ssub-state.get()
  if s == [] {
    text(white, size: 9pt, weight: "bold", [ ])
  } else if sb == [] {
    text(white, size: 9pt, weight: "bold", s)
  } else if ssb == [] {
    text(white, size: 9pt, weight: "bold", [#s  •  § #sb])
  } else {
    text(white, size: 9pt, weight: "bold", [#s  •  § #sb  •  § #ssb])
  }
}

// ---- Slide number: right edge of header bar (white, bold, small) ----
#let page-num(self) = context {
  let num = utils.slide-counter.get().first()
  text(white, size: 8pt, weight: "bold", str(num))
}

// ---- Custom slide layout with header bar only ----
#let slide(
  config: (:), repeat: auto,
  setting: body => body, composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  // Dark-gray header bar — flush with page top, sharp corners
  let header(self) = block(
    width: 100%, height: 0.7cm,
    fill: shaqfa-black,
    radius: 0pt,
    inset: (left: 1.5cm, right: 0.4cm),
    align(horizon, block(width: 100%, {
      utils.call-or-display(self, self.store.at("header"))
      if self.store.at("show-page-num", default: true) {
        place(right + horizon,
          utils.call-or-display(self, self.store.at("page-num")))
      }
    })),
  )

  self = utils.merge-dicts(
    self,
    config-page(header: header, footer: none, fill: white, header-ascent: 0.7cm),
    config-common(subslide-preamble: none),
  )

  touying-slide(
    self: self, config: config,
    repeat: repeat,
    setting: setting,
    composer: composer,
    ..bodies,
  )
})

// ============================================================
// THEME SETUP  (drop-in replacement for simple-theme, etc.)
// ============================================================
#let shaqfa-theme(..args, body) = {
  show: touying-slides.with(
    config-page(
      paper: "presentation-16-9",
      margin: (left: 1.5cm, right: 1.1cm, top: 1.4cm, bottom: 0.6cm),
      fill: white,
    ),
    config-common(
      slide-fn: slide,
      subslide-preamble: none,
      slide-level: 3,
      auto-offset-for-heading: false,
    ),
    config-colors(
      primary: shaqfa-red,
      neutral-darkest: black,
      neutral-lightest: white,
    ),
    config-methods(
      init: (self: none, body) => {
        set text(size: 14pt, font: ("DejaVu Sans", "Arial"), fill: black)
        set list(marker: [▪])
        set heading(numbering: none)

        // Frame title: bold, black, large
      show heading.where(level: 1): it => {
        set text(size: 1.4em, weight: "bold", fill: black)
        block(above: 1.0cm, below: 1.0cm, it)
      }
        show heading.where(level: 2): it => {
          set text(size: 1.1em, weight: "bold", fill: black)
          block(below: 0.15cm, it)
        }

        show strong: set text(weight: "bold", fill: shaqfa-red)
        show block: set block(radius: 4pt)
        show footnote.entry: set text(size: .6em)

        body
      },
      alert: utils.method-wrapper(text.with(weight: "bold", fill: shaqfa-red)),
    ),
    config-store(
      header: header-text,
      page-num: page-num,
      show-page-num: true,
    ),
    ..args,
  )
  body
}

// ============================================================
// HELPERS
// ============================================================

/// Update section and reset subsections (call before slide groups).
#let section-heading(s) = {
  sec-state.update(s)
  sub-state.update([])
  ssub-state.update([])
}

/// Update subsection and reset subsubsections.
#let subsection-heading(s) = {
  sub-state.update(s)
  ssub-state.update([])
}

/// Update subsection and reset subsubsections.
#let subsection-heading(s) = {
  sub-state.update(s)
  ssub-state.update([])
}

/// Bottom-of-slide reference helper — auto-extracts from refs.bib.
/// Usage: `#slide-cite(<Shaqfa2024_SOH>)` or `#slide-cite(<A>, <B>)`
#let slide-cite(..keys) = {
  let bib = read("refs.bib")

  let format-entry(key) = {
    let k = str(key)
    let pos = bib.position(k + ",")
    if pos == none {
      return [??#k]
    }
    let block = bib.slice(pos + k.len())

    let get-field(field) = {
      let m = block.match(regex(field + "\\s*=\\s*\\{([^}]+)\\}"))
      if m != none {
        m.captures.at(0).trim(regex("\\s+"), at: start).trim(regex("\\s+"), at: end)
      }
    }

    let a = get-field("author")
    let t = get-field("title")
    let y = get-field("year")

    if a == none { a = k }
    if t == none { t = k }
    if y == none { y = "" }

    let dot = if a.ends-with(".") { "" } else { "." }

    [#a#dot (#y), *"#t"*.]
  }

  place(
    bottom + left,
    dy: 0.0cm, dx: -0.5cm,
    [
      #set text(size: 8.5pt, weight: "bold", fill: black)
      #keys.pos().map(format-entry).join([\ ])
    ],
  )
}

/// Config that disables header + footer and clears all margins (for cover / breaking slides).
#let no-header-footer = config-page(
  header: none, footer: none,
  margin: (top: 0cm, bottom: 0cm, left: 0cm, right: 0cm),
)

/// Dark cover frame — three staggered horizontal bars (EPFL style).
#let dark-cover(
  title: none, author: none,
  supervisor: none, institute: none,
) = slide(config: no-header-footer +
    config-common(freeze-slide-counter: true) +
    config-store(show-page-num: false))[
  // Red bar — right half, top
  #place(top + left, dy: 18mm, dx: 85mm,
    rect(width: 90mm, height: 20mm, fill: shaqfa-red))
  // Dark-gray bar — center-left, middle
  #place(top + left, dy: 38mm, dx: 60mm,
    rect(width: 50mm, height: 20mm, fill: shaqfa-black))
  // Cyan bar — full left, bottom
  #place(top + left, dy: 58mm, dx: 15mm,
    rect(width: 70mm, height: 20mm, fill: shaqfa-cyan))

  // Title on red bar (centered)
  #place(top + left, dy: 19mm, dx: 89mm,
    block(width: 82mm, align(center,
      text(white, size: 1.8em, weight: "bold", title))))
  // Author & supervisor on black bar (centered)
  #place(top + left, dy: 39mm, dx: 62.6mm,
    block(width: 46mm, align(center, {
      set text(white)
      if author != none [
        #text(size: 1em, weight: "bold", author)\
      ]
      if supervisor != none [
        #text(size: 0.85em, supervisor)
      ]
    })))
  // Institute on cyan bar (centered)
  #place(top + left, dy: 59mm, dx: 15mm,
    block(width: 70mm, align(center,
      text(white, size: 1em, institute))))
]

/// Cover frame — three horizontal coloured bars.
#let cover-slide(
  title: none, author: none,
  supervisor: none, institute: none,
) = slide(config: no-header-footer +
    config-common(freeze-slide-counter: true))[
  // Red bar
  #place(top + left, dy: 18mm, dx: 0pt,
    rect(width: 55%, height: 20mm, fill: shaqfa-red))
  // Dark-gray bar
  #place(top + left, dy: 38mm, dx: 0pt,
    rect(width: 38%, height: 18mm, fill: shaqfa-black))
  // Cyan bar
  #place(top + left, dy: 56mm, dx: 0pt,
    rect(width: 100%, height: 18mm, fill: shaqfa-cyan))

  // Title on red bar
  #place(top + left, dy: 18.5mm, dx: 1.2cm,
    text(white, size: 1.8em, weight: "bold", title))
  // Author on dark-gray bar
  #place(top + left, dy: 39mm, dx: 1.2cm, {
    set text(white)
    if author != none {
      text(size: 1em, weight: "bold", author)
    }
  })
  // Institute on cyan bar
  #place(top + left, dy: 57mm, dx: 1.2cm,
    text(white, size: 1em, institute))
]

/// Breaking slide — colored right-side bar (section divider).
/// Usage: `#breaking-slide[= Section Title]` or `#breaking-slide(color: shaqfa-black)[...]`
#let breaking-slide(body, color: shaqfa-red) = slide(
  config: no-header-footer + config-common(freeze-slide-counter: true)
)[
  // White side (left ~57%)
  // Colored bar on right ~43%
  #place(top + right, dy: 0pt, dx: 0pt,
    rect(width: 43%, height: 90mm, fill: color))

  // Content on the left ~57%
  #align(horizon, block(width: 57%, inset: (left: 1.5cm, right: 1cm))[
    #body
  ])
]

/// Centered breaking slide — splits the word at midpoint, black | white.
/// Optional body content goes below the split word.
#let centered-breaking(text-str, color: shaqfa-red, ..body) = slide(
  config: no-header-footer + config-common(freeze-slide-counter: true)
)[
  // Colored bar on right half
  #place(top + right, dy: 0pt, dx: 0pt,
    rect(width: 50%, height: 101%, fill: color))

  // Split word
  #{
    let mid = calc.floor(text-str.len() / 2)
    let left-half  = text-str.slice(0, mid)
    let right-half = text-str.slice(mid)
    [
      // Split word — vertically centered, a bit higher
      #v(2.5cm)
      #grid(columns: (50%, 50%), rows: auto, gutter: 0pt,
        align(right, text(black, size: 2em, weight: "bold")[#left-half]),
        align(left,  text(white, size: 2em, weight: "bold")[#right-half]),
      )
      #if body.pos().len() > 0 [
        #v(1cm)
        #pad(left: 1.5cm)[
          #set align(left)
          #set text(size: 14pt, weight: "regular")
          #body.pos().join()
        ]
      ]
    ]
  }
]
