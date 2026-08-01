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

/// Config that disables header + footer and clears all margins (for cover / breaking slides).
#let no-header-footer = config-page(
  header: none, footer: none,
  margin: (top: 0cm, bottom: 0cm, left: 0cm, right: 0cm),
)

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
    if supervisor != none [
      \ #text(size: 0.85em, supervisor)
    ]
  })
  // Institute on cyan bar
  #place(top + left, dy: 57mm, dx: 1.2cm,
    text(white, size: 1em, institute))
]
