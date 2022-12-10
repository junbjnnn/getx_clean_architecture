# JBBase App Architecture

## About

---

- Base on [Uncle Bob's Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) with Flutter.

## Overview

---

### The Dependency

**Source code dependencies only point inwards**. This means inward modules are neither aware of nor dependent on outer modules. However, outer modules are both aware of and dependent on inner modules. Outer modules represent the mechanisms by which the business rules and policies (inner modules) operate. The more you move inward, the more abstraction is present. The outer you move the more concrete implementations are present. Inner modules are not aware of any classes, functions, names, libraries, etc.. present in the outer modules. They simply represent **rules** and are completely independent from the implementations.

### Data

Represents the data-layer of the application. The `Data` module, which is a part of the outermost layer, is responsible for data retrieval. This can be in the form of API calls to a server, a local database, or even both.

##### Contents of Data

- **Models**
  - Not depending on the application
  - Mapping with fields on database
- **Providers**
  - Responsible for any API calls and high-level data manipulation such as
    - Calling an API & interact with the database
    - Uploading & downloading data
  - Data output is `Models` or `bool`
- **Repositories (implement)**
  - Implement `Repository` (abstract) in `Domain` layer.
  - Retrieve data from `Providers`
  - Convert `Models` to `Entities`
  - Will be injected into `UseCases` at `Bindings` class

### Domain

The `Domain` module defines the business logic of the application. `Domain` would be written purely in `Dart` without any `Flutter` elements. The reason for that is that `Domain` should only be concerned with the business logic of the application, not with the implementation details. This also allows for easy migration between platforms, should any issues arise.

##### Contents of Domain

`Domain` represents the inner-most layer. Therefore, it the most abstract layer in the architecture.

- **Repositories (abstract)**
  - **Abstract classes** that define the expected functionality of outer layers
  - Are not aware of outer layers, simply define expected functionality
- **Entities**
  - Business objects of the application
  - Normally it is the properties that show up on `Views`
- **UseCases**
  - This is where the business logic gets executed
  - Orchestrate the flow of data throughout the app
  - Should not be affected by any UI changes whatsoever
  - Get data from methods at `Repositories` (abstract)
  - Will be injected into `Controllers` at `Bindings` class

### Presentation

`Presentation` is the layer outside `Domain`. It is the most framework-dependent layer, as it contains the UI and the event handlers of the UI.

##### Contents of Presentation

- **Controllers**

  - `Bindings` class will be inject
    - `Repositories` (implement) => `UseCases`
    - `UseCases` => `Controllers`
    - `Controllers` => `Views`
  - `Input` class will be define what come from previous controller
  - `Controller` will be contain event handlers of the UI

- **Views**
  - Represents only the UI of the page.
  - The `View` builds the page's UI, styles it, and depends on the `Controller` to handle its events.
  - The `View` **has-a** `Controller`.

## Coding Rules

---

### Data

- **Models**
  - Mapping with fields on database
  - Suffix is `Model` with class, `_model` with filename
- **Providers**
  - Extend base provider like `FirestoreProvider`, `APIProvider`, ...
  - **lazyPut** at `app_binding.dart` with **fenix: true**
  - Output is `Models` or `bool`
- **Repositories (implement)**
  - Implement from abstract class at `Domain` layer
  - Will be injected into `UseCases` at `Bindings` class
  - Output is `Entities` or `void` or `bool`

### Domain

- **Repositories (abstract)**
  - Abstract class
- **Entities**
  - Don't have suffix
- **UseCases**
  - Extend `UseCase` with use case don't have input
  - Extend `UseCaseIO` with use case have input & output
  - Input can define inside use case file
  - Suffix is `UseCase` with class, `_uc` with filename
  - Get data from methods at `Repositories` (abstract)
  - Will be injected into `Controllers` at `Bindings` class

### Presentation

- **Controllers**

  - `UseCases` property have to be private & injected to `Controllers` from `Bindings`
  - `Controllers` extend `BaseController` with suffix for class is `Controlller` and for filename is `_controller`
  - `Bindings` extend `Bindings` with suffix for class is `Binding` and for filename is `_binding`

- **Views**
  - Extend `GetView<ControllerType>`
  - Not recommend extend `GetWidget<ControllerType>`, use if you really understand it
  - Do not extend `StatefullWidget`
  - Tabbar view is exception
  - Split widget to methods with @swidget

### Transition

- When you create new page, remember add path for this page at `app_route.dart`
- After that, define navigate method for that page at `app_navigation.dart`
- All navigate use in app have to go through `app_navigation.dart`

---

## Examples

- GetX Clean architecture

---

## Packages
