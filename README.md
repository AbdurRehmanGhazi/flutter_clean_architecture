# flutter_clean_architecture

A new Flutter project.

Localizations keys generator's command 
1. flutter pub run easy_localization:generate -S "assets/translations" -O "lib/translations"
2. flutter pub run easy_localization:generate -S "assets/translations" -O "lib/translations" -o "locale_keys.g.dart" -f keys

Show simulator on android studio command: **sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer**

lib/
│── core/
│   ├── network/
│   │   ├── network_service.dart          // Handles HTTP requests, adds token in headers
│   │   ├── api_endpoints.dart            // Defines API endpoints
│   │   ├── network_exceptions.dart       // Handles API errors
│   │   ├── base_response_model.dart      // Abstract base model class for API responses
│   ├── utils/
│   │   ├── secure_storage_helper.dart    // Secure storage for tokens
│   │   ├── constants.dart                // App-wide constants
│   │   ├── extensions/
│   │   │   ├── string_extension.dart     // String utilities and extensions
│   │   │   ├── int_extension.dart        // Integer utilities and extensions
│   │   │   ├── double_extension.dart     // Double utilities and extensions
│   │   ├── custom_classes/               
│   │   │   ├── custom_button.dart        // Custom styled button class
│   │   │   ├── custom_text_field.dart    // Custom styled text input field class
│   │   ├── permission_handler/           
│   │   │   ├── camera_permission.dart    // Handles camera permissions
│   │   │   ├── microphone_permission.dart // Handles microphone permissions
│   ├── errors/
│   │   ├── failure.dart                  // Abstract failure class
│   │   ├── exceptions.dart               // Custom exceptions for error handling
│   ├── theme/
│   │   ├── app_theme.dart                // Light & Dark themes
│   │   ├── app_colors.dart               // Color constants
│   │   ├── theme_bloc/
│   │   │   ├── theme_bloc.dart           // Bloc for theme switching
│   │   │   ├── theme_event.dart          // Events for theme changes
│   │   │   ├── theme_state.dart          // States for theme changes
│   ├── logging/
│   │   ├── app_logger.dart               // Centralized logging service
│   │   ├── analytics_service.dart        // App analytics tracking service
│   ├── config/
│   │   ├── environment_config.dart       // Environment-based app config
│   │   ├── app_config.dart               // General app settings
│   │   ├── env/
│   │   │   ├── .env.dev                  // Development environment file
│   │   │   ├── .env.prod                 // Production environment file
│   │   │   ├── .env.staging              // Staging environment file
│   ├── service_locator.dart              // Dependency injection setup (GetIt)
│   ├── no_internet_bloc.dart             // Manages internet connectivity state
│   ├── widgets/                          // ✅ Moved inside core folder
│   │   ├── buttons/
│   │   │   ├── primary_button.dart       // Primary button widget
│   │   │   ├── secondary_button.dart     // Secondary button widget
│   │   ├── dialogs/
│   │   │   ├── confirmation_dialog.dart  // Confirmation dialog widget
│   │   │   ├── error_dialog.dart         // Error dialog widget
│   │   ├── inputs/
│   │   │   ├── text_input_field.dart     // Custom text input field
│   │   │   ├── password_field.dart       // Custom password input field
│   │   ├── loaders/
│   │   │   ├── loading_spinner.dart      // Loading spinner widget
│   │   ├── cards/
│   │   │   ├── info_card.dart            // Generic information card widget
│   │   ├── forms/
│   │   │   ├── custom_form.dart          // Modular form widget
│   │   ├── pages/                        // ✅ Added global shared pages like dialogs
│   │   │   ├── error_page.dart           // Generic error screen
│   │   │   ├── no_internet_page.dart     // No internet connection screen
│
│── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   ├── user_model.dart       // Data model for user
│   │   │   ├── data_sources/
│   │   │   │   ├── auth_remote_data_source.dart // API Calls
│   │   │   ├── repositories/
│   │   │   │   ├── auth_repository_impl.dart   // Implementation of Auth Repository
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── user.dart             // User entity (business logic model)
│   │   │   ├── repositories/
│   │   │   │   ├── auth_repository.dart  // Repository interface
│   │   │   ├── usecases/
│   │   │   │   ├── login_usecase.dart    // Login business logic
│   │   ├── presentation/
│   │   │   ├── bloc/
│   │   │   │   ├── auth_bloc.dart        // Bloc for authentication management
│   │   │   │   ├── auth_event.dart       // Events for authentication
│   │   │   │   ├── auth_state.dart       // States for authentication
│   │   │   ├── pages/
│   │   │   │   ├── login_page.dart       // Login screen UI
│   │   │   ├── widgets/
│   │   │   │   ├── auth_form.dart        // Authentication form widget
│   │   │   ├── validators/
│   │   │   │   ├── auth_validators.dart  // Input validation logic for auth
│   ├── di/
│   │   ├── auth_di.dart                  // Dependency injection for Auth module
│
│── app/
│   ├── routes.dart                        // Manages named routes
│   ├── app.dart                            // App entry point
│   ├── main.dart                           // Runs the app
│   ├── init_dependencies_main.dart         // ✅ Initializes dependencies before app launch
│
│── localization/
│   ├── en.json                            // English language file
│   ├── ar.json                            // Arabic language file
│   ├── es.json                            // Spanish language file
│
│── assets/
│   ├── fonts/
│   │   ├── Roboto-Regular.ttf
│   │   ├── Roboto-Bold.ttf
│   ├── images/
│   │   ├── background.jpg
│   │   ├── logo.png
│   ├── icons/
│   │   ├── svg/
│   │   │   ├── home_icon.svg
│   │   │   ├── profile_icon.svg
│   │   ├── png/
│   │   │   ├── settings_icon.png
│   │   │   ├── logout_icon.png
