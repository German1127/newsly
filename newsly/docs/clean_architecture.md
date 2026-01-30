# Refactor to Clean Architecture

This document records the changes made to refactor the "Newsly" project toward a Clean Architecture, following Robert C. Martin's principles.

---

## Step 1: Layer Structure and the Dependency Rule

The first step is to reorganize the project to reflect the layers of Clean Architecture and enforce the **Dependency Rule**. This rule states that source code dependencies can only point inwards. Nothing in an inner circle can know anything about something in an outer circle.



### New Folder Structure

A new folder structure has been created within `lib` to separate responsibilities by layers. It is recommended to move existing files into this new structure.

```
lib
├── data/          # Capa de Datos (Implementaciones)
│   ├── models/
│   └── repositories/
├── domain/        # Capa de Dominio (Entidades, Casos de Uso, Interfaces)
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── presentation/  # Capa de Presentación (UI)
    ├── pages/
    └── widgets/
```
---

### Changes Made

1. **Domain Layer:** This layer, the core of the application, has been created.
    * The entity `ArticleEntity` (`domain/entities/article_entity.dart`) was created. It is a pure object representing a news item, free of external dependencies.
    * The interface (abstract class) `ArticleRepository` (`domain/repositories/article_repository.dart`) was defined. This is the "port" that defines how the application retrieves data, without knowing its source.
    * The use case `GetTopHeadlines` (`domain/usecases/get_top_headlines.dart`) was created. It orchestrates the data flow and depends on the `ArticleRepository` abstraction.

2. **Data Layer:** This has been refactored to implement the domain abstractions.
    * The `NewsArticle` model (`data/models/news_article_model.dart`) now extends the `ArticleEntity`. It maintains the `fromJson` logic, which is an implementation detail.
    * `NewsRepositoryImpl` (`data/repositories/news_repository_impl.dart`) was created. This class implements the `ArticleRepository` interface from the domain.

3. **Presentation Layer:** This layer has been decoupled from the data layer.
    * The `NewsCard` widgets and the `NewsDetailPage` now depend on the `ArticleEntity` from the domain instead of the `NewsArticle` model from the data layer. This complies with the Dependency Rule.

4. **Dependency Injection (`locator.dart`):** This has been updated to register the new classes, injecting implementations (`NewsRepositoryImpl`) where abstractions (`ArticleRepository`) are required.

## Step 2: SOLID Refactoring and Strict Compliance

### 1. Strict Dependency Rule Compliance
**Problem:**
The `core/constants.dart` file mixed UI constants (colors, texts) with API constants (URLs, Keys). This caused the **Data** layer (`NewsApi`) to have a transitive dependency on the UI framework (`flutter/material.dart`) by importing that file.

**Solution:**
* Created `lib/core/api_constants.dart` exclusively for data configurations (Pure Dart).
* Cleaned `lib/core/constants.dart` to leave only design elements.
* **Result:** The Data layer is now completely agnostic of the user interface, strictly complying with the rule that dependencies must point inwards and inner layers must not know about outer ones.

### 2. Open/Closed Principle (OCP) & Dependency Inversion Principle (DIP)
**Problem:**
The `NewsApi` class was a concrete implementation. If changing the HTTP library or using mock data was required, the existing code consuming this class had to be modified, violating OCP.

**Solution:**
* Defined an abstract interface (contract) `NewsRemoteDataSource` in the Data layer.
* `NewsApi` now implements `NewsRemoteDataSource`.
* **Result:**
    * **OCP:** The system is open for extension (we can create new implementations like `DioRemoteDataSource` or `MockRemoteDataSource`) but closed for modification.
    * **DIP:** The Repository and other consumers now depend on the abstraction (`NewsRemoteDataSource`), not the concrete implementation (`NewsApi`).