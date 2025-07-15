Epilearn :iphone:
Welcome to Epilearn — a Flutter practice app built around the Rick and Morty API. This project is part of a learning exercise to master API integration, state management with Riverpod, pagination, navigation, and local data storage in a scalable Flutter architecture.

This README outlines the structure, setup, and core logic of the app. Let’s dive in! :brain:
lib/
├── main.dart                        // Entry point of the app
├── app/
│   ├── app.dart                     // App widget & MaterialApp setup
│   └── env.dart                     // Environment and flavor config
│
├── core/
│   ├── navigation/
│   │   └── routes.dart              // Defines named routes
│   ├── networking/
│   │   ├── dio_client.dart          // Configured Dio instance
│   │   └── api_interceptors.dart    // Interceptors for logging, errors, etc.
│   ├── responsive/
│   │   ├── custom_edge_insets.dart  // Responsive padding/margin
│   │   └── custom_sized_box.dart    // Responsive sized box widget
│   ├── themes/
│   │   ├── colors.dart              // App color palette
│   │   └── assets.dart              // Icon/image paths
│   └── utils/
│       ├── formatters.dart          // Date, number format utilities
│       ├── validators.dart          // Input validation
│       └── tap_effect_container.dart // Tap effect utility widget
│
├── features/
│   ├── episodes/
│   │   ├── presentation/            // UI: list, detail screens, widgets
│   │   │   ├── episode_list_screen.dart
│   │   │   ├── episode_detail_screen.dart
│   │   │   └── widgets/
│   │   │       ├── episode_card.dart
│   │   │       └── character_card.dart
│   │   ├── application/             // State management (Riverpod)
│   │   │   ├── episode_notifier.dart
│   │   │   └── episode_state.dart
│   │   ├── domain/                  // Models/entities
│   │   │   └── episode_model.dart
│   │   └── data/                    // API & storage logic
│   │       ├── episode_repository.dart
│   │       └── episode_service.dart
│
│   ├── saved_episodes/             // Saved episodes feature
│   │   ├── presentation/
│   │   │   └── saved_episodes_screen.dart
│   │   ├── application/
│   │   │   ├── saved_episode_notifier.dart
│   │   │   └── saved_episode_state.dart
│   │   ├── domain/
│   │   │   └── saved_episode_model.dart
│   │   └── data/
│   │       ├── saved_episode_repository.dart
│   │       └── shared_prefs_service.dart
│
├── shared/
│   ├── enums/                      // Shared enums (e.g. status)
│   ├── widgets/                    // Reusable widgets (buttons, inputs, etc.)
│   ├── providers/                  // Global providers (e.g., Dio)
│   │   └── dio_provider.dart
│   └── extensions/                 // BuildContext & responsive extensions
│       ├── context_extensions.dart
│       └── responsive_extension.dart