App Flow Document (AFD)
Day Planner v2.0

Version: 1.0

1. Overall Navigation

Unlike traditional mobile applications, Day Planner is a single-workspace application.

Launch

↓

Load Planner

↓

Timeline Screen

├── Add Task
├── Edit Task
├── Drag Task
├── Resize Task
├── Complete Task
├── Delete Task
├── Auto Plan
├── Settings
└── Context Menu

The application never navigates away from the main timeline.

Dialogs appear as modal overlays.

2. Application Startup
Application Launch

↓

Initialize Flutter

↓

Load Local Database

↓

Load Settings

↓

Load Theme

↓

Load Tasks

↓

Load Breaks

↓

Validate Planner

↓

Initialize Scheduler

↓

Calculate Summary

↓

Create Current Time Indicator

↓

Center Timeline On Current Time

↓

Display Main Screen
3. Main Screen Layout Flow
Main Screen

├── Timeline
├── Current Time Indicator
├── Summary
├── Bottom Toolbar
│
├── Add
├── Delete
├── Auto Plan
├── Settings
└── Clear All

Everything happens from this screen.

4. Add Task Flow
User Presses Add

↓

Task Dialog Opens

↓

Enter Name

↓

Select Duration

↓

Select Repeat

↓

Press Save

↓

Validate Input

↓

Scheduler

↓

Find Next Free Slot

↓

Insert Task

↓

Resolve Conflicts

↓

Save Planner

↓

Refresh Timeline

↓

Update Summary
5. Add Multiple Tasks
User Enters

Study
Gym
Reading

↓

Press Save

↓

Create Task 1

↓

Scheduler

↓

Create Task 2

↓

Scheduler

↓

Create Task 3

↓

Scheduler

↓

Save

↓

Refresh Timeline

Each task is processed independently.

6. Add Break
User Presses Add

↓

Select Break

↓

Enter Name

↓

Select Time

↓

Select Duration

↓

Save

↓

Validate

↓

Insert Break

↓

Resolve Conflicts

↓

Save

↓

Refresh
7. Edit Task
Double Tap

OR

Context Menu

↓

Edit Dialog

↓

Modify Data

↓

Save

↓

Scheduler Validation

↓

Conflict Resolution

↓

Persistence

↓

Timeline Refresh
8. Edit Break
Open Context Menu

↓

Edit

↓

Dialog

↓

Save

↓

Validate

↓

Refresh
9. Drag Task
Pointer Down

↓

Begin Drag

↓

Convert Position

↓

Snap To Grid

↓

Preview

↓

Release

↓

Scheduler

↓

Conflict Resolution

↓

Save

↓

Summary Refresh
10. Resize Task
Pointer Down

↓

Resize Handle

↓

Drag

↓

Calculate Duration

↓

Snap

↓

Validate

↓

Resolve Conflicts

↓

Save

↓

Refresh
11. Complete Task
Checkbox

↓

Toggle Complete

↓

Update Model

↓

Save

↓

Refresh Summary

↓

Update Timeline
12. Mark Incomplete
Context Menu

↓

Mark Incomplete

↓

Update Model

↓

Save

↓

Refresh
13. Delete Task
Context Menu

↓

Delete

↓

Remove Task

↓

Save

↓

Refresh Timeline

↓

Refresh Summary
14. Delete Completed
Context Menu

↓

Delete Completed

↓

Remove All Completed

↓

Save

↓

Refresh
15. Auto Planner
Auto Plan

↓

Determine Current Time

↓

Separate Completed

↓

Separate Incomplete

↓

Rebuild Schedule

↓

Avoid Breaks

↓

Resolve Conflicts

↓

Save

↓

Refresh Timeline

↓

Refresh Summary
16. Clear Planner
Clear All

↓

Confirmation Dialog

↓

YES ?

↓

Remove Everything

↓

Save

↓

Refresh Timeline

↓

Reset Summary
17. Undo
Ctrl+Z

↓

Restore Deleted Block

↓

Validate

↓

Save

↓

Refresh
18. Change Theme
Settings

↓

Theme

↓

Select Theme

↓

Update Colors

↓

Save

↓

Refresh Entire UI
19. Change Working Hours
Settings

↓

Working Hours

↓

Save

↓

Recalculate Summary

↓

Refresh
20. Current Time

Runs continuously.

Every Minute

↓

Read System Time

↓

Move Time Indicator

↓

Update Past Breaks

↓

Refresh Timeline
21. Summary Update

Triggered after:

Create
Edit
Delete
Complete
Resize
Drag
Auto Plan
Settings Change
Planner Changed

↓

Calculate Completed

↓

Calculate Break

↓

Calculate Free Time

↓

Update Summary
22. Save Flow

Every mutation follows exactly the same pipeline.

Planner Changed

↓

Update Models

↓

Write Database

↓

Refresh UI

There is no manual Save button.

23. Error Flow
Operation

↓

Validation

↓

Success ?

↓

YES

↓

Continue

↓

NO

↓

Restore Previous State
24. Navigation Rules

The application follows these principles:

Single-screen experience.
No page stack.
All editing occurs in modal dialogs.
Timeline remains the primary workspace.
Users never lose timeline context.
All changes are immediately reflected.
25. Interaction Priority

When multiple interactions occur simultaneously, priority is:

Drag

↓

Resize

↓

Dialog

↓

Context Menu

↓

Toolbar

Higher-priority interactions block lower-priority ones until completion.