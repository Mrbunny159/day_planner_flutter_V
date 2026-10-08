# Context Memory & Project Status

## Project Overview
**Day Planner** is a cross-platform Flutter application migrated from a legacy Python desktop app. The application provides a visual daily schedule using draggable, resizable task and break blocks, a current time indicator, and automatic planning functionalities.

**Core Tech Stack:**
- **Framework:** Flutter (Android, iOS, Web, Windows, macOS, Linux)
- **State Management:** Riverpod (StateNotifier pattern)
- **Local Database:** Drift (SQLite) with auto-migrations
- **Architecture:** Strict layering (UI → Riverpod Notifiers → Services → Repositories → Drift Database)

## Milestones Completed (1-20)
The project is being developed according to a strictly locked Implementation Roadmap. The MVP milestones completed so far include:

1. **Foundations:** Project setup, theming, base models, database schema setup.
2. **UI & Interactions:** 
   - Interactive Timeline View (Single-click select, double-click edit).
   - Draggable tasks (reordering).
   - Resizable tasks (top/bottom edge resizing).
   - Fixed schedule anchors (Breaks cannot be resized or moved).
3. **Core Logic:** Auto-planning algorithm, recurring task logic, block overlapping prevention.
4. **Milestone 17 (Recurring Tasks):**
   - Historical planner data tracking (each day has a unique schedule).
   - Recurring tasks duplicate automatically on new days while preserving original attributes.
5. **Milestone 18 (Data Recovery & Error Handling):**
   - **Save Failures (FR-130):** In-memory state is preserved when disk writes fail, allowing the user to keep working and manually "Retry".
   - **Settings Recovery (FR-131):** Corrupted settings automatically self-heal back to defaults (`PlannerSettings()`).
   - **Task Corruption Recovery (FR-132):** Corrupted task data is gracefully ignored, returning an empty list `[]` instead of crashing.
   - **Database Locking:** Added `PRAGMA busy_timeout = 3000` to automatically retry database locks.
   - **Database Corruption:** Detected `SqliteException`s related to malformed disk images and surfaced them to the UI as a non-fatal `DatabaseCorruptException`.
6. **Milestone 19 (Cross-Platform Release Verification):**
   - Verified static code analysis and test execution.
   - Built and verified production artifacts for Web and Android.
7. **Milestone 20 (Desktop / OS Integrations):**
   - Natively configured custom window title `"Day Planner"` (without version info) across Linux, Windows, and macOS.
   - Enforced a default size of `480x740` and minimum size bounds of `480x740` while allowing user resizing.

## Key Architectural Decisions & Rules
- **No Direct UI to Service Calls:** The UI layer (e.g., `planner_screen.dart`) must NEVER access services or repositories directly. All actions must be routed through `PlannerNotifier` via `ref.read(plannerProvider.notifier).someAction()`.
- **Idempotent Recurrence:** The recurrence generation logic is strictly idempotent to prevent infinite task duplication across days.
- **Fail Gracefully, Never Crash:** A corrupt database should show an empty planner and an error message rather than crashing the application. Save failures should retain user progress in memory.

## Current Known Issues & Next Steps
- **Architectural Violation Pending Fix:** None. (Resolved: Decoupled retry mechanism from UI layer by introducing `forceSave()` inside `PlannerNotifier` and removing service/repository/database dependencies from `planner_screen.dart`).
- **Next Milestone:** Milestone 21 — Final MVP Release / User Sign-Off.

## Notes for AI Context
- Always strictly adhere to the locked implementation roadmap. Do not introduce new features or change design patterns unless explicitly requested.
- Maintain the exact interaction specification set by the original Python application (Tasks can drag/resize/complete; Breaks act as fixed scheduling constraints).
