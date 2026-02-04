## Evidence: Thread Sanitizer (TSAN)

When running `BrokenCounter` under concurrent increments, TSAN reports a data race in:

- `RaceConditionDemo.BrokenCounter.increment()` (`value += 1`)

The same workload with `LockBasedCounter`, `SerialQueueCounter`, and `ActorCounter` produces the expected result (`iterations`) without TSAN race warnings.
