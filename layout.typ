#set par(justify: false)
#set text(size: 10pt)

// Code block overrides (Executes after Quarto injects the color theme)
#show raw: set text(font: ("Roboto Mono"), size: 8pt)
#show raw.where(block: true): set block(fill: luma(245), inset: 10pt, radius: 4pt)

// Figure spacing overrides
#show figure: set block(spacing: 3em) // Space above and below the entire figure block
#show figure.caption: set pad(top: 0.8em) // Space between the image itself and the caption text

// Math overrides
// Make inline math ($) just a tiny bit bigger to match Roboto's x-height
#show math.equation.where(block: false): set text(size: 1.05em)

// Make display block math ($$) significantly larger so it reads clearly
#show math.equation.where(block: true): set text(size: 1.2em)