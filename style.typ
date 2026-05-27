// Sleek sans-serif base font, falling back to Arial for Windows
//#set text(font: ("Inter 18pt", "Segoe UI", "Arial"), fill: rgb("#333333"), tracking: -0.030em, spacing: 120%)
#set text(font: ("Roboto", "Segoe UI", "Arial"), fill: rgb("#333333"), tracking: -0.020em, spacing: 130%)

#set par(leading: 0.8em)

// Play on shades and sizes for the header system
// NOTE: map is based on titles hierarchy as it appears. E.g. if `#` is skipped and `##` appears first, then this becomes level 1!
#show heading: it => {
  if it.level == 1 {
    v(1.2em)
    text(size: 14pt, weight: "bold", fill: rgb("#666666"), it)
    v(0.5em)
  } else if it.level == 2 {
    v(1em)
    text(size: 12pt, weight: "bold", fill: rgb("#777777"), it)
    v(0.5em)
  } else if it.level == 3 {
    v(1em)
    text(size: 10pt, weight: "bold", fill: rgb("#888888"), it)
    v(0.5em)
  } else {
    v(0.75em)
    text(size: 10pt, weight: "bold", fill: rgb("#999999"), it)
  }
}

// Global hyperlink styling
#show link: set text(fill: rgb("#0055CC"))

// Global hyperlink styling (Color + Underline)
#show link: it => underline(text(fill: rgb("#0055CC"), it))

// Citations
#show cite: it => text(fill: rgb("#0055CC"), it)

// Custom function for the black outline box
#let researchbox(body) = block(
  width: 100%,
  stroke: 1pt + black,
  inset: 15pt,
  body
)

// Style specifically for inline single-tick code (Triggered by inline.lua)
#let InlineCode(body) = {
  // Force the color inside the box, overriding Typst's raw defaults
  show raw: set text(fill: rgb("#333333")) 
  
  box(
    fill: rgb("#f2f2f2"),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
    body
  )
}

// Function to draw the cards, changing the top border based on the theme
#let CustomCard(theme, body) = {
  let top-color = rgb("#E0E0E0")
  if theme == "anchor" { top-color = rgb("#2196F3") }
  if theme == "positive" { top-color = rgb("#4CAF50") }
  if theme == "negative" { top-color = rgb("#E63946") }
  
  block(
    fill: rgb("#FAFAFA"),
    stroke: (top: 4pt + top-color, rest: 1pt + rgb("#E0E0E0")),
    inset: 12pt,
    radius: 4pt,
    width: 100%,
    body
  )
}

// Main Quiz Card Container
#let QuizCard(body) = block(
  fill: rgb("#FCFCFC"),
  stroke: 1pt + rgb("#E0E0E0"),
  inset: 15pt,
  radius: 8pt,
  width: 100%,
)[
  // Force strict, tight spacing for everything inside this card
  #set block(spacing: 0.8em) 
  #set par(spacing: 0.8em)
  #body
]

// The little pill tags at the top
#let QuizTag(body) = {
  box(
    fill: rgb("#EEEEEE"),
    inset: (x: 8pt, y: 4pt),
    radius: 12pt,
    text(font: ("Roboto Mono", "Consolas"), size: 0.7em, fill: rgb("#555555"), body)
  )
  // Replaced "margin" with a native horizontal space
  h(4pt) 
}

// The Multiple Choice Options
#let McqOption(correct: false, body) = block(
  fill: if correct { rgb("#E8F5E9") } else { rgb("#FAFAFA") },
  stroke: if correct { 2pt + rgb("#4CAF50") } else { 1pt + rgb("#E0E0E0") },
  inset: 10pt,
  radius: 6pt,
  width: 100%,
  // Removed "below: 10pt" because our QuizCard is now managing the spacing natively!
  text(fill: if correct { rgb("#2E7D32") } else { rgb("#333333") }, body)
)

// System Prompt Container
#let PromptBox(body) = block(
  breakable: false,
  above: 2.0em,
  below: 2.0em,
  fill: rgb("#F8F9FA"), // Very light, neutral gray
  stroke: (left: 4pt + rgb("#673AB7"), rest: 1pt + rgb("#E0E0E0")), // Deep purple accent
  inset: 15pt,
  radius: (left: 2pt, right: 6pt),
  width: 100%,
)[
  #set text(size: 0.95em)
  #body
]

// Visual indent to perfectly match bullet point text
#let list-indent(body) = pad(left: 1.5em, body)

// Force all tables in the document to stay on a single page
#show figure.where(kind: table): set block(breakable: false)

// Force all naked tables to stay completely intact on a single page
#show table: it => block(breakable: false, it)

// Globally indent all unordered and numbered lists
//#set list(indent: 2em)
//#set enum(indent: 2em)

// Universal Algorithm Block (Targeted by Lua Filter)
#let algorithm-box(body) = block(
  fill: luma(245),
  stroke: 1pt + rgb(224, 224, 224),
  inset: 15pt,
  above: 1.5em,
  below: 1.5em,
  radius: 4pt,
  width: 100%,
  breakable: false,
  body
)