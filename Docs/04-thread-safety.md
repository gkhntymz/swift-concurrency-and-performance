# 04 — Thread Safety

Thread safety is about **state ownership**, not threads.

---

## Common misconception

“async means thread-safe” — false.

Concurrency increases the chance of races.

---

## Thread safety tools

- locks
- serial queues
- actors
- immutability

Each has trade-offs.

---

## What we demonstrate

- broken counter with races
- fixes using lock / queue / actor
- TSAN evidence

---

## Takeaway

Thread safety must be:
- explicit
- measurable
- enforced by structure

Hope is not a strategy.
