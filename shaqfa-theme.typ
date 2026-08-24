// ============================================================
// Shaqfa theme  —  Touying presentation theme
// ============================================================
#import "@preview/touying:0.5.5": *
// #import "@preview/touying:0.7.4": * // to support the new `hide` method for hiding content (e.g., for progressive reveal of bullet points)

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
  let tag = if s == [Appendix] {
    text(fill: shaqfa-cyan)[ [Backup]  ]
  } else { [] }
  if s == [] {
    text(white, size: 9pt, weight: "bold", [ ])
  } else if sb == [] {
    text(white, size: 9pt, weight: "bold", { tag + s })
  } else if ssb == [] {
    text(white, size: 9pt, weight: "bold", { tag + [#s  •  § #sb] })
  } else {
    text(white, size: 9pt, weight: "bold", { tag + [#s  •  § #sb  •  § #ssb] })
  }
}

// ---- Slide number: right edge of header bar (white, bold, small) ----
#let page-num(self) = context {
  let num = utils.slide-counter.get().first()
  text(white, size: 8pt, weight: "bold", str(num))
}

// ---- Progress bar rendering variants ----
#let progress-bar-line = context {
  let c = utils.slide-counter.get().first()
  let t = utils.slide-counter.final().first()
  let ratio = if t > 0 { calc.min(c / t * 100%, 100%) } else { 0% }
  block(width: ratio, height: 3pt, fill: shaqfa-red, radius: 0pt)
}

#let progress-bar-dots = context {
  let c = utils.slide-counter.get().first()
  let t = utils.slide-counter.final().first()
  if t == 0 { return none }
  block(
    width: 100%, height: 8pt,
    fill: shaqfa-black,
    inset: (left: 1.5cm, right: 0.4cm),
    align(horizon,
      range(t).map(i => {
        let n = i + 1
        let r = if n == c {
          shaqfa-red
        } else if n < c {
          gray.lighten(50%)
        } else {
          gray.lighten(30%)
        }
        box(fill: r, radius: 50%, width: 5pt, height: 5pt, inset: 0pt)
      }).join(h(2pt))
    ),
  )
}

#let progress-bar-fraction = context {
  let c = utils.slide-counter.get().first()
  let t = utils.slide-counter.final().first()
  let total = if t > 0 { str(t) } else { "?" }
  block(
    width: 100%, height: 7pt,
    fill: shaqfa-black,
    inset: (right: 0.6cm),
    align(right + horizon,
      text(white, size: 6pt, weight: "bold", [#c / #total])),
  )
}

#let progress-bar-section = context {
  let c = utils.slide-counter.get().first()
  let t = utils.slide-counter.final().first()
  if t == 0 { return none }
  let sections = state("shaqfa-pb-sec", ())
  let sec-bounds = sections.get()
  let segs = if sec-bounds == () {
    ((start: 1, end: t, fill: shaqfa-red),)
  } else {
    sec-bounds
  }
  let w = 100% / t
  block(width: 100%, height: 4pt,
    segs.map(seg => {
      let seg-w = (seg.end - seg.start + 1) * w
      box(width: seg-w, height: 4pt, fill: seg.fill)
    }).join(),
  )
}

#let render-progress-bar(style) = {
  if style == "line" { progress-bar-line }
  else if style == "dots" { progress-bar-dots }
  else if style == "fraction" { progress-bar-fraction }
  else if style == "sections" { progress-bar-section }
  else { none }
}

#let pb-ascent(style) = {
  if style == "dots" or style == "fraction" { 1.0cm }
  else if style == "sections" { 0.9cm }
  else if style == "none" { 0.7cm }
  else { 0.8cm }
}

// ---- Section-boundary tracker for progress-bar-section ----
#let pb-sec-state = state("shaqfa-pb-sec", ())
#let record-section-boundary(fill) = {
  pb-sec-state.update(prev => {
    let c = utils.slide-counter.get().first()
    if prev == () {
      ((start: 1, end: c, fill: fill),)
    } else {
      let last = prev.last()
      prev.slice(0, prev.len() - 1) + ((start: last.start, end: c, fill: fill),)
    }
  })
}

// ---- Custom slide layout with header bar + progress bar ----
#let slide(
  config: (:), repeat: auto,
  setting: body => body, composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  let pb-style = self.store.at("progress-bar", default: "line")
  let header(self) = {
    stack(
      dir: ttb,
      spacing: 0pt,
      // Dark-gray header bar — flush with page top, sharp corners
      block(
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
      ),
      render-progress-bar(pb-style),
    )
  }

  self = utils.merge-dicts(
    self,
    config-page(header: header, footer: none, fill: white, header-ascent: pb-ascent(pb-style)),
    config-common(subslide-preamble: none,
                  show-hide-set-list-marker-none: true,
                  ),
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
        show figure.caption: it => {
          set text(size: 0.85em)
          show text: set text(fill: shaqfa-red, weight: "bold")
          it
        }

        body
      },
      alert: utils.method-wrapper(text.with(weight: "bold", fill: shaqfa-red)),
    ),
    config-store(
      header: header-text,
      page-num: page-num,
      show-page-num: true,
      progress-bar: "line",
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
// #let slide-cite(..keys) = {
//   let bib = read("../references.bib")

#let slide-cite(bib-file: "../references.bib", ..keys) = {
  let bib = read(bib-file)
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

// ============================================================
// BLOCK ENVIRONMENTS  (theorem, definition, example, note, alert)
// ============================================================

/// Theorem block — violet accent, light violet fill.
#let theorem-block(body) = block(
  fill: violet-light,
  stroke: (top: 3pt + violet-dark),
  inset: (top: 0.5em, bottom: 0.5em, left: 0.8em, right: 0.8em),
  radius: 4pt,
)[
  #text(size: 0.95em, weight: "bold", fill: violet-dark)[Theorem.]
  #v(0.3em)
  #body
]

/// Definition block — green accent, light green fill.
#let definition-block(body) = block(
  fill: green-light,
  stroke: (top: 3pt + green-dark),
  inset: (top: 0.5em, bottom: 0.5em, left: 0.8em, right: 0.8em),
  radius: 4pt,
)[
  #text(size: 0.95em, weight: "bold", fill: green-dark)[Definition.]
  #v(0.3em)
  #body
]

/// Example block — green accent, light green fill.
#let example-block(body) = block(
  fill: green-light,
  stroke: (top: 3pt + green-dark),
  inset: (top: 0.5em, bottom: 0.5em, left: 0.8em, right: 0.8em),
  radius: 4pt,
)[
  #text(size: 0.95em, weight: "bold", fill: green-dark)[Example.]
  #v(0.3em)
  #body
]

/// Note block — warm pink accent, light pink fill.
#let note-block(body) = block(
  fill: grad-pink.lighten(10%),
  stroke: (top: 3pt + grad-dpink),
  inset: (top: 0.5em, bottom: 0.5em, left: 0.8em, right: 0.8em),
  radius: 4pt,
)[
  #text(size: 0.95em, weight: "bold", fill: grad-red)[Note.]
  #v(0.3em)
  #body
]

/// Alert / Warning block — red accent (uses primary).
#let alert-block(body) = block(
  fill: rgb("#FDE8E8"),
  stroke: (top: 3pt + shaqfa-red),
  inset: (top: 0.5em, bottom: 0.5em, left: 0.8em, right: 0.8em),
  radius: 4pt,
)[
  #text(size: 0.95em, weight: "bold", fill: shaqfa-red)[⚠ Warning.]
  #v(0.3em)
  #body
]

/// Compact proof block — violet accent, left border only.
#let proof-block(body) = block(
  fill: violet-light.lighten(15%),
  stroke: (left: 3pt + violet-dark),
  inset: (top: 0.4em, bottom: 0.4em, left: 0.8em, right: 0.8em),
  radius: 4pt,
)[
  #text(size: 0.95em, weight: "bold", fill: violet-dark)[Proof.]
  #v(0.2em)
  #body
  #v(0.2em)
  #align(right, text(size: 0.85em, fill: violet-dark)[∎])
]

// ============================================================
// QUOTE / CALLOUT BLOCK
// ============================================================

/// Quote block — left red bar, muted background, optional attribution.
#let quote-block(body, attribution: none) = block(
  fill: gray.lighten(65%),
  stroke: (left: 4pt + shaqfa-red),
  inset: (top: 0.7em, bottom: 0.7em, left: 1em, right: 0.8em),
  radius: (top-right: 4pt, bottom-right: 4pt),
)[
  #set text(size: 0.95em, style: "italic")
  #body
  #if attribution != none [
    #v(0.5em)
    #align(right, text(size: 0.8em, weight: "bold", fill: shaqfa-red)[— #attribution])
  ]
]

// ============================================================
// CALLOUT BOX — sidebar-style callout for column layouts
// ============================================================

/// Sidebar callout box — best used in a two-column layout.
/// Usage:
///   #slide(composer: (1fr, 25%))[= Main][ #callout-box(label: "Takeaway")[...] ]
#let callout-box(
  body,
  label: "Note",
  color: shaqfa-red,
) = block(
  fill: color.lighten(85%),
  stroke: (left: 4pt + color),
  inset: 0.7em,
  radius: 4pt,
)[
  #text(size: 0.85em, weight: "bold", fill: color)[#label]
  #v(0.3em)
  #set text(size: 0.85em)
  #body
]

// ============================================================
// CLOSING SLIDE
// ============================================================

/// Pre-styled closing / thank-you slide.
/// Usage: `#closing-slide(author, email, institute, orcid: none)`
#let closing-slide(
  author: "",
  email: "",
  institute: "",
  orcid: none,
  website: none,
) = slide[
  = Thank You

  #v(1.0cm)
  #align(center)[
    #text(size: 1.8em, weight: "bold", fill: shaqfa-red)[*Questions?*]

    #v(1.2cm)
    #set text(size: 14pt, fill: black)
    #text(weight: "bold", author)

    #v(0.4cm)
    #set text(size: 11pt)
    #email \
    #institute

    #v(0.5cm)
    #if orcid != none [
      #link("https://orcid.org/" + orcid)[
        #box(fill: rgb("#A6CE39"), radius: 50%, inset: (x: 0.35em, y: 0.1em))[
          #text(white, size: 0.75em, weight: "bold")[iD]
        ]
        \ #text(fill: rgb("#A6CE39"), size: 0.85em)[orcid.org/#orcid]
      ]
    ]
    #if website != none [
      #v(0.3cm)
      #link(website)[#text(fill: shaqfa-red, size: 0.9em)[#website]]
    ]
  ]
]

// ============================================================
// STYLED TABLE OF CONTENTS
// ============================================================

/// Styled outline with coloured square markers matching the theme.
/// Usage: `#styled-outline[#outline(indent: 3em, title: none)]`
#let styled-outline(body) = {
  show outline.entry: it => {
    [ #box(fill: shaqfa-red, radius: 2pt, width: 0.55em, height: 0.55em, inset: 0pt) \ #it ]
  }
  body
}

// ============================================================
// APPENDIX / BACKUP SLIDES
// ============================================================

/// Set the header breadcrumb for appendix slides.
/// Usage: `#appendix-heading[Extra Proofs]`
#let appendix-heading(s) = {
  sec-state.update([Appendix])
  sub-state.update(s)
  ssub-state.update([])
}

/// An appendix breaking slide — right bar in dark-gray, "Appendix" label.
#let appendix-breaking(label, body) = slide(
  config: no-header-footer + config-common(freeze-slide-counter: true)
)[
  #place(top + right, dy: 0pt, dx: 0pt,
    rect(width: 50%, height: 101%, fill: shaqfa-black))

  #align(horizon, block(width: 57%, inset: (left: 1.5cm, right: 1cm))[
    #set text(size: 0.7em, fill: shaqfa-black, weight: "bold")
    [APPENDIX]
    #v(0.3cm)
    #set text(size: 1.2em, fill: black, weight: "bold")
    #label
    #v(0.6cm)
    #body
  ])
]
