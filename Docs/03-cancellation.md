# 03 — Cancellation

Cancellation is a first-class concept in Swift concurrency.

---

## The core rule

Cancellation is **cooperative**.

Tasks must:
- check for cancellation
- respect cancellation
- stop work early

---

## What goes wrong without cancellation

- wasted CPU
- stale UI updates
- memory pressure
- battery drain

---

## Types of cancellation in this repo

1) Basic cancellation
2) Cooperative cancellation
3) ViewModel-style cancellation

Each represents increasing production realism.

---

## Best practices

- cancel previous tasks before starting new ones
- check `Task.isCancelled` in loops
- call `Task.checkCancellation()` at safe points

---

## Takeaway

If work can be cancelled but isn’t,
**it will eventually cause production issues**.
