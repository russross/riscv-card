#set page(margin: 0.5in, paper: "us-letter")

// Define font roles
#let font-body = "Latin Modern Roman 9"
#let font-mono = "Latin Modern Mono 9"
#let font-size = 9pt

#set text(font: font-body, size: font-size)

#align(center)[= RISC-V: Base Integer Instructions]
#v(1em)

#set table.hline(stroke: 0.5pt)

// Function to pad example column: aligns operands at column 8
#let pad-ex(mnem, ops) = [
  #mnem#(for _ in range(7 - mnem.len()) { "\u{00A0}" })#ops
]

#let instr-table(header, rows) = {
  show table.cell.where(x: 0): set text(font: font-mono, size: font-size)
  show table.cell.where(x: 0, y: 0): set text(font: font-body, size: font-size)
  show table.cell.where(x: 2): it => align(center, it)
  show table.cell.where(x: 3): set text(font: font-mono, size: font-size)
  show table.cell.where(x: 3, y: 0): set text(font: font-body, size: font-size)
  show table.cell.where(x: 4): set text(font: font-mono, size: font-size)
  show table.cell.where(x: 4, y: 0): set text(font: font-body, size: font-size)

  align(center, table(
    columns: (auto, auto, auto, auto, auto, auto),
    align: (left, left, center, left, left, left),
    stroke: (x: 0.5pt, y: none),
    inset: (x: 0.5em, y: 0.275em),

    table.hline(),
    header,
    table.hline(),
    ..rows,
    table.hline(),
  ))
}

#let reg-table(header, rows) = {
  show table.cell.where(x: 0): set text(font: font-mono, size: font-size)
  show table.cell.where(x: 0, y: 0): set text(font: font-body, size: font-size)
  show table.cell.where(x: 1): set text(font: font-mono, size: font-size)
  show table.cell.where(x: 1, y: 0): set text(font: font-body, size: font-size)
  show table.cell.where(x: 2): set text(font: font-body, size: font-size)
  show table.cell.where(x: 3): set text(font: font-body, size: font-size)

  align(center, table(
    columns: (auto, auto, auto, auto),
    align: (left, left, left, left),
    stroke: (x: 0.5pt, y: none),
    inset: (x: 0.5em, y: 0.275em),

    table.hline(),
    header,
    table.hline(),
    ..rows,
    table.hline(),
  ))
}

#instr-table(
  table.header[*Opcode*][*Instruction*][*Fmt*][*Example*][*Description*][*Notes*],
  (
    // R-type arithmetic
    [add], [add], [R], [#pad-ex("add", "a0, a1, a2")], [a0 = a1 + a2], [],
    [sub], [subtract], [R], [#pad-ex("sub", "a0, a1, a2")], [a0 = a1 - a2], [],
    [xor], [bitwise exclusive or], [R], [#pad-ex("xor", "a0, a1, a2")], [a0 = a1 ^ a2], [],
    [or], [bitwise or], [R], [#pad-ex("or", "a0, a1, a2")], [a0 = a1 | a2], [],
    [and], [bitwise and], [R], [#pad-ex("and", "a0, a1, a2")], [a0 = a1 & a2], [],
    [sll], [shift left logical], [R], [#pad-ex("sll", "a0, a1, a2")], [a0 = a1 << a2], [],
    [srl], [shift right logical], [R], [#pad-ex("srl", "a0, a1, a2")], [a0 = a1 >> a2], [],
    [sra], [shift right arith], [R], [#pad-ex("sra", "a0, a1, a2")], [a0 = a1 >> a2], [sign-extends],
    [slt], [set less than], [R], [#pad-ex("slt", "a0, a1, a2")], [a0 = (a1 < a2) ? 1 : 0], [],
    [sltu], [set less than (u)], [R], [#pad-ex("sltu", "a0, a1, a2")], [a0 = (a1 < a2) ? 1 : 0], [unsigned],
    table.hline(),

    // I-type arithmetic
    [addi], [add immediate], [I], [#pad-ex("addi", "a0, a1, 2")], [a0 = a1 + 2], [],
    [xori], [xor immediate], [I], [#pad-ex("xori", "a0, a1, 2")], [a0 = a1 ^ 2], [],
    [ori], [or immediate], [I], [#pad-ex("ori", "a0, a1, 2")], [a0 = a1 | 2], [],
    [andi], [and immediate], [I], [#pad-ex("andi", "a0, a1, 2")], [a0 = a1 & 2], [],
    [slli], [shift left logical imm], [I], [#pad-ex("slli", "a0, a1, 2")], [a0 = a1 << 2], [],
    [srli], [shift right logical imm], [I], [#pad-ex("srli", "a0, a1, 2")], [a0 = a1 >> 2], [],
    [srai], [shift right arith imm], [I], [#pad-ex("srai", "a0, a1, 2")], [a0 = a1 >> 2], [sign-extends],
    [slti], [set less than imm], [I], [#pad-ex("slti", "a0, a1, 2")], [a0 = (a1 < 2) ? 1 : 0], [],
    [sltiu], [set less than imm (u)], [I], [#pad-ex("sltiu", "a0, a1, 2")], [a0 = (a1 < 2) ? 1 : 0], [unsigned],
    table.hline(),

    // instructions
    [li], [load immediate], [], [#pad-ex("li", "a0, 2")], [addi a0, zero, 2], [_pseudo_],
    [la], [load address], [], [#pad-ex("la", "a0, symbol")], [a0 = symbol], [_pseudo_],
    table.hline(),

    [mv], [move (copy)], [], [#pad-ex("mv", "a0, a1")], [addi a0, a1, 0], [_pseudo_],
    [neg], [2s-complement negation], [], [#pad-ex("neg", "a0, a1")], [sub a0, zero, a1], [_pseudo_],
    [not], [bitwise not], [], [#pad-ex("not", "a0, a1")], [xori a0, a1, -1], [_pseudo_],
    table.hline(),

    // Load instructions
    [lb], [load byte], [I], [#pad-ex("lb", "a0, 1(a1)")], [a0 = M\[a1+1\]], [8 bits],
    [lh], [load half], [I], [#pad-ex("lh", "a0, 2(a1)")], [a0 = M\[a1+2\]], [16 bits],
    [lw], [load word], [I], [#pad-ex("lw", "a0, 4(a1)")], [a0 = M\[a1+4\]], [32 bits],
    [lbu], [load byte (u)], [I], [#pad-ex("lbu", "a0, 1(a1)")], [a0 = M\[a1+1\]], [zero-extends],
    [lhu], [load half (u)], [I], [#pad-ex("lhu", "a0, 2(a1)")], [a0 = M\[a1+2\]], [zero-extends],
    table.hline(),

    // Store instructions
    [sb], [store byte], [S], [#pad-ex("sb", "a0, 1(a1)")], [M\[a1+1\] = a0], [8 bits],
    [sh], [store half], [S], [#pad-ex("sh", "a0, 2(a1)")], [M\[a1+2\] = a0], [16 bits],
    [sw], [store word], [S], [#pad-ex("sw", "a0, 4(a1)")], [M\[a1+4\] = a0], [32 bits],
    table.hline(),

    // Branch instructions
    [beq], [branch if $=$], [B], [#pad-ex("beq", "a0, a1, label")], [if (a0 == a1) goto label], [],
    [bne], [branch if $≠$], [B], [#pad-ex("bne", "a0, a1, label")], [if (a0 != a1) goto label], [],
    [blt], [branch if $<$], [B], [#pad-ex("blt", "a0, a1, label")], [if (a0 < a1) goto label], [],
    [ble], [branch if $≤$], [], [#pad-ex("ble", "a0, a1, label")], [if (a0 <= a1) goto label], [_pseudo_ (bge a1, a0, label)],
    [bgt], [branch if $>$], [], [#pad-ex("bgt", "a0, a1, label")], [if (a0 > a1) goto label], [_pseudo_ (blt a1, a0, label)],
    [bge], [branch if $≥$], [B], [#pad-ex("bge", "a0, a1, label")], [if (a0 >= a1) goto label], [],
    [bltu], [branch if $<$ (u)], [B], [#pad-ex("bltu", "a0, a1, label")], [if (a0 < a1) goto label], [unsigned],
    [bleu], [branch if $≤$ (u)], [], [#pad-ex("bleu", "a0, a1, label")], [if (a0 <= a1) goto label], [unsigned, _pseudo_],
    [bgtu], [branch if $>$ (u)], [], [#pad-ex("bgtu", "a0, a1, label")], [if (a0 > a1) goto label], [unsigned, _pseudo_],
    [bgeu], [branch if $≥$ (u)], [B], [#pad-ex("bgeu", "a0, a1, label")], [if (a0 >= a1) goto label], [unsigned],
    table.hline(),

    // Branch zero instructions
    [beqz], [branch if $= 0$], [], [#pad-ex("beqz", "a0, label")], [if (a0 == 0) goto label], [_pseudo_],
    [bnez], [branch if $≠ 0$], [], [#pad-ex("bnez", "a0, label")], [if (a0 != 0) goto label], [_pseudo_],
    [bltz], [branch if $< 0$], [], [#pad-ex("bltz", "a0, label")], [if (a0 < 0) goto label], [_pseudo_],
    [blez], [branch if $≤ 0$], [], [#pad-ex("blez", "a0, label")], [if (a0 <= 0) goto label], [_pseudo_],
    [bgtz], [branch if $> 0$], [], [#pad-ex("bgtz", "a0, label")], [if (a0 > 0) goto label], [_pseudo_],
    [bgez], [branch if $≥ 0$], [], [#pad-ex("bgez", "a0, label")], [if (a0 >= 0) goto label], [_pseudo_],
    table.hline(),

    // Jump instructions
    [jal], [jump and link], [J], [#pad-ex("jal", "ra, label")], [ra = pc + 4; jump to label], [],
    [jalr], [jump and link reg], [I], [#pad-ex("jalr", "ra, 0(a1)")], [ra = pc + 4; jump to a1], [],
    [j], [jump], [], [#pad-ex("j", "label")], [jump to label], [_pseudo_],
    [call], [call subroutine], [], [#pad-ex("call", "label")], [ra = pc + 4; jump to label], [_pseudo_],
    [ret], [return], [], [#pad-ex("ret", "")], [jump to address in ra], [_pseudo_],
    table.hline(),

    // Upper immediate
    [lui], [load upper imm], [U], [#pad-ex("lui", "a0, 1234")], [a0 = 1234 << 12], [],
    [auipc], [add upper imm to pc], [U], [#pad-ex("auipc", "a0, 1234")], [a0 = pc + (1234 << 12)], [],
    table.hline(),

    // System instructions
    [ecall], [environment call], [I], [#pad-ex("ecall", "")], [system call], [],
    [ebreak], [environment break], [I], [#pad-ex("ebreak", "")], [break to debugger], [],
    [fence], [fence], [I], [#pad-ex("fence", "")], [prevent memory reordering], [memory synchronization],
    table.hline(),
  )
)

#pagebreak()

#align(center)[= Multiply Extension]
#v(1em)

#instr-table(
  table.header[*Opcode*][*Instruction*][*Fmt*][*Example*][*Description*][*Notes*],
  (
    // Multiply instructions
    [mul], [multiply], [R], [#pad-ex("mul", "a0, a1, a2")], [a0 = (a1 × a2)\[31:0\]], [lower 32 bits],
    [mulh], [multiply high signed], [R], [#pad-ex("mulh", "a0, a1, a2")], [a0 = (a1 × a2)\[63:32\]], [upper bits, signed],
    [mulhsu], [multiply high signed×unsigned], [R], [#pad-ex("mulhsu", "a0, a1, a2")], [a0 = (a1 × a2)\[63:32\]], [a1 signed, a2 unsigned],
    [mulhu], [multiply high unsigned], [R], [#pad-ex("mulhu", "a0, a1, a2")], [a0 = (a1 × a2)\[63:32\]], [upper bits, unsigned],
    table.hline(),

    // Divide instructions
    [div], [divide signed], [R], [#pad-ex("div", "a0, a1, a2")], [a0 = a1 / a2], [signed division],
    [divu], [divide unsigned], [R], [#pad-ex("divu", "a0, a1, a2")], [a0 = a1 / a2], [unsigned division],
    table.hline(),

    // Remainder instructions
    [rem], [remainder signed], [R], [#pad-ex("rem", "a0, a1, a2")], [a0 = a1 % a2], [signed modulo],
    [remu], [remainder unsigned], [R], [#pad-ex("remu", "a0, a1, a2")], [a0 = a1 % a2], [unsigned modulo],
    table.hline(),
  )
)

#v(2em)

#align(center)[= Registers]
#v(1em)

#reg-table(
  table.header[*Register*][*ABI Name*][*Description*][*Saver*],
  (
    [x0], [zero], [constant zero], [],
    [x1], [ra], [return address], [Caller],
    [x2], [sp], [stack pointer], [Callee],
    [x3], [gp], [global pointer], [],
    [x4], [tp], [thread pointer], [],
    [x5–x7], [t0–t2], [temporary], [Caller],
    [x8], [s0 / fp], [saved register / frame pointer], [Callee],
    [x9], [s1], [saved register], [Callee],
    [x10–x11], [a0–a1], [argument / return value], [Caller],
    [x12–x17], [a2–a7], [argument], [Caller],
    [x18–x27], [s2–s11], [saved register], [Callee],
    [x28–x31], [t3–t6], [temporary], [Caller],
  )
)

#v(2em)

#align(center)[= Instruction Formats]
#v(1em)

#let instr-format-grid = {
  // Define field boundaries for each format (x-coordinates where vertical lines should appear)
  // R-type: funct7(7) | rs2(5) | rs1(5) | funct3(3) | rd(5) | opcode(7)
  let r-boundaries = (7, 12, 17, 20, 25, 32)
  // I-type: imm[11:0](12) | rs1(5) | funct3(3) | rd(5) | opcode(7)
  let i-boundaries = (12, 17, 20, 25, 32)
  // S-type: imm[11:5](7) | rs2(5) | rs1(5) | funct3(3) | imm[4:0](5) | opcode(7)
  let s-boundaries = (7, 12, 17, 20, 25, 32)
  // B-type: imm[12|10:5](7) | rs2(5) | rs1(5) | funct3(3) | imm[4:1|11](5) | opcode(7)
  let b-boundaries = (7, 12, 17, 20, 25, 32)
  // U-type: imm[31:12](20) | rd(5) | opcode(7)
  let u-boundaries = (20, 25, 32)
  // J-type: imm[20|10:1|11|19:12](20) | rd(5) | opcode(7)
  let j-boundaries = (20, 25, 32)

  // All format boundaries for each row
  let all-boundaries = (r-boundaries, i-boundaries, s-boundaries, b-boundaries, u-boundaries, j-boundaries)

  // Stroke function that draws lines between fields and around rows
  let grid-stroke = (x, y) => {
    // y=0 is header, y=1-6 are the format rows
    // For the format type column (x==32)
    if x == 32 {
      if y == 0 {
        // Header cell: no strokes
        return (
          left: none,
          right: none,
          top: none,
          bottom: none,
        )
      } else {
        // Format label cells: left border only
        return (
          left: 0.5pt,
          right: none,
          top: none,
          bottom: none,
        )
      }
    }

    // Header row has no strokes
    if y == 0 {
      return (
        left: none,
        right: none,
        top: none,
        bottom: none,
      )
    }

    // Determine which format we're in (y=1 is R, y=2 is I, etc)
    let format-idx = y - 1
    let boundaries = if format-idx >= 0 and format-idx < 6 {
      all-boundaries.at(format-idx)
    } else {
      ()
    }

    // Find the next boundary after current x position
    let next-boundary-idx = boundaries.position(b => b > x)
    let has-next-boundary = next-boundary-idx != none

    let strokes = (
      left: if x == 0 { 0.5pt } else { none },
      right: if has-next-boundary { 0.5pt } else { none },
      top: if y == 1 { 0.5pt } else { none },
      bottom: 0.5pt,
    )

    strokes
  }

  // Define field labels for each format
  let r-fields = (
    table.cell(colspan: 7, align: center)[funct7],
    table.cell(colspan: 5, align: center)[rs2],
    table.cell(colspan: 5, align: center)[rs1],
    table.cell(colspan: 3, align: center)[funct3],
    table.cell(colspan: 5, align: center)[rd],
    table.cell(colspan: 7, align: center)[opcode],
    table.cell()[R-type],
  )

  let i-fields = (
    table.cell(colspan: 12, align: center)[imm[11:0]],
    table.cell(colspan: 5, align: center)[rs1],
    table.cell(colspan: 3, align: center)[funct3],
    table.cell(colspan: 5, align: center)[rd],
    table.cell(colspan: 7, align: center)[opcode],
    table.cell()[I-type],
  )

  let s-fields = (
    table.cell(colspan: 7, align: center)[imm[11:5]],
    table.cell(colspan: 5, align: center)[rs2],
    table.cell(colspan: 5, align: center)[rs1],
    table.cell(colspan: 3, align: center)[funct3],
    table.cell(colspan: 5, align: center)[imm[4:0]],
    table.cell(colspan: 7, align: center)[opcode],
    table.cell()[S-type],
  )

  let b-fields = (
    table.cell(colspan: 7, align: center)[imm[12|10:5]],
    table.cell(colspan: 5, align: center)[rs2],
    table.cell(colspan: 5, align: center)[rs1],
    table.cell(colspan: 3, align: center)[funct3],
    table.cell(colspan: 5, align: center)[imm[4:1|11]],
    table.cell(colspan: 7, align: center)[opcode],
    table.cell()[B-type],
  )

  let u-fields = (
    table.cell(colspan: 20, align: center)[imm[31:12]],
    table.cell(colspan: 5, align: center)[rd],
    table.cell(colspan: 7, align: center)[opcode],
    table.cell()[U-type],
  )

  let j-fields = (
    table.cell(colspan: 20, align: center)[imm[20|10:1|11|19:12]],
    table.cell(colspan: 5, align: center)[rd],
    table.cell(colspan: 7, align: center)[opcode],
    table.cell()[J-type],
  )

  // Create header row with bit numbers (31 down to 0)
  let header-fields = range(32).map(col => {
    let bit-num = 31 - col
    table.cell(align: center)[#text(font: font-mono, size: 7pt)[#bit-num]]
  })
  header-fields.push(table.cell()[])  // empty cell for format type column

  // Create column specification: 32 fixed-width columns for bits + 1 auto column for type
  let bit-columns = range(32).map(_ => 1.5em)
  let columns = bit-columns + (auto,)

  align(center, table(
    columns: columns,
    stroke: grid-stroke,
    inset: (x: 0.15em, y: 0.2em),
    ..header-fields,
    ..r-fields,
    ..i-fields,
    ..s-fields,
    ..b-fields,
    ..u-fields,
    ..j-fields,
  ))
}

#instr-format-grid
