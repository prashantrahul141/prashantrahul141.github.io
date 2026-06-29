// ----------- setup -----------
#set page("us-letter", margin: (
  x: 0.6in,
  y: 0.6in,
))
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
  #v(0.4em)
]

// determines whether this pdf is for printing or not.
// need this to conditionally render some stuff (mostly just links)
// set by the build_resume.py script
#let for_printing = sys.inputs.for_printing == "true"

// ---------- helpers ----------
#let section(title) = [
  #v(0.4em)
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
  #text(weight: "bold")[
    #org,
    #location
  ]
  #(text(style: "italic", size: 0.85em)[(#mode)])
  #h(1fr)
  #text(style: "italic")[#date] \
  #role
  #body
]


#let project_entry(name, meta, url, desc) = [
  #text(weight: "bold")[#name]#text(style: "italic", size: 0.85em)[ (#meta)]
  #h(1fr)
  #if for_printing [
    \
  ] else [
    #link(url)[[link]] \
  ]
  #desc
]

#let education_entry(title, date, institution) = [
  #text(weight: "bold")[#title]
  #h(1fr)
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
      Implemented the Canton Network within STM32 embedded firmware for the X1 crypto hardware wallet, including writing real time encoders and decoders, hashing and signing Canton transactions.
    ][
      Contributed to the Electron frontend application, developing features using Typescript.]
  ],
)

// --------- open soy contributions ----------
#section("Open Source & Programs")
#oss_entry(
  "Linux Kernel Summer 2026 - The Linux Foundation",
  "https://www.linuxfoundation.org",
  [
  ],
)

#list_vspace

#oss_entry(
  "RTEMS - RTOS for Multiprocessor Systems",
  "https://gitlab.rtems.org/rtems",
  [
    #list(tight: true, indent: 10pt)[
      Enabled IMFS testing on BSPs with tight memory constraints, like the sparc/erc32 bsp
    ][
      Implemented POSIX compliant `ENAMETOOLONG` handling in `cpukit/libio` by validating path components against `NAME_MAX` during filesystem path evaluation
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
      Quality of life improvements when displaying empty ranges
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
#project_entry("kaworu", "aarch64, kernel, unix-like", "https://github.com/prashantrahul141/kaworu", "A WIP unix-like aarch64 kernel")
#list_vspace

#project_entry("evelin", "compiler, qbe, rust", "https://github.com/prashantrahul141/evelin", "Evelin is a general purpose, statically typed, compiled language using the QBE backend with C FFI support.")
#list_vspace

#project_entry("cipi8", "chip8, chip8-emulator, cpp", "https://github.com/prashantrahul141/cipi8", "C++ Chip-8 emulator with opcode, graphics, input, and timer support.")
#list_vspace

#project_entry("zspie", "c, compiler, interpreter", "https://github.com/prashantrahul141/zspie", "Zspie is a fast, easy, dynamic programming language, implemented in C with a virtual machine and opcode based execution.")
#section("Skills")
#text(weight: "bold")[Programming languages:]
Rust, C/C++, Python, Go, LLVM IR, QBE IR, Typescript, Javascript
#list_vspace
#text(weight: "bold")[Technologies & Tools:]
GNU/Linux, Nix/NixOS, Git, CMake, Make, Meson, Vi/Vim/Neovim, POSIX Shells, NodeJS
#list_vspace
#text(weight: "bold")[Concepts & Practices:]
Embedded Systems, RTOS, Device drivers, Firmware development, Operating systems, Cryptography Fundamentals, ARM ISA, Version Control, CI/CD
