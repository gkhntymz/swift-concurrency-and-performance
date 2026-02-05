## Evidence: Thread Sanitizer (TSAN)

When running `BrokenCounter` under concurrent increments, TSAN reports a data race in:

- `RaceConditionDemo.BrokenCounter.increment()` (`value += 1`)

The same workload with `LockBasedCounter`, `SerialQueueCounter`, and `ActorCounter` produces the expected result (`iterations`) without TSAN race warnings.


### Expected output (example)

Broken:
- ~50k–65k / 200k (varies per run)

Fixed:
- Lock: 200k / 200k
- Queue: 200k / 200k
- Actor: 200k / 200k