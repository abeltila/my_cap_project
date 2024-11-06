# my_cap_project

The **my_cap_project** is a Flutter-based mobile application designed to help users discover
and explore popular GitHub repositories by programming language and view detailed information about
each repository. The app leverages the GitHub API to fetch repository data and presents it to users
in an intuitive and user-friendly interface.

This project is built with a modular architecture that enhances readability, maintainability, and
scalability. The structure is organized around separation of concerns, ensuring that each layer of
the application handles a specific responsibility. The app integrates clean code principles and
modular design patterns, making it easy to extend and modify in the future.

## Project Architecture

This is the repository list - the repository list can be sorted using the stars count ascending and
descending
![Simulator Screenshot - iPhone 15 Pro Max - 2024-11-06 at 22 55 15](https://github.com/user-attachments/assets/00b718fb-d6b0-42cf-bf44-880a21561be0)

This is the repository detail page - here we have the link and image of the repo. You can also tap
to open the url.
![Simulator Screenshot - iPhone 15 Pro Max - 2024-11-06 at 22 58 31](https://github.com/user-attachments/assets/21f367f5-5f79-4501-a2b6-f50f0709d158)

## Project Architecture

This architecture combines clean code principles, modularity, and separation of concerns to create a
maintainable and scalable codebase, suited for both small and complex projects. The use of Cubit and
the repository pattern ensures a responsive and flexible application, allowing future improvements
or extensions with minimal friction.

## Folder Structure

```plaintext
lib/
├── config/
│   ├── colors/
│   │   ├── colors_config.dart
│   │   └── index.dart
│   └── routing/
│       └── index.dart
├── cubit/
│   ├── landing_screen_cubit/
│   │   └── index.dart
├── model/
│   ├── owner_model.dart
│   ├── started_github_repo_detail_model.dart
│   ├── started_github_repo_list_model.dart
│   └── index.dart
├── repository/
│   ├── github_repository.dart
│   └── index.dart
├── screen/
│   ├── landing_screen/
│   │   ├── component/
│   │   ├── index.dart
│   │   └── landing_screen.dart
│   ├── started_repo_detail_screen/
│   │   ├── component/
│   │   ├── cubit/
│   │   ├── index.dart
│   │   └── started_repo_detail_screen.dart
├── services/
│   ├── network_services/
│   ├── sql_database_service/
│   └── index.dart
├── shared_component/
│   ├── appbar/
│   ├── image/
│   ├── loading/
│   ├── svg_icon/
│   ├── snackbar/
│   └── index.dart
├── utils/
│   ├── constants/
│   ├── exceptions/
│   ├── helpers/
│   └── index.dart
└── main.dart
```

1. config/

   Purpose: Holds configuration files for styling and routing.
   Subfolders:
   colors/: Contains color configurations and themes, making it easy to manage color schemes across
   the app.
   routing/: Manages routing configurations and provides a central place for route definitions.
2. cubit/

   Purpose: Contains Cubit classes that manage the state for on a global scale different screens.
   Each screen-specific cubit manages its own state and logic.
   Example:
   landing_screen_cubit/: Contains the Cubit class responsible for managing the state of the
   LandingScreen.
3. model/

   Purpose: Holds data models used throughout the app.
   Files:
   owner_model.dart: Represents the owner of a repository.
   started_github_repo_detail_model.dart: Model for detailed information of a repository.
   started_github_repo_list_model.dart: Model for a list of repositories with brief details.
4. repository/

   Purpose: Contains classes responsible for interacting with data sources, such as APIs or
   databases.
   Files:
   github_repository.dart: Manages GitHub API interactions for fetching repositories and their
   details.
5. screen/

   Purpose: Contains all screen-related code organized into subfolders for each screen.
   Subfolders:
   landing_screen/: Contains files specific to the landing screen, including components and the main
   screen widget.
   started_repo_detail_screen/: Contains files related to the detailed repository screen, including
   components and its cubit for managing state.
6. services/

   Purpose: Contains service classes that handle network and database operations.
   Subfolders:
   network_services/: Manages network requests and handles API communication.
   sql_database_service/: Handles database operations using SQLite for local data storage.
7. shared_component/

   Purpose: Contains reusable components shared across different parts of the app, promoting
   reusability and consistency.
   Subfolders:
   appbar/: Contains custom app bar components.
   image/: Reusable image components.
   loading/: Contains loading indicators, such as custom circular progress indicators.
   svg_icon/: Manages SVG icons used across the app.
8. utils/

   Purpose: Contains utility functions, constants, and helper classes.
   Subfolders:
   constants/: Holds constant values used throughout the app.
   exceptions/: Custom exceptions for handling specific errors.
   helpers/: Miscellaneous helper functions.

## Key Features

This are the key features ued on ths project

    Modular Structure: Each part of the app is separated into distinct folders, making the codebase organized and maintainable.

    State Management with Cubit: The app uses Cubit for state management, allowing each screen to have isolated and testable state management logic.

    Network and Database Layers: The app includes services for handling both network requests (GitHub API) and local database operations (SQLite), facilitating both online and offline usage.

    Reusable Components: Common UI elements like loading indicators, app bars, and icons are organized under shared_component/, promoting reusability.

## Code Conventions

This is the code conventions used, it primarily depends on the clean code implementation

    File Naming: Each file and folder is named in lowercase with underscores to maintain consistency.
    
    Index Files: Each folder includes an index.dart file, which exports files within the folder for easier imports.
    
    Import Conventions: Imports use relative paths (e.g., import '../index.dart';) to keep dependencies localized.


## Project Dependencies

`dependencies:
flutter:
sdk: flutter

# State management
flutter_bloc: ^8.1.6

# Network requests
dio: ^5.7.0

# SQLite database
sqflite: ^2.4.0
path: ^1.9.0

# iOS style icons
cupertino_icons: ^1.0.8

# Data table for displaying repositories
data_table_2: ^2.5.15

# SVG rendering
flutter_svg: ^2.0.13

# Image rendering from URL
extended_image: ^9.0.7

# URL launcher
url_launcher:
`