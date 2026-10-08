Component Specification (CS)
Day Planner v2.0

Version 1.0

Framework

Flutter

Architecture

Atomic Component Architecture

1. Purpose

This document defines every UI component.

For every component it specifies:

Responsibility
Parent
Children
Inputs
Outputs
State Ownership
Dependencies
Events

Components must remain reusable.

Business logic is prohibited inside UI components.

2. Component Hierarchy
App

└── PlannerScreen

    ├── Timeline
    │
    │── HourMarkers
    │── HalfHourMarkers
    │── CurrentTimeIndicator
    │── TaskLayer
    │── BreakLayer
    │── TimelineGrid
    │
    ├── SummaryBar
    │
    ├── BottomToolbar
    │
    ├── DialogLayer
    │
    └── ContextMenuLayer
3. PlannerScreen

Purpose

Main application workspace.

Children

Timeline

SummaryBar

Toolbar

Dialogs

Dependencies

PlannerProvider

ThemeProvider

CurrentTimeProvider

Owns

Nothing.

4. Timeline Widget

Purpose

Displays the complete planner.

Children

HourMarkers

TaskLayer

BreakLayer

CurrentTimeIndicator

Inputs

Planner

Settings

Outputs

None.

Never owns planner state.

5. HourMarker

Purpose

Display hour labels.

Example

8 AM

9 AM

10 AM

State

Stateless.

6. HalfHourMarker

Purpose

Draw visual separator.

State

Stateless.

7. CurrentTimeIndicator

Purpose

Display current time.

Contains

Line

Time Pill

Input

CurrentMinute

Updates

Every minute.

No interaction.

8. TaskLayer

Purpose

Render every task.

Input

List<Task>

Children

TaskCard

No scheduling logic.

9. BreakLayer

Purpose

Render every break.

Input

List<Break>

Children

BreakCard
10. TaskCard

Most important widget.

Purpose

Visual representation of one task.

Input

Task

Displays

Title

Time

Duration

Checkbox

Recurring Badge

Color Tag

Callbacks

onDrag()

onResize()

onTap()

onDoubleTap()

onLongPress()

onCheckbox()

Never modifies data directly.

11. BreakCard

Similar to TaskCard.

Differences

No checkbox.

No completion.

Still draggable.

Still resizable.

12. ResizeHandle

Purpose

Resize interaction.

Attached to

TaskCard

Callbacks

onResizeStart()

onResize()

onResizeEnd()

Temporary state only.

13. SummaryBar

Displays

Completed

Free Time

Input

Summary

Read-only.

14. BottomToolbar

Contains

Add

Delete

Auto Plan

Clear

Settings

Callbacks only.

No logic.

15. Add Task Dialog

Contains

Task Name

Duration

Repeat

Task Type

Buttons

Outputs

TaskDraft

Does not create tasks.

16. Settings Dialog

Contains

Theme

Colors

Working Hours

Font Size

Bold Toggle

Outputs

Updated Settings.

17. Confirmation Dialog

Purpose

Delete confirmation.

Buttons

Yes

No

Generic component.

Reusable.

18. Context Menu

Task

Complete

Edit

Delete

Color Tag

Completed Task

Incomplete

Delete

Delete Completed

Break

Edit

Delete
19. Color Picker

Purpose

Choose custom colors.

Returns

Color.

20. Timeline Grid

Purpose

Draw

Hour lines

Half-hour lines

No interaction.

21. Scroll Controller

Purpose

Control

Timeline scrolling.

Center on current time.

Never owns planner state.

22. Drag Controller

Purpose

Translate pointer movement.

Calls

Scheduler.

Does not update models.

23. Resize Controller

Purpose

Translate resize gestures.

Calls

Scheduler.

No persistence.

24. Component Dependencies
PlannerScreen

↓

Timeline

↓

TaskLayer

↓

TaskCard

↓

ResizeHandle

No upward dependency.

25. Rebuild Rules

Dragging

Rebuild

TaskCard

Timeline

Only.

Theme Change

Rebuild

Entire Widget Tree.

Current Time

Rebuild

CurrentTimeIndicator

Only.

Summary

Rebuild

SummaryBar

Only.

26. Widget Communication

Allowed

Callbacks

Providers

Riverpod

Forbidden

Global Variables

Widget References

Static State
27. Animation Ownership

TaskCard

Owns

Selection Animation

Hover Animation

Conflict Flash

Timeline

Owns

Current Time Movement

Dialogs

Own

Fade

Scale

28. Stateless vs Stateful

Stateless

HourMarker

HalfHourMarker

TimelineGrid

SummaryBar

Stateful

Timeline

TaskCard

BreakCard

Dialogs
29. Component Size Rules

TaskCard

Height

Dynamic

Width

Fixed

Timeline

Infinite Vertical

Fixed Horizontal

Toolbar

Fixed Height

Summary

Fixed Height

30. Golden Rule

Components only display information.

Providers own state.

Scheduler owns algorithms.

Repositories own storage.

Components never break this separation.

Component Specification Complete