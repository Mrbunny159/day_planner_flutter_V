Technical Requirements Document (TRD)
Day Planner v2.0 (Flutter Migration)

Version: 1.0

Platforms:

Android
iOS
Windows
macOS
Linux

Framework:

Flutter

Language:

Dart

Architecture:

Offline First

1. Technical Goal

The application shall be rebuilt in Flutter while preserving the complete behavior of the original PyQt implementation.

This migration is a behavioral translation rather than a redesign.

No business logic shall be altered unless explicitly specified.

2. Architecture

The application shall use Clean Architecture.

Presentation Layer

↓

Application Layer

↓

Domain Layer

↓

Data Layer

↓

Storage

Each layer shall have a single responsibility.

3. Folder Structure
lib/

core/

config/

constants/

theme/

utils/

models/

services/

repositories/

engines/

controllers/

providers/

screens/

widgets/

dialogs/

animations/

storage/

main.dart

No UI code shall contain scheduling logic.

No scheduling engine shall directly manipulate widgets.

4. State Management

Recommended:

Riverpod

Reason:

Predictable
Reactive
Testable
Scalable
Minimal rebuilds

Every planner update shall be reactive.

5. Storage

Use:

SQLite

Reason:

Although the current application uses JSON, SQLite provides:

faster loading
indexing
future scalability
safer writes

The storage layer must expose exactly the same behavior as the existing application.

The UI must never know whether the storage implementation is JSON or SQLite.

6. Domain Models

The following models shall exist.

Task

Fields

id

name

startMinute

duration

completed

type

tagColor

recurring
Break

Uses the same model as Task.

Difference:

type = break
Planner Settings
theme

taskColor

taskBorderColor

breakColor

breakBorderColor

dayStartMinute

dayEndMinute

timeFontSize

timeFontBold
7. Repositories

PlannerRepository

Responsibilities

Load Planner
Save Planner
Delete Task
Delete Break
Update Task
Update Settings

SettingsRepository

Responsibilities

Read Settings
Write Settings
8. Services

The following services shall exist.

TaskService

Responsible for

Create
Edit
Delete
Complete
Restore

BreakService

Responsible for

Create
Edit
Delete

SettingsService

Responsible for

Theme
Colors
Fonts
Working Hours

PersistenceService

Responsible for

Save
Load
9. Scheduler Engine

This is the heart of the application.

The scheduler must be completely UI independent.

It shall expose methods such as

findNextFreeSlot()

resolveConflicts()

autoPlan()

moveTask()

resizeTask()

validateSchedule()

ensureInsideTimeline()

taskConflict()

overlapsBreak()

The scheduler returns updated planner data.

It never updates widgets.

10. Timeline Engine

Responsible for

minute → pixel conversion
pixel → minute conversion
snapping
scrolling
visible timeline

Methods

minuteToPosition()

positionToMinute()

snapToGrid()

centerOnCurrentTime()
11. Conflict Engine

Responsible for

Task overlap detection.

Algorithm

Task Moved

↓

Find first overlap

↓

Move overlapping task

↓

Repeat

↓

Until no conflicts remain

The engine continues until the schedule is valid.

12. Auto Planner Engine

Algorithm

Get Current Time

↓

Separate Completed

↓

Separate Incomplete

↓

Keep completed history

↓

Remove incomplete

↓

Insert incomplete again

↓

Avoid breaks

↓

Avoid overlaps

↓

Save

No UI logic exists here.

13. Drag Engine

Responsible for

Pointer Down

↓

Determine Drag

↓

Snap Position

↓

Update Preview

↓

Drop

↓

Resolve Conflicts

↓

Save
14. Resize Engine

Responsible for

Pointer Down

↓

Resize

↓

Snap Duration

↓

Validate

↓

Resolve Conflicts

↓

Save
15. Theme Engine

Responsible for

Theme

↓

Colors

↓

Borders

↓

Fonts

↓

Timeline

↓

Widgets

Entire UI updates reactively.

16. Validation Engine

Rules

No task overlap.

No task inside break.

Minimum duration.

Timeline boundaries.

Valid settings.

17. Animation Layer

Animations

Task Move

Conflict Flash

Current Time Movement

Selection

Hover

Context Menu

These must not alter business logic.

18. Persistence Rules

Every mutation automatically saves.

Examples

Task Created

↓

Save

Task Edited

↓

Save

Resize

↓

Save

Theme

↓

Save

Delete

↓

Save

No manual save operation exists.

19. Performance Requirements

Timeline rebuilds shall be localized.

Dragging one task must not rebuild the entire application.

Target

60 FPS dragging.

20. Error Recovery

If persistence fails

↓

Keep planner in memory.

↓

Notify storage layer.

↓

Prevent crash.

21. Dependency Rules

Presentation

↓

Application

↓

Domain

↓

Data

Never reverse.

The scheduler shall never import Flutter widgets.

22. Testing Strategy

Unit Tests

Scheduler
Conflict Engine
Auto Planner
Validation

Widget Tests

Timeline
Task Card
Break Card

Integration Tests

Drag
Resize
Auto Plan
Persistence
23. Migration Rule (Very Important)

The Flutter implementation must preserve:

Scheduling behavior
Conflict resolution behavior
Auto Planner behavior
Timeline interaction
Drag logic
Resize logic
Data persistence
Theme behavior

The UI implementation may differ internally, but observable behavior must remain functionally equivalent to the original application.