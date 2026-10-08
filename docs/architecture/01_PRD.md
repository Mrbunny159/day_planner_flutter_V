Product Requirements Document (PRD)
Project Name

Day Planner

Version: 2.0 (Flutter Migration)

Status: Draft

Platform:

Android
iOS
Windows
macOS
Linux

Document Purpose

This document defines the complete functional requirements of the Day Planner application. It serves as the single source of truth for recreating the existing desktop application in Flutter without changing, removing, or introducing any functionality.

The objective is feature parity with the existing application.

1. Product Overview
1.1 Summary

Day Planner is a timeline-based productivity application that allows users to visually schedule their day by placing tasks and breaks onto a 24-hour timeline.

Unlike traditional todo applications, Day Planner combines scheduling, automatic planning, conflict management, recurring tasks, and visual timeline interaction into one application.

The application is designed around direct manipulation of scheduled blocks instead of list-based task management.

1.2 Objectives

The application shall:

Allow users to plan an entire day visually.
Automatically organize tasks.
Prevent scheduling conflicts.
Display the current time.
Track completed tasks.
Persist all data locally.
Operate completely offline.
Require no account or internet connection.
1.3 Product Philosophy

The application prioritizes:

Speed
Simplicity
Direct manipulation
Visual planning
Zero unnecessary screens
Minimal user interaction for common actions

Every interaction should require as few clicks as possible.

2. Target Users

The application is intended for users who:

Plan their daily schedule.
Prefer visual timelines.
Use time blocking.
Need recurring schedules.
Want an offline planner.
Prefer drag-and-drop interaction.
3. Platforms

The application shall support:

Android
iOS
Windows
macOS
Linux

The application shall behave consistently across all supported platforms.

4. Core Concepts

The application consists of five primary entities.

4.1 Timeline

The timeline represents one complete day.

Properties:

Starts at 12:00 AM.
Ends at 12:00 AM of the following day.
Total duration is 24 hours.
Timeline is vertically scrollable.
Every minute corresponds to a measurable position.
Every hour is displayed.
Every half-hour is displayed using lighter separators.

The timeline is the central interaction surface.

4.2 Task Block

A task block represents scheduled work.

Each task contains:

Name
Start Time
Duration
Completion Status
Color Tag
Repeat Status

Tasks are displayed as rounded rectangular blocks positioned according to their scheduled time.

Tasks may be:

created
edited
deleted
resized
dragged
marked complete
marked incomplete
4.3 Break Block

Breaks reserve time.

Unlike tasks, breaks:

cannot be completed
cannot contain checkboxes
prevent tasks from occupying their duration
participate in scheduling calculations
4.4 Scheduler

The scheduler manages:

automatic placement
overlap detection
conflict resolution
task movement
break avoidance

Users never manually resolve scheduling conflicts.

The scheduler is responsible for maintaining a valid schedule.

4.5 Settings

The application stores user preferences including:

Theme
Colors
Timeline preferences
Font configuration
Working day configuration

Settings persist across application launches.

5. Functional Requirements
Module A
Timeline
FR-001

Display a full 24-hour timeline.

Acceptance Criteria

Timeline contains 24 hours.
Timeline begins at 12:00 AM.
Timeline ends at 12:00 AM.
Timeline scrolls vertically.
Hours remain aligned.
FR-002

Display hour separators.

Acceptance Criteria

Every hour contains a separator line.
Every hour displays its label.
FR-003

Display half-hour separators.

Acceptance Criteria

Every 30 minutes contains a lighter separator.
FR-004

Display the current time indicator.

Acceptance Criteria

Horizontal line displayed.
Line updates automatically.
Current time badge displayed.
Badge moves with time.
Indicator always reflects system time.
FR-005

Center timeline on current time during startup.

Acceptance Criteria

Initial view scrolls near current time.
User may scroll freely afterward.
Module B
Task Creation
FR-006

Create task.

User presses:

Add

System displays Task Dialog.

User enters:

Task Name
Duration
Repeat Option

System creates task.

FR-007

Support multiple task creation.

If multiple lines are entered,

each line becomes a separate task.

Acceptance Criteria

Study
Gym
Reading

Creates

Task 1

Task 2

Task 3

FR-008

Ignore empty task names.

Blank lines shall not create tasks.

FR-009

Automatically place tasks.

The scheduler automatically determines the next available location.

The user does not manually position newly created tasks.

FR-010

Task duration options

Supported durations:

15 min
30 min
45 min
60 min
90 min
120 min
150 min
180 min

Only predefined durations are selectable.

FR-011

Task repeat options

Supported values:

None
Daily
FR-012

Each created task shall contain:

Name
Start Time
Duration
Completion Status
Repeat Status
Color Tag
Module C
Break Creation
FR-013

Users may create break blocks.

Breaks reserve time.

FR-014

Breaks require:

Name
Start Time
Duration
Repeat Option
FR-015

Breaks do not display completion checkboxes.

FR-016

Breaks prevent task placement.

Tasks shall never overlap a break.

FR-017 Edit Task

The user shall be able to edit any existing task.

Editing is available through:

Double-clicking the task block.
Selecting Edit from the context menu.

The edit dialog shall preload the existing task information.

Editable fields:

Task Name
Duration
Task Type
Repeat Option
FR-018 Save Edited Task

When the user confirms changes:

The application shall:

Validate the input.
Update the task.
Recalculate its schedule if necessary.
Resolve any conflicts.
Refresh the timeline.
Persist changes immediately.
FR-019 Cancel Editing

If the user cancels:

No changes shall be applied.
Timeline remains unchanged.
FR-020 Rename Task

The task name may contain:

Letters
Numbers
Symbols
Multiple words

The application shall preserve formatting exactly as entered.

FR-021 Change Duration

Users may change the task duration.

Changing duration shall immediately trigger:

Timeline recalculation
Conflict resolution
UI refresh
Data save
FR-022 Change Repeat Status

Users may switch between:

None
Daily

Changes are applied immediately after saving.

Module E
Break Editing
FR-023 Edit Break

Breaks shall support editing.

Editable fields:

Name
Duration
Start Time
Repeat Status
FR-024 Save Break

After editing:

The application shall:

Update the break
Resolve scheduling conflicts
Refresh UI
Save data
FR-025 Cancel Break Editing

Cancelling editing shall discard all changes.

Module F
Drag and Drop
FR-026 Drag Task

Users shall drag a task by clicking anywhere except the resize handle.

Dragging updates the task position in real time.

FR-027 Snap to Grid

While dragging:

Tasks shall always align to a 15-minute grid.

Example

09:07 ❌

09:15 ✅

09:30 ✅

09:45 ✅

No arbitrary minute placement is allowed.

FR-028 Real-Time Preview

During dragging:

The task block shall move continuously with the cursor while remaining snapped to the nearest 15-minute interval.

FR-029 Timeline Update

Upon release:

The task becomes permanently positioned at the dropped location.

FR-030 Automatic Save

Dropping a task automatically saves the schedule.

No manual save button exists.

Module G
Task Resizing
FR-031 Resize Handle

Every task displays a resize handle.

The resize handle appears along the bottom edge.

FR-032 Resize Task

Dragging the resize handle changes task duration.

FR-033 Minimum Duration

A task cannot become shorter than:

15 minutes

FR-034 Snap Duration

Duration changes shall always snap to:

15-minute increments.

FR-035 Automatic Save

Resizing automatically saves the planner.

FR-036 Conflict Handling

If increasing duration causes overlap:

The scheduler shall automatically resolve conflicts.

The user is never asked to manually fix overlaps.

Module H
Scheduler
FR-037 Automatic Placement

New tasks are automatically inserted into the next available free slot.

FR-038 Free Slot Search

The scheduler searches the timeline in chronological order.

The first available valid location is selected.

FR-039 Break Awareness

The scheduler shall never place tasks inside break blocks.

FR-040 Existing Task Awareness

The scheduler shall avoid collisions with existing tasks.

FR-041 Timeline Boundaries

Tasks shall never exist outside the 24-hour timeline.

FR-042 Wrap Around

If movement exceeds midnight:

The scheduler wraps the task appropriately while preserving duration.

FR-043 Scheduler Consistency

After every scheduling operation:

The timeline must remain valid.

No overlapping tasks may exist.

Module I
Conflict Resolution
FR-044 Detect Overlap

Whenever a task changes:

The scheduler shall detect overlaps.

FR-045 Resolve Overlap

Conflicting tasks are automatically repositioned.

FR-046 Cascading Resolution

Moving one task may move multiple subsequent tasks.

The scheduler continues until all conflicts are resolved.

FR-047 Preserve Order

Conflict resolution shall preserve chronological ordering whenever possible.

FR-048 Break Priority

Breaks cannot be displaced.

Tasks always move around breaks.

FR-049 Visual Feedback

Automatically moved tasks shall briefly display a conflict animation to indicate repositioning.

Module J
Completion System
FR-050 Complete Task

Tasks include a completion checkbox.

Users may mark tasks complete.

FR-051 Completed Appearance

Completed tasks become visually faded.

Their schedule remains unchanged.

FR-052 Incomplete Task

Users may restore completed tasks.

FR-053 Persist Completion

Completion state is permanently saved.

FR-054 Break Behaviour

Breaks never support completion.

Module K
Current Time Behavior
FR-055 Current Time Indicator

A horizontal indicator continuously represents system time.

FR-056 Automatic Updates

The current time updates automatically without user interaction.

FR-057 Past Breaks

Breaks that have already ended become visually faded.

FR-058 Future Breaks

Future breaks retain normal appearance.

FR-059 Current Task

Tasks do not automatically become completed.

Completion is always controlled by the user.

Part 3
Module L
Auto Planner

The Auto Planner is responsible for intelligently reorganizing incomplete tasks based on the current system time while preserving completed work and respecting scheduling rules.

FR-060 Auto Plan Action

The application shall provide an Auto Plan button.

Selecting this button initiates automatic schedule optimization.

FR-061 Determine Current Time

The Auto Planner shall use the current system time as the reference point.

All scheduling decisions are based on the current moment.

FR-062 Preserve Completed Tasks

Completed tasks shall never become incomplete.

Completion status remains unchanged after auto planning.

FR-063 Move Completed Tasks

Completed tasks that are scheduled after the current time shall be relocated before the current time whenever possible.

FR-064 Preserve Historical Tasks

Completed tasks that already occurred before the current time shall remain in place.

FR-065 Reposition Incomplete Tasks

All incomplete tasks shall be removed from the current schedule and reinserted using the scheduling engine.

FR-066 Chronological Scheduling

Incomplete tasks shall be inserted sequentially beginning after the current time.

FR-067 Break Awareness

The Auto Planner shall never place tasks inside break blocks.

FR-068 Conflict Awareness

The Auto Planner shall prevent task overlaps.

FR-069 Schedule Completion

After Auto Planning:

Timeline shall be valid.
No overlapping tasks shall exist.
Breaks remain fixed.
All tasks remain scheduled.
FR-070 Automatic Save

Auto Planning automatically saves the updated schedule.

Module M
Context Menu

Users may interact with task blocks through a context menu.

FR-071 Open Context Menu

Right-clicking a task shall display its context menu.

FR-072 Incomplete Task Menu

Incomplete tasks shall provide:

Mark Complete
Edit
Delete
Set Color Tag
FR-073 Completed Task Menu

Completed tasks shall provide:

Mark Incomplete
Delete
Delete All Completed
FR-074 Break Context Menu

Break blocks shall provide:

Edit
Delete
FR-075 Context Menu Scope

Menu options shall only affect the selected block.

Module N
Delete Operations
FR-076 Delete Task

Users may permanently delete any task.

Deletion removes the task immediately.

FR-077 Delete Break

Users may permanently delete any break.

FR-078 Delete Completed Tasks

Users may delete all completed tasks simultaneously.

Incomplete tasks remain unaffected.

FR-079 Delete Selection

The Delete button removes the currently selected block.

FR-080 Clear All

The application shall provide a Clear All function.

FR-081 Confirmation

Clear All shall require confirmation before execution.

FR-082 Clear Behaviour

After confirmation:

All tasks removed.
All breaks removed.
Timeline reset.
Data saved.
Module O
Undo
FR-083 Undo Delete

The application shall support undoing the most recent deletion.

FR-084 Keyboard Shortcut

Undo shall be accessible using:

Ctrl + Z
FR-085 Restore Deleted Items

Undo restores:

Position
Duration
Name
Status
Color
Repeat Setting
FR-086 Save After Undo

Undo automatically updates persistent storage.

Module P
Color Tags
FR-087 Assign Color

Tasks may receive an optional color tag.

FR-088 Supported Colors

Supported values include:

None
Blue
Green
Orange
Red
FR-089 Display

Assigned colors override the default task appearance.

FR-090 Persistence

Assigned colors remain after restarting the application.

Module Q
Daily Summary
FR-091 Summary Display

The application shall display a daily summary.

FR-092 Summary Metrics

The summary includes:

Completed Work
Available Free Time
FR-093 Working Hours

Summary calculations use the configured workday.

FR-094 Automatic Updates

Summary refreshes whenever:

Tasks change.
Breaks change.
Completion changes.
Settings change.
Module R
Theme System
FR-095 Theme Selection

Users may switch between predefined themes.

FR-096 Theme Persistence

Selected theme remains active after restarting.

FR-097 Theme Components

Themes define:

Background
Task Colors
Task Borders
Break Colors
Break Borders
FR-098 Immediate Application

Changing the theme updates the entire interface immediately.

Module S
Custom Colors
FR-099 Manual Color Customization

Users may manually customize planner colors.

FR-100 Configurable Colors

Users may configure:

Task Fill
Task Border
Break Fill
Break Border
FR-101 Live Preview

Color changes appear immediately.

FR-102 Persistence

Custom colors are permanently saved.

Module T
Timeline Settings
FR-103 Working Day Start

Users may configure the beginning of the workday.

FR-104 Working Day End

Users may configure the end of the workday.

FR-105 Summary Integration

Daily summaries shall respect configured working hours.

Module U
Typography
FR-106 Time Font Size

Users may configure the displayed time font size.

FR-107 Font Weight

Users may toggle bold time labels.

FR-108 Immediate Refresh

Typography changes update all visible task blocks immediately.

Module V
Application Behavior
FR-109 Offline Operation

The application shall function without internet connectivity.

FR-110 Local Storage

All information is stored locally.

No cloud services are required.

FR-111 Automatic Persistence

The application automatically saves changes.

There is no manual Save button.

FR-112 Immediate UI Refresh

Every successful operation refreshes the timeline immediately.

FR-113 Data Consistency

The application shall always maintain a valid schedule.

No user action shall leave the planner in an inconsistent state.
Module W
Recurring Tasks

Recurring tasks are tasks or breaks that repeat automatically based on their recurrence configuration.

FR-114 Recurrence Options

The application shall support the following recurrence options:

None
Daily

No additional recurrence patterns are supported.

FR-115 Daily Recurrence

Daily recurring tasks retain their recurrence setting across application launches.

FR-116 Daily Recurring Breaks

Breaks may also be configured as daily recurring items.

FR-117 Visual Indicator

Recurring items shall display a dedicated recurrence indicator.

This indicator shall remain visible regardless of completion status.

FR-118 Editing Recurrence

Users may modify the recurrence configuration during task or break editing.

Module X
Local Data Storage
FR-119 Local Persistence

The application shall store all planner data locally.

No account or authentication is required.

FR-120 Automatically Saved Data

The following information shall persist:

Tasks
Breaks
Completion status
Start time
Duration
Color tags
Recurrence
Theme
Custom colors
Working hours
Typography settings
FR-121 Automatic Save Trigger

The application automatically saves whenever:

Task created
Task edited
Task deleted
Break created
Break edited
Break deleted
Task completed
Task restored
Task resized
Task moved
Auto Planner executed
Theme changed
Settings changed
FR-122 Startup Restore

Upon application launch, the previously saved planner shall be restored automatically.

Module Y
Validation Rules
FR-123 Task Name Validation

Task names may contain any printable characters.

Blank names shall default to Untitled.

FR-124 Empty Input

Empty lines entered during multiple task creation shall be ignored.

FR-125 Duration Validation

Only predefined duration values are accepted.

Invalid durations shall not be saved.

FR-126 Timeline Boundary Validation

Tasks shall never exist outside the 24-hour timeline.

FR-127 Schedule Validation

The scheduler shall maintain:

No overlapping tasks
No task inside a break
Valid chronological ordering
FR-128 Break Validation

Breaks reserve timeline space and cannot be occupied by tasks.

Module Z
Error Handling
FR-129 Invalid Schedule

If an operation would create an invalid schedule, the scheduler shall automatically resolve the issue whenever possible.

FR-130 Save Failure

If data cannot be saved, the application shall preserve the in-memory planner state and prevent application crashes.

FR-131 Invalid Settings

Invalid settings values shall fall back to application defaults.

FR-132 Startup Recovery

If saved planner data is unavailable or corrupted, the application shall initialize with default settings rather than terminating unexpectedly.

Module AA
Edge Cases
FR-133 Midnight Wrapping

Tasks moved beyond the end of the day shall wrap according to the scheduler's timeline rules.

FR-134 Minimum Duration

Tasks cannot be resized below the minimum supported duration.

FR-135 Large Numbers of Tasks

The application shall remain fully functional with large daily schedules.

FR-136 Empty Planner

The application shall function correctly when no tasks or breaks exist.

FR-137 Only Breaks

The application shall support schedules containing only break blocks.

FR-138 Only Tasks

The application shall support schedules containing only task blocks.

FR-139 Consecutive Breaks

Multiple adjacent break blocks shall be supported.

FR-140 Consecutive Tasks

Multiple adjacent task blocks shall be supported.

Module AB
Non-Functional Requirements
NFR-001 Performance

Common planner operations should feel instantaneous under normal workloads.

NFR-002 Startup Time

The application should restore the previous planner state quickly after launch.

NFR-003 Responsiveness

User interactions should update the interface immediately without noticeable delay.

NFR-004 Offline First

The application must operate entirely without internet access.

NFR-005 Cross Platform

The application shall provide equivalent functionality on:

Android
iOS
Windows
macOS
Linux
NFR-006 Reliability

The application should avoid data loss during normal operation.

NFR-007 Consistency

All planner interactions shall follow consistent behavior across every supported platform.

NFR-008 Local Privacy

User data remains on the user's device.

The application shall not require user accounts or cloud synchronization.

Acceptance Criteria

The migration shall be considered complete only when:

Every feature from the original application is implemented.
No original functionality has been removed.
Existing planner behavior is preserved.
Scheduler behavior matches the original implementation.
Auto Planner behavior matches the original implementation.
Conflict resolution matches the original implementation.
Timeline interactions match the original implementation.
Editing behavior matches the original implementation.
Theme behavior matches the original implementation.
Settings behavior matches the original implementation.
Local persistence matches the original implementation.
User workflows remain unchanged.
The application behaves consistently across all supported platforms.
Out of Scope

The following are not part of this version unless they already exist in the original application:

User accounts
Cloud synchronization
Online collaboration
Calendar integration
Notifications
Widgets
AI scheduling
Voice commands
Multi-device synchronization
Export or import functionality
Authentication
Background services
Analytics
Subscription features
Product Constraints

The migration must satisfy the following constraints:

The application shall preserve all existing functionality.
No new features shall be introduced.
No existing features shall be removed.
Existing scheduling behavior shall remain unchanged.
Existing user workflows shall remain unchanged.
The migration shall focus solely on translating the application from PyQt to Flutter while maintaining functional equivalence.

End of PRD v1.0