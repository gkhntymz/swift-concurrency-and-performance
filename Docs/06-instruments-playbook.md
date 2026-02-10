# 06 — Instruments Playbook (Production Debugging)

This playbook documents how to debug **real-world concurrency and performance issues**
using Instruments and related tooling.

This is not a tutorial. It’s a **decision guide**:
- when to use which tool
- what signals to look for
- how to validate a fix with evidence

---

## Why Instruments are mandatory

Concurrency bugs are **timing-dependent**. Logs are incomplete. Breakpoints lie.

Instruments provide:
- time-based evidence
- system-level visibility
- repeatable before/after comparisons

A fix that cannot be validated with evidence is not a fix.

---

## Tool map (what each tool answers)

### Time Profiler
Answers: *“Where is CPU time spent?”*  
Use when:
- UI feels slow
- battery drain is suspected
- “async code looks fine” but performance is still bad

Look for:
- expensive work on the main thread
- repeated allocations / decoding hotspots
- unexpected thread hops
- excessive task creation

Key idea:
`async/await` does **not** automatically mean “background”.

---

### Hangs
Answers: *“When and why did the main thread stall?”*  
Use when:
- scrolling freezes
- taps are delayed
- UI occasionally becomes unresponsive

Look for:
- long main-thread blocks
- synchronous waits (locks, semaphores)
- heavy parsing/decoding on main
- awaiting work on the MainActor that shouldn’t be there

Typical root causes:
- large JSON decode on main
- accidental `.sync` on a serial queue
- cancellation not respected → work continues after UI moved on

---

### Allocations
Answers: *“What allocations are happening and when?”*  
Use when:
- memory grows during repeated navigation
- “just scrolling” increases memory
- async loops create too many temporary objects

Look for:
- allocation spikes per user action
- repeated creation of big buffers / images
- types responsible for most allocations

Practical goal:
turn “it feels heavy” into “this type allocates X times per action”.

---

### Leaks
Answers: *“What is never deallocated?”*  
Use when:
- screens never deinit
- memory only grows
- tasks keep running after dismissal

Look for:
- retain cycles between ViewController ↔ ViewModel ↔ Task
- captured `self` in long-running tasks
- detached tasks that outlive their owner

Rule of thumb:
Task lifetime must be **bounded** by something you control (screen, coordinator, manager).

---

### Points of Interest (Signposts)
Answers: *“Can we see async work boundaries on the timeline?”*  
Use when:
- async work is “invisible”
- you need to correlate user actions with background tasks
- you need measurable before/after timings for a PR

Instrument these moments:
- task started
- task cancelled
- task finished
- critical section entered/exited
- “search request fired” / “result applied”

Why this matters:
without signposts, your reasoning stays anecdotal.
With signposts, you get **timeline proof**.

---

### Thread Sanitizer (TSAN)
Answers: *“Is there a data race?”*  
Use when:
- crashes are non-deterministic
- state occasionally becomes invalid
- “it only happens on some devices”

TSAN catches:
- unsynchronized shared mutable state
- broken assumptions about isolation

TSAN does NOT catch:
- performance issues
- deadlocks (mostly)
- logic bugs unrelated to concurrency

Best practice:
run TSAN on demos that mutate shared state (race condition case study).

---

## How to read async timelines (mental model)

- Threads are not tasks.
- Tasks hop threads.
- Suspension points (await) break “linear time” intuition.

So the workflow is:
1) find the user-visible symptom (slow tap, freeze, stale UI)
2) locate the dominant signal (hang, CPU hotspot, memory leak)
3) connect it to a specific async lifetime (task that runs too long, never cancels, updates UI late)

---

## Workflow: from evidence to fix

### Step 1 — Reproduce
- define a repeatable action (tap sequence, typing pattern, navigation loop)
- reproduce 3–5 times to confirm it’s consistent

### Step 2 — Capture baseline
- record an Instruments run (or TSAN run)
- save trace as baseline

### Step 3 — Identify the dominant signal
Examples:
- Hangs shows main thread blocked → investigate blocking call
- Time Profiler shows JSON decoding hotspot → move decode off main
- Leaks shows VC retained by Task → fix ownership/cancellation

### Step 4 — Implement the fix
Keep changes small and targeted.

### Step 5 — Validate
Re-run the same scenario.
Compare before/after:
- reduced hang durations
- reduced CPU time in hotspot
- deinit now happens
- cancellation stops work earlier

---

## Production checklist

### Before shipping
- run Time Profiler on main flows
- verify screens deallocate after dismissal
- verify cancellation on rapid interactions (search-as-you-type)
- run TSAN on concurrency-heavy code paths

### After release
- investigate user-reported freezes with Hangs
- monitor memory growth patterns
- add signposts for critical user journeys (debug builds, internal builds)

---

## Final takeaway

Concurrency issues are invisible without measurement.

Instruments turn guessing into engineering:
- evidence → fix → validation
- repeatable traces → confident decisions
- measurable trade-offs → production-grade outcomes
