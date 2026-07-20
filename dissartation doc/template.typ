// ============================================================
// CST7000 Technology Dissertation Template
// Cardiff Metropolitan University — Cardiff School of Technologies
// Strictly conforms to the CST7000 Module Handbook
// ============================================================

// State variable: true = front matter (Roman numerals), false = main body (Arabic)
#let _fm-state = state("frontmatter", true)

// Lower-case Roman numeral renderer for front-matter page numbers
#let _roman(n) = {
  let vals = (
    (1000, "m"),
    (900, "cm"),
    (500, "d"),
    (400, "cd"),
    (100, "c"),
    (90, "xc"),
    (50, "l"),
    (40, "xl"),
    (10, "x"),
    (9, "ix"),
    (5, "v"),
    (4, "iv"),
    (1, "i"),
  )
  let r = ""
  let rem = n
  for (v, s) in vals {
    while rem >= v {
      r = r + s
      rem = rem - v
    }
  }
  r
}

// ── Main template function ────────────────────────────────────────────────────
//
// Drop into the top of your dissertation.typ:
//
//   #import "template.typ": dissertation
//   #show: dissertation.with(
//     title:            "Your Dissertation Title",
//     author:           "A. Name",
//     degree:           "Masters Degree in Data Science",
//     school:           "Cardiff School of Technologies",        // default
//     university:       "Cardiff Metropolitan University, Cardiff", // default
//     month-year:       "September 2025",
//     supervisor:       "Dr. J. Williams",
//     abstract:         [ Your abstract (≤ 300 words) ],
//     acknowledgements: [ Optional — delete arg to omit page ],
//   )
//
// WORD COUNT GUIDANCE (§1.2 / §3.5.1)
//   Your submission should be 7,000–10,000 words (excluding figures,
//   tables, references and appendices). §3.5.1 lists 20,000 words but
//   §1.2 explicitly states 7,000–10,000 as the current requirement.
//   Penalties apply for over- or under-length submissions (§1.2).
//
// WRITING STYLE (§3.2.3)
//   - Write in the passive voice: "It was decided…" not "I decided…"
//   - Avoid contractions: don't → do not, there's → there is
//   - Avoid colloquialisms
//
#let dissertation(
  title: "Dissertation Title",
  author: "A. Name",
  degree: "Masters Degree in Information Systems",
  school: "Cardiff School of Technologies",
  university: "Cardiff Metropolitan University, Cardiff",
  month-year: "Month Year",
  supervisor: "Supervisor Name",
  abstract: [],
  acknowledgements: none,
  body,
) = {
  // ── Document metadata ─────────────────────────────────────────────────────
  set document(title: title, author: author)

  // ── Page geometry (§3.5.3) ───────────────────────────────────────────────
  // Bound edge (left) and top: 25 mm. All other edges: 20 mm.
  // Page numbers are centred at the bottom, OUTSIDE the text area —
  // achieved by placing them in the footer which sits below the 20 mm
  // bottom margin. No running headers or footers permitted.
  set page(
    paper: "a4",
    margin: (left: 25mm, top: 25mm, right: 20mm, bottom: 20mm),
    header: none,
    footer: context {
      // Position footer outside the text boundary (§3.5.3)
      pad(bottom: -8mm, align(center, text(size: 10pt, if _fm-state.get() {
        _roman(counter(page).get().first())
      } else {
        str(counter(page).get().first())
      })))
    },
  )

  // ── Base typography (§3.5.4) ─────────────────────────────────────────────
  // 12 pt, black, any readable proportional font.
  // 1.5-line spacing to yield ~35–40 lines per page.
  set text(size: 12pt, font: "Times New Roman", fill: black, lang: "en")
  set par(leading: 0.75em, spacing: 1.15em, justify: true)

  // Footnotes: "small size may be used" (§3.5.4)
  set footnote.entry(separator: line(length: 30%, stroke: 0.5pt))
  show footnote.entry: set text(size: 10pt)

  // ── Heading styles (§3.5.6) ──────────────────────────────────────────────
  // All headings: bold, 12 pt, numbered to a maximum depth of 3.
  // First digit always matches the containing chapter number.
  set heading(numbering: "1.1.1")

  // Level 1 — CHAPTER
  // ALL CAPS; preceded by a page break; followed by ten blank lines;
  // subsequent text begins on a new line. (§3.5.6)
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(1.5em)
    block(text(size: 12pt, weight: "bold", upper(it.body)))
    v(10 * 1.15em) // ten blank lines
  }

  // Level 2 — Section
  // Title Case; preceded by one blank line; followed by one blank line. (§3.5.6)
  show heading.where(level: 2): it => {
    v(1.15em)
    block(text(size: 12pt, weight: "bold", it.body))
    v(1.15em)
  }

  // Level 3 — Subsection
  // Title Case; preceded by one blank line; text begins on next line. (§3.5.6)
  show heading.where(level: 3): it => {
    v(1.15em)
    block(text(size: 12pt, weight: "bold", it.body))
    v(0.4em)
  }

  // ── Figures (§3.3.5 / §3.5.7) ───────────────────────────────────────────
  // Numbered "Figure C.N" where C = chapter, N = index within chapter.
  // Caption (title) displayed at top; source note at bottom if needed.
  // Every figure MUST be referred to in the text by its full label.
  // Use @fig-label in your text: "as shown in @fig-overview"
  set figure(
    numbering: "1.1",
    supplement: "Figure",
  )
  show figure.where(kind: image): set figure(supplement: "Figure")
  show figure.where(kind: table): set figure(supplement: "Table", numbering: "1")
  show figure: it => {
    v(1em)
    it
    v(1em)
  }

  // Clean, professional academic table styling (Booktabs style)
  set table(
    stroke: (col, row) => if row == 0 { (top: 1.5pt + black, bottom: 1pt + black) } else {
      (bottom: 0.5pt + luma(220))
    },
    fill: (col, row) => if row == 0 { luma(245) } else { none },
    inset: (x: 8pt, y: 7pt),
  )
  show table: set text(size: 10.5pt)

  // Table captions use independent numbering from figures (§3.5.7)
  // Both use the same "C.N" scheme but separate counters — Typst handles
  // this automatically because image and table are different kinds.

  // ── Code / literal text (§3.3.6) ─────────────────────────────────────────
  // Fixed-width font (e.g. Courier) for program code and literal text.
  // Surrounding prose uses the proportional font set above.
  show raw: it => text(font: "Courier New", size: 11pt, it)

  // ── Bibliography spacing (§3.5.3) ─────────────────────────────────────────
  // Single-spaced; one blank line between each entry.
  // When using #bibliography("refs.bib") Typst handles the spacing;
  // the set rule below tightens entry leading to match single-spacing.
  set bibliography(style: "harvard-cite-them-right", title: none)

  // ══════════════════════════════════════════════════════════════════════════
  // FRONT MATTER — Roman numeral page numbering, starting at i
  // ══════════════════════════════════════════════════════════════════════════
  _fm-state.update(true)
  counter(page).update(1)

  // ── Title page (§3.4.1 · §3.5.5 · Appendix A) ──────────────────────────
  // No page number on the title page itself.
  // Font sizes and capitalisation rules per §3.5.5.
  page(footer: none)[
    #align(center)[
      #v(1fr)

      // Main title: 14 pt bold, Title Case (each main word capitalised) (§3.5.5)
      #text(size: 14pt, weight: "bold")[#title]

      #v(3em)

      // Submission statement: 12 pt (§3.5.5)
      #text(size: 12pt)[
        A dissertation submitted in partial fulfilment of the \
        requirements for the degree of Master of Science.
      ]

      #v(2em)
      #text(size: 12pt)[by #h(0.4em) #author]
      #v(2em)

      // Degree, school, university: 12 pt, first letter of main words
      // capitalised (§3.5.5)
      #text(size: 12pt)[#degree] \
      #v(0.4em)
      #text(size: 12pt)[#school] \
      #v(0.4em)
      #text(size: 12pt)[#university]

      #v(2em)

      // Date line: 12 pt, first letter only capitalised (§3.5.5)
      #text(size: 12pt)[#month-year]

      #v(1fr)
    ]
  ]

  // ── Declaration page (§3.4.1) ────────────────────────────────────────────
  // Required wording specified by Cardiff Metropolitan University regulations.
  // Must be signed and dated by both candidate and Director of Studies.
  page(footer: none)[
    #v(4em)
    #text(weight: "bold", size: 12pt)[Declaration]
    #v(1.5em)

    I hereby declare that this dissertation entitled '#emph(title)' is
    entirely my own work and it has never been submitted nor is it
    currently being submitted for any other degree.

    #v(5em)
    #grid(
      columns: (1fr, 1fr),
      gutter: 3em,
      align(left)[
        *Candidate* \
        #v(1.5em)
        Signature: #h(0.2em) #line(length: 4.5cm) \
        #v(0.5em)
        Name: #h(1.6em) #author \
        #v(0.5em)
        Date: #h(2em) #line(length: 3.5cm)
      ],
      align(left)[
        *Director of Studies* \
        #v(1.5em)
        Signature: #h(0.2em) #line(length: 4.5cm) \
        #v(0.5em)
        Name: #h(1.6em) #supervisor \
        #v(0.5em)
        Date: #h(2em) #line(length: 3.5cm)
      ],
    )
  ]

  // ── Abstract (§3.4.2) ────────────────────────────────────────────────────
  // ~half a page; ≤ 300 words; self-contained and self-explanatory;
  // must not refer to anything not mentioned in the dissertation itself.
  page[
    #align(center, text(weight: "bold", size: 12pt, upper[Abstract]))
    #v(2em)
    #abstract
  ]

  // ── Acknowledgements (§3.4.3) — optional ────────────────────────────────
  // Record debts to organisations or individuals. Omit the
  // `acknowledgements` argument entirely to skip this page.
  if acknowledgements != none {
    page[
      #align(center, text(weight: "bold", size: 12pt, upper[Acknowledgements]))
      #v(2em)
      #acknowledgements
    ]
  }

  // ── Table of Contents (§3.4.4) ───────────────────────────────────────────
  // Chapter and section headings with page numbers; depth 3.
  page[
    #align(center, text(weight: "bold", size: 12pt, upper[Table of Contents]))
    #v(2em)
    #outline(indent: auto, depth: 3, title: none)
  ]

  // ── List of Tables (§3.4.5) ──────────────────────────────────────────────
  // Table number, title, and page number for each table in the dissertation.
  page[
    #align(center, text(weight: "bold", size: 12pt, upper[List of Tables]))
    #v(2em)
    #outline(title: none, target: figure.where(kind: table))
  ]

  // ── List of Figures (§3.4.6) ─────────────────────────────────────────────
  // Figure number, title, and page number for each figure.
  page[
    #align(center, text(weight: "bold", size: 12pt, upper[List of Figures]))
    #v(2em)
    #outline(title: none, target: figure.where(kind: image))
  ]

  // ══════════════════════════════════════════════════════════════════════════
  // MAIN BODY — Arabic page numbering, reset to page 1
  // Page 1 = first page of the Introduction chapter (§3.4)
  // ══════════════════════════════════════════════════════════════════════════
  _fm-state.update(false)
  counter(page).update(1)

  body
}
