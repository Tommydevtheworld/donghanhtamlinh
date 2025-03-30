# donghanhtamlinh

A modern Flutter application using Riverpod for state management with a clean, feature-based architecture.

## Project Structure

The project follows a clean architecture approach with feature-based organization:

```
lib/
├── core/                 # App-wide fundamentals
│   ├── constants/        # Global constants (colors, strings, etc.)
│   ├── utils/            # Helper functions/utilities
│   ├── styles/           # Themes, text styles, app decorations
│   ├── routes/           # Navigation configuration (routes.dart)
│   └── errors/           # Error handling classes
│
├── features/             # Feature-based modules
│   └── feature_name/     # Each feature as isolated module
│       ├── presentation/
│       │   ├── widgets/  # Feature-specific widgets
│       │   └── screens/  # Full-page views
│       ├── domain/       # Business logic (models, entities)
│       ├── data/         # Data sources (local/remote)
│       └── provider/     # State management (Riverpod providers)
│
├── shared/               # Reusable across features
│   ├── components/       # Global widgets (buttons, cards, etc.)
│   ├── services/         # API clients, databases, 3rd-party integrations
│   └── dependencies/     # Dependency injection setup
│
├── assets/               # Media files
│   ├── images/
│   ├── fonts/
│   └── lottie/
│
└── main.dart             # App entry point
```

## Getting Started

### Prerequisites

- Flutter (latest stable version)
- Dart SDK
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository:
```bash
git clone https://github.com/****/donghanhtamlinh.git
```

2. Navigate to the project directory:
```bash
cd donghanhtamlinh
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the app:
```bash
flutter run
```

## Key Dependencies

- **flutter_riverpod**: State management solution
- **go_router** (recommended): Advanced routing and navigation
- **dio** (recommended): HTTP client for API requests
- **hive** (optional): Local database for persistent storage

## Features

- Clean, maintainable architecture
- Riverpod state management
- Feature-based organization
- Reusable components
- Consistent theming and styling

## Development Guidelines

- Place feature-specific code within the feature's directory
- Keep shared components in the shared directory
- Maintain separation of concerns with presentation, domain, and data layers
- Use providers for state management and dependency injection

## Resources

For Flutter development resources:
- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- [Online documentation](https://docs.flutter.dev/)
- [Riverpod documentation](https://riverpod.dev/docs/introduction/getting_started)

## Local Storage with Hive

### Setup

```bash
flutter pub add hive hive_flutter
flutter pub add -d hive_generator build_runner
```

Initialize in main.dart:
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // Register adapters
  runApp(const ProviderScope(child: MyApp()));
}
```

### Usage

1. Create models with Hive annotations:

```dart
@HiveType(typeId: 1)
class ExampleModel {
  @HiveField(0)
  final String id;
  
  // Other fields...
}
```

2. Generate adapters:
```bash
flutter pub run build_runner build
```

3. Basic operations:
```dart
// Open a box
final box = await Hive.openBox<ExampleModel>('examples');

// CRUD operations
await box.put('key1', model);         // Create/Update
final model = box.get('key1');        // Read
final allModels = box.values.toList(); // Read all
await box.delete('key1');             // Delete
```

4. With Riverpod:
```dart
final exampleProvider = StateNotifierProvider<ExampleNotifier, List<ExampleModel>>((ref) {
  return ExampleNotifier();
});

class ExampleNotifier extends StateNotifier<List<ExampleModel>> {
  // Implement methods that interact with Hive
}
```


