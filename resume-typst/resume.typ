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
  #v(0.5em)
]

// determines whether this pdf is for printing or not.
// need this to conditionally render some stuff (mostly just links)
// set by the build_resume.py script
#let for_printing = sys.inputs.for_printing == "true"

// ---------- helpers ----------
#let section(title) = [
  #v(0.5em)
  #text(
    size: 1.25em,
    weight: "semibold",
  )[#title]
  #v(-0.1em)
  #line(length: 100%)
  #v(-0.1em)
]


#let oss_entry(name, url, body) = [
  #text(weight: "bold")[#name] #h(1fr)
  #if for_printing [
    \
  ] else [
    #link(url)[[link]] \
  ]
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
  #if for_printing [
    \
  ] else [
    #link(url)[[link]] \
  ]
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
  "Aug 2025 – Jan 2026",
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
  "RTEMS - RTOS for Multiprocessor Systems",
  "https://gitlab.rtems.org/rtems",
  [
    #list(tight: true, indent: 10pt)[
      Enabled IMFS testing on BSPs with tight memory constraints, like the sparc/erc32 bsp
    ][
      Rewrote binary file to C source utility in python
    ]],
)

#list_vspace

#oss_entry(
  "The Julia Programming Language",
  "https://github.com/JuliaLang/julia",
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
#section("Projects")
#project_entry("evelin", "compiler, qbe, rust", "https://github.com/prashantrahul141/evelin", "Evelin is a general purpose, statically typed, compiled language using the QBE backend with C FFI support.")
#list_vspace

#project_entry("zspie", "c, compiler, interpreter", "https://github.com/prashantrahul141/zspie", "Zspie is a fast, easy, dynamic programming language, implemented in C with a virtual machine and opcode based execution.")
#list_vspace

#project_entry("cipi8", "chip8, chip8-emulator, cpp", "https://github.com/prashantrahul141/cipi8", "C++ Chip-8 emulator with opcode, graphics, input, and timer support.")
#list_vspace

#project_entry("splax", "interpreter, lexer, parser", "https://github.com/prashantrahul141/splax", "A memory-safe, easy, dynamic programming language in Rust with a tree-walk interpreter executing directly on the AST.")
#list_vspace

#project_entry("dotfiles", "dotfiles, nix, nixos-configuration", "https://github.com/prashantrahul141/dotfiles", "Nix configuration using flakes and home manager for all my machines.")
#section("Skills")
#text(weight: "bold")[Programming languages:]
#list(
  tight: true,
  indent: 10pt,
  [
    *Proficient:* Rust, C/C++, Python, Typescript
  ],
  [
    *Experienced:* Julia, Go, LLVM IR, QBE IR, C\#
  ],
)
#list_vspace
#text(weight: "bold")[Technologies & Tools:]
#list(
  tight: true,
  indent: 10pt,
  [
    GNU/Linux, Nix/NixOS, Git, CMake, Make, Meson, Vi/Vim/Neovim, POSIX Shells, NodeJS, SolidJS
  ],
)
