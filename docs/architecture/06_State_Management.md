State Management Specification (SMS)
Day Planner v2.0

Version: 1.0

Framework

Flutter

State Management

Riverpod

Architecture

Reactive

Single Direction Data Flow

1. Purpose

This document defines:

Ownership of every state
State lifecycle
Provider hierarchy
Rebuild strategy
Dependency rules
Communication rules

The objective is to eliminate duplicated state.

2. Principles

The application follows these principles.

Single Source of Truth

Every piece of data has exactly one owner.

Immutable Models

Models are never modified directly.

Changes always create a new model.

Unidirectional Data Flow
User

↓

Provider

↓

Scheduler

↓

Repository

↓

SQLite

↓

Provider

↓

UI

Widgets never bypass providers.

Separation of State

Business State

↓

UI State

↓

Temporary State

must never mix.

3. Provider Hierarchy
AppProvider

│

├── PlannerProvider
│
├── SchedulerProvider
│
├── ThemeProvider
│
├── SettingsProvider
│
├── TimelineProvider
│
├── SummaryProvider
│
├── CurrentTimeProvider
│
├── SelectionProvider
│
├── DragProvider
│
├── ResizeProvider
│
└── DialogProvider

Every provider has one responsibility.

4. Planner Provider
Owner

Entire planner.

Contains

Planner

↓

Tasks

↓

Breaks

Responsibilities

Create Task
Edit Task
Delete Task
Restore Task
Save Planner
Load Planner

PlannerProvider never draws UI.

5. Scheduler Provider

Owns

Scheduler Engine

Responsible for

Auto Plan
Conflict Resolution
Free Slot Search
Timeline Validation
Break Avoidance
Grid Snap

SchedulerProvider owns no UI state.

6. Theme Provider

Owns

Theme

Colors

Typography

Updates

Task Colors
Break Colors
Background
Fonts

Changing theme rebuilds only visual widgets.

7. Settings Provider

Owns

Working Hours

Time Font Size

Bold

Theme Selection

Changing settings shall never rebuild scheduler logic.

8. Timeline Provider

Owns

Scroll Position

Visible Range

Minute ↔ Pixel Conversion

Responsibilities

Timeline calculations
Auto-centering
Visible viewport
9. Summary Provider

Owns

Completed Minutes

Break Minutes

Free Minutes

Generated from Planner.

Never edited directly.

10. Current Time Provider

Owns

Current Time

Current Minute

Updates

Every minute.

Only widgets depending on current time rebuild.

11. Selection Provider

Owns

Selected Task

Selected Break

Responsibilities

Selection
Deselection
Context Menu Target

Selection is never stored permanently.

12. Drag Provider

Temporary state only.

Owns

Dragging

Dragged Block

Pointer Position

Preview Position

Destroyed immediately after drag ends.

Never persisted.

13. Resize Provider

Owns

Currently Resizing

Resize Preview

Current Height

Destroyed after resize completes.

14. Dialog Provider

Owns

Current Dialog

Dialog Parameters

Dialog Result

Never stores planner data.

15. Provider Dependencies
Planner

↓

Summary

↓

Timeline

↓

Widgets

Scheduler

↓

Planner

Theme

↓

Widgets

Settings

↓

Theme

Current Time

↓

Timeline

No circular dependencies allowed.

16. Widget Rebuild Rules

Dragging Task

Rebuild

Task Widget

Timeline Layer

Only.

Theme Change

Rebuild

Entire UI

Scheduler remains untouched.

Task Complete

Rebuild

Task

Summary

Only.

Current Time Update

Rebuild

Current Time Line

Past Breaks

Only.

17. Event Flow

Task Creation

Button

↓

PlannerProvider

↓

SchedulerProvider

↓

Repository

↓

PlannerProvider

↓

UI

Task Drag

Pointer

↓

DragProvider

↓

Scheduler

↓

Planner

↓

Repository

↓

UI

Theme Change

Settings

↓

ThemeProvider

↓

Widgets
18. Runtime State

Never persist

Dragging

Selection

Hovered Block

Current Dialog

Animations

Temporary Preview

Scroll Position
19. Persistent State

Persist

Tasks

Breaks

Settings

Theme

Working Hours

Color Tags

Completion

Recurring

Durations
20. State Ownership Matrix
State	Owner
Tasks	PlannerProvider
Breaks	PlannerProvider
Scheduler	SchedulerProvider
Current Time	CurrentTimeProvider
Theme	ThemeProvider
Summary	SummaryProvider
Selection	SelectionProvider
Dragging	DragProvider
Resize	ResizeProvider
Dialogs	DialogProvider
Timeline Position	TimelineProvider
Settings	SettingsProvider

Every state appears exactly once.

21. Communication Rules

Providers communicate only through:

Method calls
Immutable models
Events

Never through widget references.

22. Provider Lifetime
Provider	Lifetime
Planner	Entire App
Scheduler	Entire App
Theme	Entire App
Settings	Entire App
Timeline	Entire App
Current Time	Entire App
Summary	Entire App
Selection	Temporary
Drag	Temporary
Resize	Temporary
Dialog	Temporary
23. Error Recovery

If Scheduler fails

↓

Planner remains unchanged.

If Repository fails

↓

Planner remains in memory.

If Theme fails

↓

Fallback to previous theme.

24. Performance Rules

Dragging a task shall not rebuild:

Theme
Settings
Summary
Other tasks that are unaffected
Dialogs

Only the affected widgets should rebuild.

25. Golden Rule

The Scheduler never owns data.

The Planner owns the data.

The Scheduler transforms the data.

This distinction is extremely important.

State Management Complete