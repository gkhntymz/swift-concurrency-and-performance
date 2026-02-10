# 01 — async/await vs GCD

This document explains **why async/await is not just syntax sugar**
and how it differs fundamentally from GCD.

---

## The problem with GCD

GCD solves *threading*, not *lifetimes*.

Common issues:
- no structured cancellation
- unclear ownership of work
- hard-to-reason control flow
- easy to leak background work

GCD queues execute blocks, but blocks have no parent, no scope, no lifecycle.

---

## What async/await changes

Swift concurrency introduces **structured concurrency**.

Key differences:
- tasks have parents
- cancellation propagates
- lifetimes are scoped
- errors are part of the type system

This means:
> work ends when its scope ends — unless you explicitly escape it.

---

## Practical difference

GCD:
- fire-and-forget by default
- cancellation is manual and fragile

async/await:
- cancellation is cooperative and automatic
- parent task controls child lifetime

---

## When GCD is still valid

- low-level primitives
- compatibility layers
- performance-critical code with proven safety

But application-level logic should prefer structured concurrency.

---

## Takeaway

async/await is not “nicer syntax”.
It’s a **different execution model** designed for correctness under concurrency.
