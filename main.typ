// ============================================================
// Dummy presentation using the shaqfa theme
// ============================================================
#import "shaqfa-theme.typ": *

#show: shaqfa-theme

#let title = "libharmonics: A C++ Library for Morphological Analysis and Spectral Galerkin Methods"
#let author = "Mahmoud Shaqfa"
#let address = "Department of Mathematics (D-MATH), Seminar for Applied Mathematics (SAM), ETH Zürich"
#let email = "mahmoud.shaqfa@math.ethz.ch"

// ---------- cover ----------
#slide(config: no-header-footer +
    config-common(freeze-slide-counter: true) +
    config-store(show-page-num: false))[
  // ---- CNRS logo (top-left) ----
  #place(top + left, dy: 5mm, dx: 5mm,
    image("figures/logos/cnrs_logo.svg", height: 3.5cm))
  
  #place(bottom + right, dy: 0mm, dx: 0mm,
    image("figures/logos/MS_cover_logo.pdf", height: 7.5cm))

  // ---- Title block ----
  #place(top + left, dy: 48mm, dx: 25mm, block(width: 24cm)[
    #set text(size: 24pt)
    #text(weight: "bold")[
      #text(fill: shaqfa-red, font: ("DejaVu Sans Mono", "Courier New"))[libharmonics]
      : A #text(font: ("DejaVu Sans Mono", "Courier New"))[C++] Library for Morphological Analysis and Spectral Galerkin Methods]

    #v(1.0cm)
    #set text(size: 14pt)
    #text(fill: black, weight: "bold")[#author]

    #v(0.25cm)
    #set text(size: 12pt)
    Department of Mathematics (D-MATH)\
    Seminar for Applied Mathematics (SAM)\
    ETH Zürich
  ])

  // ---- Event info (center-bottom) ----
  #place(center + bottom, dy: -12mm)[
    #set align(center)
    #set text(size: 12pt)
    Swiss Numerics Day 2026 -- Scientific Computing \
    Apr 10, 2026 (Zürich)
  ]
]

// ---------- TOC ----------
#section-heading[Outline]

#slide[
  = Table of Contents

  #v(0.5cm)
  #outline(indent: 3em, title: none)
]

// ---------- Introduction ----------
#section-heading[Introduction]

#slide[
  = Introduction

  Welcome to this presentation built with the *shaqfa* theme
  for Typst.

  - Clean academic look with a dark header bar
  - 16:9 aspect ratio
  - Gradient footer in EPFL red tones
  - Square bullet points
]

#subsection-heading[Motivation]

#slide[
  = Motivation

  This theme faithfully reproduces the visual identity of the
  original EPFL LaTeX Beamer class. All colours, spacing, and
  layout elements are matched.

  #lorem(25)
]

#slide[
  = Why Typst?

  Typst offers a modern alternative to LaTeX for academic
  slides and documents:

  + Fast compilation
  + Clean, readable markup
  + Native Unicode support
  + No dependency headaches
]

// ---------- Methodology ----------
#section-heading[Methodology]

#slide[
  = Methodology

  Three main pillars:
]

// ---- Columns demo ----
#slide(composer: (1fr, 1fr))[
  = Theory

  Rigorous mathematical framework built on established results.

  #lorem(18)
][
  = Computation

  Efficient numerical methods that scale linearly with input size.

  #lorem(18)
]

#slide[
  = Pillar One: Theoretical Framework

  The theoretical framework extends established results
  to handle domain-specific complexities.

  #lorem(18)
]

#slide[
  = Pillar Two: Computational Methods

  #lorem(25)

  #align(center)[
    *Key insight:* computation scales linearly with input size.
  ]
]

// ---------- Results ----------
#section-heading[Results]

#slide[
  = Results

  Our method achieves state-of-the-art performance across
  all standard benchmarks.

  #lorem(20)
]

#slide[
  = Discussion

  - *+25 %* accuracy improvement
  - *3×* faster than prior art
  - Robust across varied conditions
]

// ---------- Conclusion ----------
#section-heading[Conclusion]

#slide[
  = Conclusion

  This work presents a comprehensive framework combining
  theoretical rigour with practical efficiency.

  Future work will explore extensions to higher-dimensional
  problems and real-time applications.
]

#slide[
  = Thank You

  #v(1.5cm)
  #align(center)[
    #text(size: 1.5em, weight: "bold")[*Questions?*]

    #v(1cm)
    #text(fill: black)[#author]\
    #text(fill: black)[#address]\
    #text(fill: black)[#email]
  ]
]
