# Asset Steward App - AI Agent Instructions

Welcome to the Asset Steward project! This `AGENTS.md` file acts as the primary rulebook and guideline for any AI agent interacting with this codebase. Please read and adhere to these guidelines closely to maintain a clean, consistent, and modern codebase.

## 1. UI and Widget Construction
* **Avoid `SizedBox` for Spacing:** ALWAYS use the `Gap` widget from the `gap` package for spacing instead of `SizedBox`. 
* **Widget Extraction:** ALWAYS extract widgets as separate `Class`es instead of helper functions returning `Widget`. This improves performance and readability.
* **List Gaps:** For spacing out a list of widgets, leverage the `.gap(double)` extension on `Iterable<Widget>` (e.g., `[Widget1(), Widget2()].gap(16)`).

## 2. Modern Dart Features
ALWAYS use the latest Dart 3 features wherever possible to write concise, expressive code:
* **Records & Pattern Matching:** Use Records to return multiple values. Use pattern matching in `switch` expressions and statements (e.g., `switch (state) { ... }`).
* **Destructuring:** Use pattern destructuring for Records, Lists, and Maps.
* **Class Modifiers:** Make use of `sealed`, `final`, `base`, `interface` classes as appropriate to control inheritance.
* **Super Parameters:** Use `super.key` and other super parameters in constructors instead of explicitly passing them to `super()`.

## 3. Leverage Existing Extensions
Before writing boilerplate code, always check if an extension already exists in `lib/core/extensions`. Here are some common ones to use:
* **Context Extensions (`context_extensions.dart`):**
  * Routing: `context.route`, `context.routeState`, `context.nPop()`, `context.nPush()`
  * Theming: `context.theme`, `context.colors`, `context.text`
  * Sizing/MediaQuery: `context.mq`, `context.height`, `context.width`, `context.padding`
* **Misc Extensions (`misc_extension.dart`):**
  * `ValueNotifier`: `.toggle()`, `.truthy()`, `.falsey()`, `.waitUntil(Future fn)`
  * Numbers: `.currency()`, `.compact()`, `.twoDigits()`
  * DateTime: `.toRelativeTime()`
  * Iterables of Widgets: `.gap(double)` and `.separatedBy(Widget)`
  * Debugging: `.log()` and `Widget.debugView()`

## 4. Architecture & Packages
The project boilerplate relies on specific packages for core functionality. Ensure you generate code that aligns with this stack:
* **State Management:** `hooks_riverpod` and `riverpod_annotation`. Prefer using `@riverpod` code generation over manual providers where possible.
* **Dependency Injection:** `injectable` and `get_it`. Use `@lazySingleton`, `@injectable` annotations.
* **Routing:** `go_router`. Define routes properly with paths and parameters.
* **Data Serialization:** `dart_mappable` and `dart_mappable_builder`. Use `@MappableClass()` over manual JSON parsing or `json_serializable`.
* **Networking:** `dio`.
* **Functional Programming:** `fpdart`. Consider using `Either` or `Option` for robust error handling where appropriate.
* **Logging:** `chirp`. Do not use `print()` or `debugPrint()`. Use `Chirp.info()`, `Chirp.error()`, etc.

## 5. Code Quality & Format
* Follow standard Flutter and Dart best practices.
* Maintain a clean separation of concerns.
* Write declarative, readable, and well-commented code when handling complex logic.
