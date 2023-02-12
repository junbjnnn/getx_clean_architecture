# JBBase APP

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Usage

---

- Install plugin: [flutter_intl](https://marketplace.visualstudio.com/items?itemName=localizely.flutter-intl)
- Install fvm: [fvm](https://fvm.app/docs/getting_started/installation)

```shell
$ git clone ...
$ cd ...
# $ find . -name '*.dart' -print0 | xargs -0 sed -i "" "s/jbbase_app/something/g"

$ fvm install 3.7.3
$ fvm use 3.7.3
$ fvm flutter --version
Flutter 3.7.3 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 9944297138 (3 days ago) • 2023-02-08 15:46:04 -0800
Engine • revision 248290d6d5
Tools • Dart 2.19.2 • DevTools 2.20.1
$ fvm flutter pub global activate index_generator

$ fvm flutter pub get
$ fvm flutter pub global run index_generator
$ fvm flutter pub run intl_utils:generate
$ fvm flutter pub run build_runner build --delete-conflicting-outputs
$ fvm flutter run --flavor [qa|stg|prod]

// Code metrics
$ fvm flutter pub run dart_code_metrics:metrics analyze lib
$ fvm flutter pub run dart_code_metrics:metrics check-unnecessary-nullable lib
$ fvm flutter pub run dart_code_metrics:metrics check-unused-files lib
$ fvm flutter pub run dart_code_metrics:metrics check-unused-code lib
```

- For development time

```shell
$ fvm flutter pub run build_runner watch --delete-conflicting-outputs
```

Each time you modify your project code, `main.mapper.g.dart` files will be updated as well.

## About Project

---

#### Document

#### Techstack

- Using [GetX](https://github.com/jonataslaw/getx) for integration State management, Route management, Dependency management
- Using [Dio](https://pub.dev/packages/dio) & [Retrofit](https://pub.dev/packages/retrofit) for networking
- Using [json_dart_mapper](https://pub.dev/packages/dart_json_mapper) for mapping data

#### Architecture

![](/assets/architecture/architecture.png)

#### Folder structure

```
├─ assets
│   ├─ env
│   │   ─   .env_qa
│   │   ─   .env_stg
│   │   ─   .env_prod
│   ├─ fonts
│   │   ─   *.ttf
│   └─ images
│       ─   *.png
│       ─   ...
└─ lib
    ├─ base
    │   ├─ data
    │   ├─ domain
    │   └─ presentation
    ├─ features
    │   ├─ authentication
    │   │   ├─ data
    │   │   │   ├─ providers (datasources)
    │   │   │   │   ├─ local
    │   │   │   │   │   ─   user_storage.dart
    │   │   │   │   │   ─   ...
    │   │   │   │   └─ remote
    │   │   │   │       ─   user_api.dart
    │   │   │   │       ─   ...
    │   │   │   ├─ models
    │   │   │   │   ─   user_model.dart
    │   │   │   │   ─   ...
    │   │   │   └─ repositories_impl
    │   │   │       └─ mapper
    │   │   │           ─   user_mapper.dart
    │   │   │           ─   ...
    │   │   │       ─   user_repo_impl.dart
    │   │   │       ─   ...
    │   │   ├─ domain
    │   │   │   ├─ repositories (abstract class)
    │   │   │   │   ─   user_repo.dart
    │   │   │   │   ─   ...
    │   │   │   ├─ entities
    │   │   │   │   ─   user.dart
    │   │   │   │   ─   ...
    │   │   │   └─ usecases
    │   │   │       ├─ login
    │   │   │       │   ─   login_uc.dart
    │   │   │       │   ─   ...
    │   │   │       ├─ ...
    │   │   └─ presentation
    │   │       ├─ controllers
    │   │       │   ├─ login
    │   │       │   │   ─   login_binding.dart
    │   │       │   │   ─   login_controller.dart
    │   │       │   │   ─   login_input.dart
    │   │       │   └─ ...
    │   │       └─ views
    │   │           ├─ login
    │   │           │   ─   login_page.dart
    │   │           └─ ...
    │   └─ other features ...
    │
    ├─ l10n
    │   ─   intl_en.arb
    │   ─   intl_jp.arb
    └─ ultis
        ├─ common_widgets
        ├─ config
        ├─ extension
        └─ service

    ─   main.dart
    ─   app.dart

─   analysis_options.yaml
─   build.yaml
─   pubspec.yaml
```

#### Plugins

- [flutter_intl](https://marketplace.visualstudio.com/items?itemName=localizely.flutter-intl): VS Code extension to create a binding between your translations from .arb files and your Flutter app. It generates boilerplate code for official Dart Intl library and adds auto-complete for keys in Dart code.
