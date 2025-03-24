# flutter_clean_architecture

A new Flutter project.

Localizations keys generator's command 
1. flutter pub run easy_localization:generate -S "assets/translations" -O "lib/translations"
2. flutter pub run easy_localization:generate -S "assets/translations" -O "lib/translations" -o "locale_keys.g.dart" -f keys

Show simulator on android studio command: **sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer**

lib/
│── config/                         // App configuration settings
│   ├── env_config.dart              // Handles environment-specific configurations
│   ├── app_constants.dart           // Global constants
│   ├── app_secrets.dart             // API keys & secrets (ensure this is ignored in Git)
│
│── core/
│   ├── network/
│   │   ├── network_service.dart     // Handles HTTP requests, adds token in headers
│   │   ├── api_endpoints.dart       // Defines API endpoints
│   │   ├── network_exceptions.dart  // Handles API errors
│   ├── utils/
│   │   ├── extensions/
│   │   │   ├── string_extensions.dart // String extensions
│   │   │   ├── int_extensions.dart    // Integer extensions
│   │   │   ├── double_extensions.dart // Double extensions
│   │   ├── secure_storage_helper.dart // Secure storage for tokens
│   │   ├── constants.dart           // App-wide constants
│   │   ├── custom_classes/
│   │   │   ├── custom_class.dart    // Custom reusable classes
│   │   ├── permission_handler/
│   │   │   ├── camera_permission.dart   // Handles camera permissions
│   │   │   ├── microphone_permission.dart // Handles microphone permissions
│   ├── errors/
│   │   ├── failure.dart            // Abstract failure class
│   │   ├── exceptions.dart         // Custom exceptions
│   ├── theme/
│   │   ├── theme_bloc/
│   │   │   ├── theme_bloc.dart     // Bloc for theme management
│   │   │   ├── theme_event.dart    // Theme events
│   │   │   ├── theme_state.dart    // Theme states
│   │   ├── app_theme.dart          // Light & Dark themes
│   │   ├── app_colors.dart         // Color file
│   ├── no_internet_cubit.dart     // Manages internet connection state, prevents unnecessary UI rebuilds
│   ├── service_locator.dart       // Dependency injection (GetIt)
│   ├── README.md                  // Documentation for dependency injection setup and usage
│   ├── fonts/
│   │   ├── app_fonts.dart          // Custom fonts and typography
│   ├── models/
│   │   ├── base_model.dart         // Abstract base model class, all models should extend this
│
│── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── data_sources/
│   │   │   │   ├── auth_remote_data_source.dart // API Calls
│   │   │   ├── repositories/
│   │   │   │   ├── auth_repository_impl.dart   // Implementation of Auth Repository
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── user.dart       // User entity
│   │   │   ├── repositories/
│   │   │   │   ├── auth_repository.dart // Repository interface
│   │   │   ├── usecases/
│   │   │   │   ├── login_usecase.dart // Login UseCase
│   │   ├── presentation/
│   │   │   ├── bloc/
│   │   │   │   ├── auth_bloc.dart    // Bloc for Auth (Handles token expiration, login failures, session state)
│   │   │   ├── pages/
│   │   │   │   ├── login_page.dart   // Login UI
│   │   │   ├── widgets/
│   │   │   │   ├── auth_form.dart    // Login form widget
│   │   │   ├── validators/
│   │   │   │   ├── auth_validators.dart // Input validation logic for auth
│
│── app/
│   ├── routes.dart                 // Manages named routes
│   ├── app.dart                     // App entry point
│   ├── main.dart                    // Runs the app
│   ├── init_dependencies_main.dart  // Initializes dependencies at app startup
│
│── widgets/                         // Global shared widgets (moved to top level)
│   ├── buttons/
│   │   ├── primary_button.dart      // Primary button widget
│   │   ├── secondary_button.dart    // Secondary button widget
│   ├── dialogs/
│   │   ├── confirmation_dialog.dart // Confirmation dialog widget
│   │   ├── error_dialog.dart        // Error dialog widget
│   ├── inputs/
│   │   ├── text_input_field.dart    // Custom text input field
│   │   ├── password_field.dart      // Custom password input field
│   ├── loaders/
│   │   ├── loading_spinner.dart     // Loading spinner widget
│   ├── cards/
│   │   ├── info_card.dart           // Generic information card widget
│   ├── forms/
│   │   ├── custom_form.dart         // Modular form widget
│   ├── pages/
│   │   ├── empty_page.dart          // Placeholder for reusable empty state pages
│
│── localization/                     // Multi-language support
│   ├── en.json                       // English language file
│   ├── es.json                       // Spanish language file
│   ├── localization_helper.dart       // Handles localization logic
│
│── assets/                           // Fonts, images, icons, SVGs
│   ├── images/
│   │   ├── logo.png                  // App logo
│   │   ├── banner.jpg                // Sample banner
│   ├── icons/
│   │   ├── home_icon.png             // Home icon
│   │   ├── user_icon.png             // User icon
│   ├── svg/
│   │   ├── settings.svg              // Settings icon
│   │   ├── notifications.svg         // Notification icon
│   ├── fonts/
│   │   ├── custom_font.ttf           // Custom font
