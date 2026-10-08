Scheduler Specification Document (SSD)
Day Planner v2.0

Version: 1.0

1. Purpose

The Scheduler Engine is responsible for maintaining a valid planner state.

A valid planner state satisfies all scheduling constraints without requiring manual conflict resolution from the user.

The scheduler operates independently of the UI.

It accepts planner data as input and returns an updated planner state.

The scheduler never interacts with widgets, animations, dialogs, or platform APIs.

2. Scheduler Responsibilities

The Scheduler Engine shall be responsible for:

Automatic task placement
Task movement
Task resizing
Conflict detection
Conflict resolution
Break avoidance
Timeline boundary enforcement
Auto Planner
Timeline validation
Schedule normalization

The Scheduler shall not:

Draw UI
Display dialogs
Show notifications
Manage themes
Save data
3. Timeline Model

Timeline length

00:00

↓

23:59

Internally

0 minutes

↓

1439 minutes

Every task is represented using integer minutes.

Example

09:30

↓

570

Duration is also stored as integer minutes.

4. Time Resolution

The planner operates on a fixed resolution.

Grid Size

15 Minutes

All scheduling operations shall snap to this grid.

Examples

09:02

↓

09:00
09:07

↓

09:15
09:26

↓

09:30

No task may exist outside this resolution.

5. Schedule Entity

Each scheduled block contains

id

type

name

startMinute

duration

endMinute

completed

recurring

colorTag

End minute is always computed

endMinute

=

startMinute

+

duration
6. Block Types

Supported

Task

Break

Task

movable
resizable
completable

Break

movable
resizable
non-completable
fixed priority
7. Scheduler Rules

The scheduler guarantees

✓ No task overlap

✓ No task inside break

✓ Timeline validity

✓ 15 minute alignment

✓ Minimum duration

✓ Automatic correction

8. Task Creation Algorithm

Input

Task

↓

Duration

Algorithm

Find Next Free Slot

↓

Validate

↓

Insert

↓

Resolve Conflicts

↓

Return Updated Planner

No user positioning occurs.

9. Next Free Slot Algorithm

Search begins from

Current Time

↓

Rounded to nearest 15 minutes

Search proceeds chronologically.

For every candidate position

Candidate

↓

Check Timeline

↓

Check Breaks

↓

Check Tasks

↓

Free?

↓

YES

↓

Return

Otherwise

Candidate += 15 minutes

Repeat until valid.

10. Conflict Definition

Two blocks conflict when

Task A Start

<

Task B End

AND

Task A End

>

Task B Start

Only tasks participate in cascading movement.

Breaks never move.

11. Conflict Resolution Algorithm

Whenever a task changes

Edited

Dragged

Resized

Created

Scheduler executes

Find First Conflict

↓

Move Conflicting Task

↓

Check Again

↓

Repeat

↓

Until Valid
12. Cascading Movement

Example

Task A

09:00

↓

10:00

Task B

09:30

↓

10:00

Conflict

↓

Task B becomes

10:00

↓

10:30

If this creates another conflict

Continue recursively.

13. Break Handling

Breaks have priority.

Example

Break

12:00

↓

13:00

Task cannot exist

11:30

↓

12:30

Scheduler searches next valid position.

Breaks are never displaced.

14. Drag Algorithm

Pointer Down

↓

Determine Selected Task

↓

Begin Drag

↓

Track Cursor

↓

Snap

↓

Preview Position

↓

Release

↓

Resolve Conflicts

↓

Save

15. Snap Algorithm

All movement snaps

minute

↓

nearest multiple of 15

No exceptions.

16. Resize Algorithm

Resize

↓

Snap Duration

↓

Minimum Duration Check

↓

Conflict Check

↓

Push Tasks

↓

Update Planner

17. Minimum Duration

Minimum

15 minutes

Maximum

Timeline Length

18. Timeline Boundary Algorithm

Task may never exceed planner boundaries.

If movement exceeds boundary

Execute

Ensure Inside Timeline
19. Wrap Around

Moving beyond midnight

23:45

↓

00:00

Moving above

00:00

↓

23:45

Wrap preserves duration.

20. Auto Planner Algorithm

Step 1

Determine

Current Time

↓

Step 2

Split Tasks

Completed

Incomplete

↓

Step 3

Completed Tasks

Remain Completed

↓

Step 4

Remove Incomplete Tasks

↓

Step 5

Find First Free Slot

↓

Insert Sequentially

↓

Avoid Breaks

↓

Avoid Conflicts

↓

Save

21. Scheduler Priority

Highest Priority

Timeline Boundary

↓

Breaks

↓

Existing Tasks

↓

New Task

22. Validation Pipeline

Every operation executes

Normalize

↓

Snap

↓

Boundary Check

↓

Conflict Check

↓

Break Check

↓

Resolve

↓

Return
23. Schedule Normalization

After every scheduler operation

Guarantee

Valid minutes
Valid duration
Valid ordering
Valid overlap state
Valid break state
24. Scheduler Invariants

These must always be true.

Invariant 1

No task overlaps another task.

Invariant 2

No task overlaps a break.

Invariant 3

Duration ≥ 15.

Invariant 4

Tasks exist inside timeline.

Invariant 5

Start < End.

Invariant 6

All minutes align to 15-minute grid.

Invariant 7

Breaks retain priority.

25. Complexity Targets

Expected

Task Creation

O(n)

Conflict Resolution

O(n)

Auto Planner

O(n log n)

Planner Validation

O(n)

Where

n

=

number of scheduled blocks.

26. Engine Interface

The Scheduler Engine should expose methods similar to:

findNextFreeSlot()

moveTask()

resizeTask()

resolveConflicts()

validateSchedule()

ensureInsideTimeline()

autoPlan()

taskConflict()

overlapsBreak()

normalizePlanner()

The scheduler returns a new or updated planner state and does not mutate UI directly.

27. Migration Requirements

The Flutter Scheduler Engine shall reproduce the observable behavior of the existing Python scheduler.

This includes:

Placement decisions.
Conflict resolution order.
Break precedence.
Grid snapping.
Timeline wrapping.
Auto Planner sequencing.
Validation rules.

Any implementation differences are acceptable only if the resulting planner behavior remains functionally identical to the original application.