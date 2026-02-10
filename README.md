# swift-concurrency-and-performance

Production-focused iOS concurrency & performance case studies.

This repository demonstrates **real-world bugs**, **root-cause analysis**, and **measured fixes**
using modern Swift concurrency and Apple performance tools.

Topics covered:
- async/await vs GCD
- Actor isolation
- Cancellation & cooperative cancellation
- Thread safety patterns
- ARC & retain cycles
- Instruments (Time Profiler, Leaks, Allocations, Hangs, Signposts, TSAN)

> Goal: show how to **debug, measure, and fix** concurrency issues the way you would in a production iOS codebase.

---

## Who this is for

If you already know how to “make it work”, this repo is about making it:

- **Correct under concurrency**
- **Observable and measurable**
- **Maintainable under change**
- **Safe under load**

The **Senior → Principal** difference becomes clear in how you:
- reason about failure modes
- validate fixes with evidence (Instruments, TSAN)
- document trade-offs and rollout strategy

---

## How to run

### Requirements
- Xcode 15+
- iOS 15+

### Open
Open the workspace:
- `SwiftConcurrencyAndPerformance.xcworkspace`

Run:
- `DemoApp` (UIKit + Storyboard)

---

## Project structure
Apps/
DemoApp/
Modules/
CoreLogging/
CoreBenchmarks/
Docs/
01-async-await-vs-gcd.md
02-actor-isolation.md
03-cancellation.md
04-thread-safety.md
05-arc-retain-cycles.md
06-instruments-playbook.md

---

## Case study format

Each demo follows a production-style template:

### 1) Symptom
What does the user / QA / monitoring observe?
(e.g. UI freeze, random crash, stale results, battery drain)

### 2) What went wrong?
Root cause explained with concurrency primitives and timing.

### 3) How we fixed it
Concrete changes in code (actors, cancellation, isolation, queues/locks).

### 4) Evidence
Benchmarks + Instruments screenshots / logs (TSAN / Signposts / Hangs).

### 5) Why this matters in production
Trade-offs, edge cases, rollout notes, monitoring signals.

---

## Demos

- Race condition demo (TSAN + fixes)
- Actor vs serial queue benchmark
- Cancellation & cooperative cancellation
- ViewModel-style cancellation
- Memory leak case study (ARC + Tasks)
- UI freeze root-cause analysis (Hangs + signposts)

---

## Docs index

- [01 – async/await vs GCD](Docs/01-async-await-vs-gcd.md)
- [02 – Actor isolation](Docs/02-actor-isolation.md)
- [03 – Cancellation](Docs/03-cancellation.md)
- [04 – Thread safety](Docs/04-thread-safety.md)
- [05 – ARC & retain cycles](Docs/05-arc-retain-cycles.md)
- [06 – Instruments playbook](Docs/06-instruments-playbook.md)

---

## License

MIT
