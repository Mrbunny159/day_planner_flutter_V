Day Planner v2.0
Project Constitution
Mission

Rebuild the existing PyQt Day Planner application in Flutter while preserving 100% functional equivalence.

This is a migration project, not a redesign.

Primary Objective

The Flutter application shall reproduce the observable behavior of the existing Python application.

Behavioral compatibility takes priority over implementation similarity.

Project Principles
Principle 1

No feature additions.

Principle 2

No feature removals.

Principle 3

No workflow changes.

Principle 4

No scheduler simplification.

Principle 5

Offline First.

Principle 6

Local storage only.

Principle 7

Single source of truth.

Architecture
Clean Architecture
Repository Pattern
Riverpod
SQLite
Immutable Models
Scheduler Rules

The scheduler is the heart of the application.

Its behavior shall remain identical to the original implementation.

Priority Order

Timeline

↓

Breaks

↓

Existing Tasks

↓

New Task

↓

UI Refresh
State Rules

Business State

↓

Providers

↓

UI

Never

UI

↓

Business Logic

Component Rules

Widgets never

save data
resolve conflicts
schedule tasks
access SQLite

Widgets only render data.

Development Rules

Always read:

PRD
TRD
SSD
ASD

before implementing features.

AI Rules

When implementing:

Never invent functionality.
Never optimize behavior unless requested.
Never remove edge cases.
Ask for clarification if documentation conflicts.
Definition of Done

A feature is complete only if:

Functional behavior matches the original.
Scheduler behaves identically.
UI updates correctly.
State remains consistent.
Tests pass.
2. Design System Specification (DSS)

This keeps the app visually consistent.

Grid System

Use an 8-point spacing system.

Allowed spacing:

4
8
16
24
32
40
48
64

No arbitrary spacing values.

Border Radius

Small

8 px

Medium

12 px

Large

16 px

Task Cards

12 px

Dialogs

16 px

Buttons

12 px
Typography

Use only four sizes.

12

14

16

20

Weights

Regular

Medium

Bold
Icon Sizes
16

20

24

32
Button Heights

Small

36

Normal

48

Large

56
Timeline

Hour Height

One hour should occupy a constant height.

15-minute blocks should align perfectly.

Hour labels always remain left aligned.

Task Card

Contains

Title

Time

Checkbox

Duration

Recurring Badge

Layout should remain consistent.

Color Tokens

Instead of hardcoded colors

Use

Primary

Secondary

Background

Surface

Task

Break

Border

Success

Warning

Danger

Every widget references tokens.

Shadows

Only two elevations.

Low

High

No random shadow values.

Animations

Standard Duration

150 ms

Long

300 ms

Current Time

Linear.

Dialogs

Ease.

Selection

Ease Out.

Touch Targets

Minimum

48 × 48
Scroll

Use native scrolling.

No custom physics unless necessary.

Dialog Width

Desktop

Maximum

500 px

Mobile

90% screen width.

Consistency Rules

Every screen must use

same radius
same spacing
same typography
same shadows
same animations
3. Coding Standards

This will massively improve AI-generated code.

File Structure

One class per file.

One widget per file.

Widget Size

Maximum

250 lines

If exceeded

Split widget.

Method Size

Maximum

40 lines
Class Size

Prefer

<300 lines

Scheduler excluded.

Naming

Widgets

TaskCard

Providers

PlannerProvider

Repositories

PlannerRepository

Services

PlannerService

Private variables

_taskList

Constants

kToolbarHeight
Comments

Write comments only to explain why, not what.

Good:

// Breaks have higher scheduling priority than tasks.

Bad:

// Adds one to x.
Constants

Never hardcode values.

Instead:

AppSpacing.medium

AppRadius.card

AppAnimation.fast
Imports

Order:

Flutter

Packages

Core

Models

Providers

Widgets
Error Handling

Never silently ignore exceptions.

Use structured error handling.

State

Never duplicate state.

If a provider owns it,

widgets must not store it.

Async

Avoid deeply nested async calls.

Prefer readable flows.

Testing

Every scheduler algorithm

↓

Unit Test.

Every repository

↓

Unit Test.

Critical widgets

↓

Widget Test.

Golden Rule

Write code for maintainability first, then optimization.

Readable code is preferred over clever code.