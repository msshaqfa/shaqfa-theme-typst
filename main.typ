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

// ============================================================
// THEME FEATURES SHOWCASE
// ============================================================
#section-heading[Theme features]

#subsection-heading[Block environments]

#slide[
  = Theorem & Definition Blocks

  #theorem-block[
    Let $f: X -> RR$ be a continuously differentiable function on a
    compact manifold $X subset RR^d$. Then the spectral Galerkin
    approximation $f_N$ converges to $f$ in $L^2(X)$ as
    $N -> oo$.
  ]

  #v(0.5cm)

  #definition-block[
    The *morphological distance* $d_M(x, y)$ between two points
    on a parametric surface $cal(S)$ is the geodesic length of
    the shortest path constrained to lie on $cal(S)$.
  ]
]

#slide[
  = Example & Note Blocks

  #example-block[
    Consider a spherical harmonic expansion of order $N = 64$.
    The coefficient matrix $A_n^m$ has $(N+1)^2 = 4225$ entries,
    each computed via numerical quadrature on the unit sphere.
  ]

  #v(0.4cm)

  #note-block[
    In practice, the coefficient matrices are highly sparse for
    smooth surfaces. Exploiting this sparsity reduces the
    computational cost from $cal(O)(N^4)$ to $cal(O)(N^2 log N)$.
  ]
]

#slide[
  = Alert & Proof Blocks

  #alert-block[
    The convergence rate degrades sharply when the surface
    contains $C^0$ discontinuities (creases). In such regions,
    spectral methods require local refinement to maintain accuracy.
  ]

  #v(0.5cm)

  #proof-block[
    By the Riesz representation theorem, there exists a unique
    $u in H_0^1(Omega)$ satisfying the weak formulation for any
    $f in L^2(Omega)$. The Galerkin projection onto
    $V_N subset H_0^1$ inherits this well-posedness.
  ]
]

#subsection-heading[Quote & Callout]

#slide[
  = Quote Block

  The `quote-block` highlights key statements from literature or
  emphasises take-home messages:

  #v(0.6cm)

  #quote-block(attribution: "G. Strang, 1986")[
    The fundamental law of numerical analysis: the error in the
    discrete solution is bounded by the error in the best
    approximation from the discrete subspace.
  ]

  #v(0.8cm)

  #quote-block[
    *Key insight:* computation scales linearly with input size.
  ]
]

#subsection-heading[Column callout]

#slide(composer: (1fr, 28%))[
  = Column Callout

  The `callout-box` sits in a narrow sidebar alongside
  the main content. It's ideal for key takeaways,
  caveats, or references that shouldn't interrupt the
  primary flow.

  #v(0.5cm)

  This slide uses a two-column layout via the Touying
  `composer:` parameter — no extra code needed beyond
  the callout box itself.
][
  #callout-box(label: "Key Takeaway", color: shaqfa-red)[
    The spectral method converges quadratically
    for smooth surfaces.
  ]

  #v(0.6cm)

  #callout-box(label: "Caveat", color: shaqfa-cyan)[
    Convergence degrades near $C^0$ creases.
    Local refinement is required.
  ]

  #v(0.6cm)

  #callout-box(label: "Ref.", color: shaqfa-black)[
    See Shaqfa et al. (2024) for the full convergence proof.
  ]
]

#subsection-heading[Progress bar]

#slide[
  = Progress Bar Styles

  *Four built-in styles* — set globally or per-slide via
  `config-store(progress-bar: "style")`:

  #v(0.4cm)
  #table(
    columns: (auto, auto),
    inset: 6pt,
    align: (left, left),
    [*`"line"`* (default)], [Thin red bar that fills left-to-right.],
    [*`"dots"`*], [Dot indicators on a dark strip — one per slide, current slide highlighted.],
    [*`"fraction"`*], [Compact text `"5 / 20"` on a dark strip aligned right.],
    [*`"sections"`*], [Segmented bar — each section gets its own colour block.],
    [*`"none"`*], [Disables the progress indicator entirely.],
  )
]

// #slide(config: config-store(progress-bar: "dots"))[
#slide(config: config-store(progress-bar: "line"))[
  = Dots Example
  (this slide uses `progress-bar: "dots"`)

  Each dot represents one slide. The current slide is highlighted
  in red, visited slides are light gray, upcoming are dark.
]

#slide(config: config-store(progress-bar: "fraction"))[
  = Fraction Example
  (this slide uses `progress-bar: "fraction"`)

  The right side of the progress bar strip shows the current
  slide number over the total, e.g. "18 / 45".
]

#subsection-heading[Figure captions]

#slide[
  #grid(columns: (1fr, 1.2fr), rows: (auto, 1fr), gutter: 1.5em,
    grid.cell(colspan: 2)[
      = Styled Figure Captions
      #v(1.5em)
    ],
    figure(
      image("figures/basis_rendering.pdf", width: 100%),
      caption: "Oblate and prolate spheroidal harmonics basis functions.",
    ),
    [
      #v(2.5cm)
      $
        mat(x(eta, phi); y(eta, phi); z(eta, phi))
        = sum_(n=0)^(n_(max)) sum_(m = -n)^n
          A_n^m S_n^m (eta, phi).
      $

      #v(1.5em)
      Captions are automatically styled with the theme's
      primary red colour and bold weight for the figure label.
    ],
  )
  #slide-cite(<Shaqfa2024_SOH>, <Shaqfa2025_remesh>)
]

#subsection-heading[Table of contents]

#slide[
  = Styled Table of Contents

  #v(0.4cm)
  #styled-outline[
    #outline(indent: 3em, title: none)
  ]
]

// ---------- Methodology ----------
#section-heading[Methodology]

#centered-breaking("Methodology", color: shaqfa-black)

// ---- Spectral parameterization slide ----
#slide[
  #grid(columns: (1fr, 1.2fr), rows: (auto, 1fr), gutter: 1.5em,
    grid.cell(colspan: 2)[
      = Spectral parameterization
      #v(1.5em)
    ],
    figure(
      image("figures/basis_rendering.pdf", width: 100%),
      caption: "Oblate and prolate spheroidal harmonics basis functions.",
    ),
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

// ---------- Thank you ----------
#closing-slide(
  author: author,
  email: email,
  institute: address,
  orcid: "0000-0002-0136-2391",
  website: "https://github.com/Shaqfa/libharmonics",
)

// ============================================================
// APPENDIX — slides visible only on demand
// ============================================================
#show: appendix

#appendix-heading[Extra Proofs]

#appendix-breaking([Supplementary Material])[
  Deeper technical details and\ additional proofs beyond the main\ presentation.
]

#slide[
  = Proof of Spectral Convergence

  #proof-block[
    Let $u in H^s(Omega)$ for $s > d/2$. Then the spectral
    approximation $u_N$ satisfies
    $
      norm(u - u_N)_(L^2) <= C N^(-s) norm(u)_(H^s).
    $
    This follows directly from the projection error bound on
    the polynomial subspace $P_N$ and the embedding
    $H^s(Omega) subset C^0(bar(Omega))$ for $s > d/2$.
  ]
]

#slide[
  = Convergence Benchmarks

  #table(
    columns: (auto, auto, auto, auto),
    inset: 8pt,
    align: center,
    [*Order*], [*$L^2$ Error*], [*Rate*], [*Time (ms)*],
    table.hline(),
    [$N = 16$], [$1.2 times 10^(-3)$], [--], [2.4],
    [$N = 32$], [$3.1 times 10^(-4)$], [1.95], [8.7],
    [$N = 64$], [$7.8 times 10^(-5)$], [1.99], [34.1],
    [$N = 128$], [$1.9 times 10^(-5)$], [2.01], [138.5],
  )

  #v(0.5cm)
  #note-block[
    Quadratic convergence rate confirms optimality of the
    spectral Galerkin method for smooth solutions.
  ]
]

#appendix-heading[Additional Figures]

#slide[
  = Mesh Refinement Strategy

  #figure(
    image("figures/basis_rendering.pdf", width: 50%),
    caption: "Adaptive mesh refinement around high-curvature regions.",
  )

  Local refinement is triggered when the curvature exceeds
  a prescribed threshold $kappa > kappa_(max)$. The
  adaptive strategy preserves the spectral convergence rate
  even on surfaces with isolated geometric singularities.
]

#appendix-heading[References & Further Reading]

#slide[
  = Extended Bibliography

  #set text(size: 9pt)
  #bibliography("refs.bib", title: none)

  #v(0.5cm)
  Additional references of interest:
  - Boyd, J. P. (2001). *Chebyshev and Fourier Spectral Methods*.
  - Canuto, C. et al. (2006). *Spectral Methods: Fundamentals in Single Domains*.
  - Hesthaven, J. S. et al. (2007). *Nodal Discontinuous Galerkin Methods*.
]
