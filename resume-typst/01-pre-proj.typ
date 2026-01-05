// ----------- setup -----------
#set page("us-letter", margin: 0.5in)
#set text(font: "Latin Modern Roman")
#let linkcolor = rgb("1155CC")
#show link: set text(fill: linkcolor, size: 0.95em, font: "Latin Modern Mono")
#set par(
  leading: 0.65em,
  spacing: 0.70em,
  linebreaks: "optimized",
  justify: true,
)
#let list_vspace = [
  #v(0.6em)
]

// ---------- helpers ----------
#let section(title) = [
  #heading[
    #text(weight: "semibold")[#title]
  ]
  #line(length: 100%)
]

#let oss_entry(name, url, body) = [
  #text(weight: "bold")[#name] #h(1fr)
  #link(url)[[link]]
  #body
]

#let work_entry(org, location, mode, date, role, body) = [
  #text(weight: "bold")[#org, #location] #(text(style: "italic", size: 0.85em)[(#mode)]) #h(1fr)
  #text(style: "italic")[#date] \
  #role
  #body
]

#let project_entry(name, meta, url, desc) = [
  #text(weight: "bold")[#name]#text(style: "italic", size: 0.85em)[ (#meta)] #h(1fr)
  #link(url)[[link]] \
  #desc
]

#let education_entry(title, date, institution) = [
  #text(weight: "bold")[#title] #h(1fr)
  #text(style: "italic")[#date] \
  #institution
]


// ---------- document ----------

#section("Prashant Rahul")
#table(
  columns: 2,
  stroke: 0pt,
  inset: 0.3em,
  [Home:], [#link("https://prashantrahul.com")[prashantrahul.com]],
  [Email:], [#link("mailto:prashantrahul141@protonmail.com")[prashantrahul141\@protonmail.com]],
  [Github:], [#link("https://github.com/prashantrahul141")[github.com/prashantrahul141]],
)

// --------- work ----------
#section("Work experience")
#work_entry(
  "Cypherock",
  "Gurugram",
  "Remote",
  "Aug 2024 – present",
  "Software Engineer Intern",
  [
    #list(tight: true, indent: 10pt)[
      Implemented the Canton Network within STM32 embedded firmware for the X1 crypto hardware wallet, supporting 30K+ users
    ][
      Ocassionally worked on the Electron side of things]
  ],
)

// --------- open soy contributions ----------
#section("Open source contributions")
#oss_entry(
  "The Julia Programming Language",
  "https://github.com/JuliaLang/julia/issues?q=author%3Aprashantrahul141",
  [
    #list(tight: true, indent: 10pt)[
      Improved performance in show() for UnitRange append! for AbstractVector
    ][
      Quality of life improvement when displaying empty ranges
    ]],
)

// ----------- education ---------------

#section("Education")
#education_entry(
  "Bachelor's Degree in Computer Science",
  "2027",
  "CV Raman Global University",
)
