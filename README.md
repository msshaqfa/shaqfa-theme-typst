# shaqfa-theme-typst

A [Touying](https://github.com/touying-typ/touying) presentation theme for Typst, faithfully ported from an EPFL-style LaTeX Beamer class.

## Features

- **Dark header bar** — flush with the page top, with bold white breadcrumb (`Section • § Subsection`)
- **Sharp rectangular design** — no rounded corners on the header, clean academic look
- **16:9** aspect ratio, matching the original Beamer layout
- **Custom cover slide** — support for logos, title, authors, and event info
- **Column layout** — built-in Touying `composer` for `1fr` / `2fr` splits
- **Configurable** — suppress slide numbers, toggle header elements per slide

## Quick Start

```typst
#import "@preview/touying:0.5.3": *
#import "shaqfa-theme.typ": *

#show: shaqfa-theme

// -----------------------------------
#section-heading[Introduction]

#slide[
  = Welcome

  Your content here.
]

#subsection-heading[Motivation]

#slide[
  = Why This Matters

  #lorem(30)
]
```

## Slide types

```typst
// Regular slide
#slide[
  = Slide Title
  Content...
]

// Cover slide (no header, no page number)
#slide(config: no-header-footer +
  config-common(freeze-slide-counter: true) +
  config-store(show-page-num: false))[
  ...
]

// Two-column slide
#slide(composer: (1fr, 1fr))[
  = Left Column
  ...
][
  = Right Column
  ...
]
```

## Helpers

| Function              | Description                                      |
|-----------------------|--------------------------------------------------|
| `section-heading(s)`  | Set the section breadcrumb in the header bar     |
| `subsection-heading(s)`| Set the subsection breadcrumb                    |
| `cover-slide(...)`    | Built-in cover with three coloured bars          |
| `no-header-footer`    | Config to suppress header/footer on a slide      |

## Colors

| Variable         | Hex       | Beamer name            |
|-----------------|-----------|------------------------|
| `shaqfa-red`    | `#A32034` | `beamerbackgroundred`  |
| `shaqfa-black`  | `#433C3A` | `beamerbackgroundblack`|
| `shaqfa-cyan`   | `#00AFA1` | `beamerbackgroundcyan` |
| `grad-pink`     | `#F8A399` | `beamerfooter1`        |
| `grad-dpink`    | `#F57566` | `beamerfooter2`        |
| `grad-red`      | `#ED3019` | `beamerfooter3`        |

## License

MIT
