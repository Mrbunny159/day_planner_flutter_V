Algorithm Specification Document (ASD)
Day Planner v2.0

Version 1.0

Purpose

This document defines the exact behavior of every scheduling algorithm.

The objective is to ensure that every implementation (Flutter, Web, Desktop, etc.) produces identical scheduling behavior.

Algorithms defined here are the single source of truth.

Algorithm 1
Find Next Free Slot
Purpose

Determine the earliest available position where a task may be inserted.

Inputs
duration

optionalStartMinute

direction
Output
startMinute
endMinute
Process
IF optionalStartMinute exists

↓

Use optionalStartMinute

ELSE

↓

Current System Time

↓

Round Up To Nearest 15 Minutes

Begin search

Current Position

↓

Check Timeline Boundary

↓

Check Break Conflict

↓

Check Task Conflict

↓

VALID ?

↓

YES

↓

Return Position

↓

NO

↓

+15 Minutes

↓

Repeat
Rules

Search order

Chronological.

Granularity

15 minutes.

Stops

First valid slot.

Breaks have priority.

Existing tasks have priority.

Algorithm 2
Task Conflict Detection

Two tasks conflict when

TaskA.start

<

TaskB.end

AND

TaskA.end

>

TaskB.start

Otherwise

No conflict.

Algorithm 3
Break Conflict

Input

Task

Break

Condition

TaskStart

<

BreakEnd

AND

TaskEnd

>

BreakStart

Result

Conflict.

The task must relocate.

The break remains unchanged.

Algorithm 4
Scheduler Validation Pipeline

Every scheduling operation executes the same pipeline.

Receive Planner

↓

Normalize

↓

Snap Grid

↓

Boundary Check

↓

Break Check

↓

Task Check

↓

Resolve Conflicts

↓

Validate Again

↓

Return Planner

No operation bypasses this pipeline.

Algorithm 5
Grid Snap

Input

Minute

Output

Nearest 15-minute value.

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

Grid snapping occurs

Drag
Resize
Creation
Editing
Auto Planner
Algorithm 6
Create Task

User presses

Add

↓

Enter Data

↓

Validate

↓

Find Next Free Slot

↓

Insert Task

↓

Resolve Conflicts

↓

Save Planner

↓

Refresh UI

Algorithm 7
Edit Task

User edits

↓

Validate

↓

Update Properties

↓

Scheduler Validation Pipeline

↓

Save

↓

Refresh

Algorithm 8
Resize Task

User drags resize handle

↓

Calculate New Duration

↓

Snap Duration

↓

Minimum Duration Check

↓

Boundary Check

↓

Conflict Resolution

↓

Save

↓

Refresh

Algorithm 9
Drag Task

Pointer Down

↓

Select Task

↓

Track Cursor

↓

Convert Pixel → Minute

↓

Snap

↓

Temporary Position

↓

Release

↓

Validate

↓

Resolve Conflicts

↓

Save

Algorithm 10
Push Forward Conflict Resolution

Input

Moved Task

↓

Sort Remaining Tasks

↓

Check First Conflict

↓

Conflict?

↓

YES

↓

Move Conflicting Task

↓

Check Next Task

↓

Conflict?

↓

YES

↓

Repeat

↓

Planner Valid

This algorithm never moves the initiating task after placement.

Only subsequent conflicting tasks are displaced.

Algorithm 11
Break Avoidance

Whenever a task intersects a break

Task

↓

Break

↓

Conflict

↓

Search Next Available Slot

↓

Insert

↓

Continue Validation

Breaks are never moved.

Algorithm 12
Ensure Timeline Boundary

Input

Task

↓

Check

End > 24 Hours

↓

Wrap

OR

Start < 0

↓

Wrap

↓

Return Valid Position

Algorithm 13
Midnight Wrap

Example

23:45

↓

00:00

Example

00:00

↓

23:45

Duration remains unchanged.

Algorithm 14
Auto Planner

Input

Planner

↓

Determine Current Time

↓

Split Tasks

Completed

Incomplete

↓

Completed

Remain

↓

Incomplete

Remove

↓

Sort

↓

Find Free Slot

↓

Insert

↓

Avoid Breaks

↓

Avoid Conflicts

↓

Repeat Until Empty

↓

Save

↓

Refresh

Algorithm 15
Completion Toggle

Checkbox

↓

Toggle State

↓

Update Task

↓

Save

↓

Refresh Summary

Algorithm 16
Delete Task

Delete

↓

Remove Task

↓

Save

↓

Refresh

Algorithm 17
Delete All Completed

Planner

↓

Find Completed

↓

Delete

↓

Save

↓

Refresh

Algorithm 18
Undo Delete

Ctrl+Z

↓

Restore Previous Object

↓

Validate

↓

Save

↓

Refresh

Algorithm 19
Theme Update

Settings

↓

Apply Theme

↓

Update Colors

↓

Update Timeline

↓

Update Blocks

↓

Save

Algorithm 20
Summary Calculation

Planner

↓

Working Hours

↓

Calculate

Completed Minutes

↓

Calculate

Break Minutes

↓

Calculate

Free Minutes

↓

Display

Algorithm 21
Planner Startup

Application Launch

↓

Load Settings

↓

Load Planner

↓

Restore Tasks

↓

Restore Breaks

↓

Restore Theme

↓

Validate Planner

↓

Render Timeline

↓

Center On Current Time

Algorithm 22
Planner Save

Any Planner Mutation

↓

Serialize Models

↓

Write Storage

↓

Update UI

No explicit save button exists.

Algorithm Priorities

The scheduler must always obey the following priority order:

Timeline Boundary

↓

Break Blocks

↓

Existing Scheduled Tasks

↓

Task Being Modified

↓

Visual Refresh

A higher-priority rule may never be violated to satisfy a lower-priority rule.

Deterministic Behavior

Given the same:

Tasks
Breaks
Settings
Current time
User action

the scheduler must always produce the exact same planner state.

Randomized scheduling behavior is prohibited.

Migration Requirement

Any Flutter implementation must preserve:

Placement order
Conflict resolution order
Auto Planner sequencing
Grid snapping
Boundary handling
Break precedence
Validation sequence
Planner normalization

Observable behavior takes precedence over internal implementation details.