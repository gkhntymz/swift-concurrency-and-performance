# 02 — Actor Isolation

Actors protect mutable state by guaranteeing **single-threaded access**.

---

## What problem actors solve

Race conditions occur when:
- multiple threads access shared mutable state
- without synchronization

Locks and queues fix this manually.
Actors fix this **by construction**.

---

## Actor guarantees

- only one task can access actor state at a time
- compiler enforces isolation
- no accidental data races

---

## Cost of actors

- context switching
- async boundaries everywhere
- potential performance overhead

Actors trade **raw speed** for **correctness and clarity**.

---

## When to use actors

- shared mutable state
- counters, caches, in-memory stores
- coordination between tasks

---

## When not to

- pure value transformations
- hot loops where locking cost dominates
- trivial local state

---

## Takeaway

Actors are not “free”.
They are **explicit correctness boundaries**.
