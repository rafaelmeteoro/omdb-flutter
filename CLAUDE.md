# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository shape

This is a **multi-package Flutter monorepo** (no melos/workspace tool — each package is
a standalone Flutter/Dart project wired together via `path:` dependencies in `pubspec.yaml`).
There are three package groups:

- `app/` — the shippable Flutter application. Composition root only: `lib/main.dart` boots
  `ModularApp`, `lib/app/app_module.dart` registers each feature's route module, `lib/app/app_widget.dart`
  holds the `MaterialApp.router` theme. No business logic lives here.
- `features/*` — one package per feature (`search`, `movie`, `favorites`, `words`, `board`). Each is
  a self-contained Clean Architecture slice with its own `pubspec.yaml`, tests, and coverage.
- `infrastructure/*` — shared packages consumed by features:
  - `core` — Dio HTTP client + `TokenInterceptor`, `ApiConfig` (OMDb `baseUrl`/`apiToken`), theming
    (`styles/colors.dart`, `styles/text_styles.dart`), and `CoreModule` (flutter_modular module that
    exports the Dio singleton). Exposes two barrel files: `core/domain.dart` and `core/presentation.dart`
    — import whichever matches the layer you're in.
  - `app_core` — cross-feature primitives: `Failure` base classes and typedef signatures
    (`JsonFormat`, `Callback`, `Result`).
  - `movie_storage_manager` / `words_storage_manager` — Hive-backed local storage, each wrapping a
    box for one concern (favorited movies, saved search words) behind a repository interface.
  - `dev_core` — shared analysis (`app_analysis.yaml`, `test_analysis.yaml`) and re-exports
    `flutter_test`, `mocktail`, `fpdart` for tests.

Feature packages depend on `core`, `app_core`, and the storage manager(s) they need; some features
depend on other features directly (e.g. `board` imports `favorites` and `words`; `favorites` imports
`words`). Check a package's `pubspec.yaml` before assuming what it can import.

## Architecture inside a feature package

Each feature under `features/<name>/lib/src/features/<name>/` follows the same Clean Architecture
layering, wired together with **flutter_modular** for DI/routing:

```
data/          DTOs (Dio JSON <-> domain) and repository implementations (Remote*/Local*Repository)
domain/
  entities/    plain domain models
  interfaces/  abstract repository + use case contracts
  usecases/    use case implementations, injected with a repository interface
presentation/
  controller/  ValueNotifier<State> controllers (state = sealed-ish class hierarchy per feature,
               e.g. SearchPageStateEmpty/Loading/Success/Error)
  pages/       page widget + a *Delegate/*Flow class for navigation (Modular.to.pushNamed etc.)
  widgets/     feature-local widgets
```

Plus `src/<name>_module.dart` (the flutter_modular `Module`, registering binds and the route) and
a top-level barrel file `lib/<name>.dart`.

Key conventions to follow when touching this code:

- **DI**: everything is registered in a feature's `*Module.binds()` via `addLazySingleton` (repository
  → use case → controller → delegate, in that order), and `imports` pulls in `CoreModule()` plus any
  storage module the feature needs. Constructors take their dependency as a named required parameter
  typed to the *interface*, never the concrete class.
- **Error handling**: use cases and repositories return `Future<Either<Failure, T>>` (fpdart), aliased
  per-feature in `core/typedef/signatures.dart` (e.g. `ResultSearch`). Failures extend the `Failure`
  classes from `app_core`/`core`. Controllers `.fold()` the `Either` into a presentation state — never
  throw across layers.
- **State**: controllers are `ValueNotifier<SomeState>`, not Bloc/Cubit. Pages listen with
  `ValueListenableBuilder`. State classes are one-per-outcome (`Empty`, `Loading`, `Success(data)`,
  `Error(message)`).
- **Navigation**: pages don't call `Modular.to` directly; they receive a `*Delegate`/`*Flow` interface
  (also DI-registered) that wraps navigation, so navigation is mockable in widget tests.
- **New feature packages** should mirror this structure exactly (`pubspec.yaml` with `path:` deps,
  `analysis_options.yaml` including `dev_core`'s shared rules, a `*Module`, a barrel file).

## Commands

All module-spanning commands run from the **repo root** via `make` (wrapping the scripts in `scripts/`,
which loop over every `pubspec.yaml` under `infrastructure/`, `features/`, then `app/`):

```
make build-modules     # flutter clean + pub get + build_runner (if used) for every package, then app
make analyze-modules   # flutter analyze --fatal-infos --fatal-warnings for every package, then app
make test-modules      # flutter test --coverage for every package, then app
make merge-modules     # merge all packages' lcov.info into ./coverage/lcov.info
make genhtml           # generate + open HTML coverage report from ./coverage/lcov.info
make percent-modules   # print per-package and overall line coverage %
```

Working on a **single package** (feature or infrastructure package, or `app/`):

```
cd features/search           # or infrastructure/<name>, or app
flutter pub get
flutter analyze --fatal-infos --fatal-warnings
flutter test --coverage
flutter test test/src/features/search/presentation/controller/search_page_controller_test.dart   # single test file
```

Note: `scripts/test-module` deletes any stale `test/full_coverage_test.dart` and `coverage/lcov.info`
before running, and skips packages with no `*_test.dart` files. `full_coverage_test.dart` (when present)
is a generated file that just imports every lib file so coverage counts untested files as 0% rather than
omitting them — don't hand-edit it and don't worry about deleting it locally, tooling regenerates it.

Run the app itself from `app/` (`flutter run`), or use the VS Code launch configs ("app", "app (profile
mode)", "app (release mode)"), all of which set `cwd: app`.

## Notes

- Dart/Flutter SDK constraints: `sdk: ">=3.12.2 <4.0.0"`, `flutter: ">=3.44.9"` (CI pins Flutter
  `3.44.9` stable). Third-party deps are pinned to exact versions (no `^`) in every `pubspec.yaml`.
- Lint config is centralized in `dev_core`: app packages include `package:dev_core/app_analysis.yaml`,
  test-only analysis uses `package:dev_core/test_analysis.yaml`.
- OMDb API base URL and token are hardcoded in `infrastructure/core/lib/modules/core_module.dart`
  (`ApiConfig`) — not environment-configured.
- CI (`.github/workflows/flutter-ci.yml`) runs the same `make build-modules` → `analyze-modules` →
  `test-modules` → `merge-modules` pipeline, then uploads coverage to both Codecov and Coveralls.
  Danger (`Dangerfile`, `scripts/run-danger`) runs separately in CI only (`$CI` must be set).
