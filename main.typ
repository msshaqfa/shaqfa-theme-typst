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

  #place(top + right, dy: 5mm, dx: -5mm,
    image("figures/logos/LEM3_Logo.png", height: 3.5cm))
  
  #place(bottom + right, dy: 0mm, dx: 0mm,
    image("figures/logos/MS_cover_logo.pdf", height: 7.5cm))

  // ---- Title block ----
  #place(top + left, dy: 60mm, dx: 25mm, block(width: 24cm)[
    #set text(size: 24pt)
    #text(weight: "bold")[
      #text(fill: shaqfa-red, font: ("Courier New"))[libharmonics]
      : A #text(font: ("Courier New"))[C++] Library for Morphological Analysis and Spectral Galerkin Methods]

    #v(1.0cm)
    #set text(size: 14pt)
    #text(fill: black, weight: "bold")[#author 
      #link("https://orcid.org/0000-0002-0136-2391")[
        #box(fill: rgb("#A6CE39"), radius: 50%, inset: (x: 0.35em, y: 0.1em))[
          #text(white, size: 0.65em, weight: "bold")[iD]
        ]
      ]
    ]

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

// ---------- Introduction ----------
#section-heading[Introduction]

#centered-breaking("Introduction")[
  A modern C++ library for morphological analysis\ and spectral Galerkin methods on parametric\ surfaces.
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

#centered-breaking("Methodology", color: shaqfa-black)

// ---- Spectral parameterization slide ----
#slide[
  #grid(columns: (1fr, 1.2fr), rows: (auto, 1fr), gutter: 1.5em,
    // Title spans both columns
    grid.cell(colspan: 2)[
      = Spectral parameterization
      #v(1.5em)
    ],

    // Left: figure
    figure(
      image("figures/basis_rendering.pdf", width: 100%),
      caption: "Oblate and prolate spheroidal harmonics basis functions.",
    ),

    // Right: equation + description
    [
      #v(2.5cm)
      $
        mat(x(eta, phi); y(eta, phi); z(eta, phi))
        = sum_(n=0)^(n_(max)) sum_(m = -n)^n
          A_n^m S_n^m (eta, phi).
      $

      #v(1.5em)
      This spectral expansion maps the surface
      coordinates $(x, y, z)$ onto a basis of
      spherical harmonics $S_n^m$, weighted
      by coefficients $A_n^m$.
    ],
  )
  #slide-cite(<Shaqfa2024_SOH>, <Shaqfa2025_remesh>)
]

// ---- Overlay animations demo ----
#slide[
  = Step-by-step Reveal

  + First point is always visible
  #pause
  + Second point appears on click
  #pause
  + Third point appears on next click

  #v(0.5cm)
  #uncover("3-")[
    *Note:* This conclusion only appears with the third point.
  ]

  #v(1.5cm)
  #align(left, block(width: 40%, fill: gray.lighten(55%), inset: 0.8em, radius: 4pt)[
    #set text(size: 8pt, font: ("DejaVu Sans Mono", "Courier New"))
    #show raw: set text(size: 8pt)
    ````typ
    + First point is always visible
    #pause
    + Second point appears on click
    #pause
    + Third point appears on next click

    #uncover("3-")[
      *Note:* appears with third point
    ]
    ````
  ])
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

#centered-breaking("Results", color: shaqfa-cyan)

#slide[
  = Discussion

  - *+25 %* accuracy improvement
  - *3×* faster than prior art
  - Robust across varied conditions
]

// ---------- Conclusion ----------
#section-heading[Conclusion]

#centered-breaking("Conclusion", color: shaqfa-red)
#centered-breaking("Conclusion", color: shaqfa-black)

#slide[
  = Conclusion
  This work presents a comprehensive framework combining
  theoretical rigour with practical efficiency.

  Future work will explore extensions to higher-dimensional
  problems and real-time applications.
]

// ---------- References ----------
#slide[
  = References

  // Auto-cite all bib entries (hidden, white on white)
  #set text(size: 1pt, fill: white)
  #{
    let bib = read("refs.bib")
    let keys = bib.matches(regex("@\\w+\\{([^,]+),"))
    keys.map(m => cite(label(m.captures.at(0)))).join()
  }

  #set text(size: 9pt, fill: black)
  #bibliography("refs.bib", title: none)
]

#slide[
  = Thank You

  #v(1.5cm)
  #align(center)[
    #text(size: 1.5em, weight: "bold")[*Questions?*]

    #v(1cm)
    #text(fill: black)[#author]
    #link("https://orcid.org/0000-0002-0136-2391")[
      #box(fill: rgb("#A6CE39"), radius: 50%, inset: (x: 0.35em, y: 0.1em))[
        #text(white, size: 0.8em, weight: "bold")[iD]
      ]
      \ #text(fill: rgb("#A6CE39"), size: 0.9em)[orcid.org/0000-0002-0136-2391]
    ]\
    #v(0.3cm)
    #text(fill: black)[#address]\
    #text(fill: black)[#email]
  ]
]


// ---------- TOC ----------
#section-heading[Outline]

#slide[
  = Table of Contents

  #v(0.5cm)
  #outline(indent: 3em, title: none)
]

// #slide[
#outline(
  title: [List of Figures],
  target: figure.where(kind: image),
)
// ]

