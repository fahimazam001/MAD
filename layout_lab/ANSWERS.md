# Lab Answers: Team Board

**Name:** Fahim Azam  
**Roll No:** 04072312039  

## Numerical Answers
A1: 20  
A2: 25  
A3: 2  
A4: 33  

## Written Answers

### B1: Which of your classes are Stateless and which are Stateful, and why?
- **Stateless Widgets:** `LabApp`, `HomePage`, `SettingsCard`, `SummaryRow`, `Welcome`, `InfoPanel`, `InfoBox`, `StampStack`, `Probe`, and `SummaryRow`. These are stateless because their visual appearance depends entirely on fixed configuration parameters or immutable properties passed down to them, and they do not mutate internal data over time.
- **Stateful Widgets:** `Clock`, `Tile`, and `SwapBoard`. These are stateful because they manage mutable local state that changes dynamically during runtime (such as ticking elapsed seconds, incrementing button tap counters, or reordering list elements).

### B2: Widget, Element, RenderObject: which one is rebuilt on every setState and which ones are kept? What did Probe show you?
- On every `setState()`, a new **Widget** instance is created and built from scratch ("cheap and thrown away"). 
- The **Element** and **RenderObject** trees are persistent; they are kept across rebuilds, maintaining the underlying UI layout structure and associated State objects.
- The `Probe` widget demonstrated this directly: the **Widget's** `identityHashCode` changed on every tick/rebuild, whereas the **Element's** `identityHashCode` remained completely constant.

### B3: Explain “constraints go down, sizes go up” using your Step 7 or Step 8 example?
- In Step 7 (`SummaryRow`), an unconstrained `Row` passes unbounded horizontal constraints to its text children, causing them to overflow off-screen. By wrapping each `Text` in an `Expanded` widget, the `Row` passes strict maximum width constraints *down* to the child. The child responds by calculating its required height within that constraint and passing its size *up*, forcing the text to wrap neatly across multiple lines rather than overflowing.