Data Architecture Specification (DAS)
Day Planner v2.0

Version: 1.0

Platforms

Android
iOS
Windows
macOS
Linux

Storage

SQLite

Architecture

Repository Pattern

Offline First

1. Purpose

This document defines:

Data models
Relationships
Storage contracts
Repository interfaces
Serialization
Persistence rules
Future extensibility

The UI shall never directly access storage.

2. Architecture
UI

↓

Providers

↓

Repositories

↓

Storage Layer

↓

SQLite

The UI must never know:

SQL
JSON
Tables
3. Data Models

The application consists of five core models.

Planner

Task

Settings

Summary

Theme
4. Planner Model

Represents the entire planner.

Planner

id

tasks

settings

summary

lastUpdated

Relationships

Planner

↓

Many Tasks

↓

One Settings

↓

One Summary
5. Task Model
Task

id

name

startMinute

duration

completed

type

recurring

colorTag

createdAt

updatedAt
Field Definitions
id

Unique identifier.

UUID.

Immutable.

name

Task title.

String.

Never null.

Default

Untitled
startMinute

Integer.

0

↓

1439
duration

Integer.

Minimum

15

Always multiple of 15.

completed

Boolean.

Default

false
type

Enum

enum BlockType{

task,

break

}
recurring

Enum

enum Repeat{

none,

daily

}
colorTag

Nullable.

enum ColorTag{

none,

blue,

green,

orange,

red

}
createdAt

Timestamp.

Immutable.

updatedAt

Timestamp.

Updated after every mutation.

6. Settings Model
PlannerSettings

theme

taskColor

taskBorderColor

breakColor

breakBorderColor

dayStartMinute

dayEndMinute

timeFontSize

timeFontBold

Only one instance exists.

7. Theme Model
ThemeModel

name

background

timeline

taskFill

taskBorder

breakFill

breakBorder
8. Summary Model

Generated.

Never edited directly.

Summary

completedMinutes

breakMinutes

freeMinutes

Computed every planner update.

9. Relationships
Planner

↓

Tasks

↓

Settings

↓

Summary

Tasks never own settings.

Settings never own tasks.

10. SQLite Schema
planner
planner

id

last_updated
tasks
id

name

start_minute

duration

completed

type

recurring

color_tag

created_at

updated_at
settings
theme

task_color

task_border

break_color

break_border

day_start

day_end

time_font_size

time_font_bold

No Summary table.

Summary is computed.

11. Repository Contracts
PlannerRepository

Responsibilities

loadPlanner()

savePlanner()

clearPlanner()

validatePlanner()
TaskRepository
create()

update()

delete()

restore()

findById()

findAll()
SettingsRepository
load()

save()

updateTheme()

updateWorkingHours()
12. Repository Rules

Repositories:

✓ Handle persistence

✓ Convert Models

✓ Hide SQL

Repositories shall NOT:

✗ Perform scheduling

✗ Build widgets

✗ Execute UI logic

13. Serialization

Every model supports

fromJson()

toJson()

copyWith()

Even when using SQLite.

Reason

Future synchronization.

14. Immutability

Models are immutable.

Updates occur through

copyWith()

Never mutate directly.

15. IDs

Every Task

UUID

Example

7ef1e6e1

e923ff11

b718dc55

IDs never change.

16. Save Strategy

Every mutation

↓

Repository

↓

SQLite

↓

Success

↓

Notify Provider

No batching.

No delayed save.

17. Read Strategy

Application Start

↓

Load Settings

↓

Load Tasks

↓

Build Planner

↓

Validate

↓

Expose To Providers

18. Validation

Before save

Every task validates

Duration

↓

Start Minute

↓

Type

↓

Recurring

↓

Color Tag

Invalid models rejected.

19. Migration Strategy

Database Version

v1

Future versions

v2

↓

Migration

↓

Preserve Data

Never delete user planner.

20. Future Compatibility

The storage layer must allow replacing SQLite with:

SQLite

Hive

Isar

Firebase

Supabase

Appwrite

without changing:

UI
Scheduler
Timeline

Only repositories change.

21. Storage Rules

The database stores:

✓ Tasks

✓ Breaks

✓ Settings

✓ Theme

It does NOT store:

✗ Summary

✗ Scheduler

✗ Timeline State

✗ Selected Widget

✗ Dragging State

Those are runtime-only concerns.

22. Runtime State

Managed by Providers.

Examples

Dragging

Selected Block

Hovered Block

Dialog Open

Current Time

Temporary Resize

Never persist runtime state.

23. Data Lifecycle
Launch

↓

Load SQLite

↓

Repositories

↓

Planner Model

↓

Providers

↓

Widgets

↓

User Action

↓

Repository

↓

SQLite

Single-direction flow.

24. Persistence Events

The following actions immediately persist:

Create Task
Edit Task
Delete Task
Move Task
Resize Task
Complete Task
Mark Incomplete
Add Break
Delete Break
Edit Break
Change Theme
Change Working Hours
Change Colors
Auto Plan
Clear Planner
Undo Delete
25. Error Recovery

If persistence fails

↓

Keep Planner In Memory

↓

Reject Storage Update

↓

Maintain UI State

↓

Allow Retry

Never corrupt existing planner data.

Data Architecture Complete