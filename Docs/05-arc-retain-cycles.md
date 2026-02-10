# 05 — ARC & Retain Cycles

Swift concurrency introduces **new retain cycle patterns**.

---

## Common problem

Tasks capture `self` strongly and outlive the screen.

Result:
- ViewController never deallocates
- background work continues forever

---

## Typical offenders

- `Task {}` inside ViewController
- detached tasks
- long-running async loops

---

## Fix patterns

- cancel tasks in `deinit`
- store tasks and manage lifetime
- use weak captures where appropriate

---

## Evidence

Leaks & Allocations instruments
prove whether deinit happens.

---

## Takeaway

ARC rules didn’t change.
**Async code just makes leaks easier to hide.**
