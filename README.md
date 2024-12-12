# Flutter Travel App

A modern Flutter travel application built with GetX state management, featuring travel packages, blogs, and a clean architecture pattern.

## 🌟 Features & Implementation Details

### Navigation System
- **GetX Navigation**: Implemented using `Get.toNamed()` for route management
- **Bottom Navigation**: Custom implementation with `IndexedStack` for state preservation
- **Route Management**: Centralized in `app_pages.dart` with named routes
```dart
class AppPages {
  static const initial = Routes.main;
  static final routes = [
    GetPage(
      name: Routes.main,
      page: () => const MainNavigationScreen(),
      binding: NavigationBinding(),
    ),
  ];
}
```

### State Management
- **GetX Controllers**: Reactive state management using `.obs` variables
- **Controller Bindings**: Dependency injection through `NavigationBinding`
```dart
class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NavigationController());
    Get.put(HomeController());
    Get.put(ExploreController());
    Get.put(ThemeController());
    Get.put(NotificationsController());
    Get.put(ProfileController());
  }
}
```

### Search & Filtering Implementation
- **Base Search Controller**: Reusable search functionality
```dart
class BaseSearchController extends GetxController {
  final RxString searchQuery = ''.obs;
  final RxBool isSearching = false.obs;

  void onSearchChanged(String query) {
    searchQuery.value = query;
  }

  void toggleSearch() {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) {
      searchQuery.value = '';
    }
  }
}
```

### Travel Packages Feature
- **Data Model**:
```dart
class TravelPackage {
  final String id;
  final String name;
  final String description;
  final double price;
  final String duration;
  final String imageUrl;
  final List<String> highlights;
  final String location;
  final double rating;
}
```
- **Filtering Categories**: 
  - All
  - Popular
  - Recent
  - Trending

### Blog Section Implementation
- **Blog Model**:
```dart
class BlogPost {
  final String id;
  final String title;
  final String excerpt;
  final String content;
  final String author;
  final String imageUrl;
  final String date;
  final List<String> tags;
  final int readTime;
}
```
- **Category Filtering**:
  - All
  - Adventure
  - Culture
  - Food
  - Tips

### Theme Management
- **Dynamic Theme Switching**: Implemented using GetX
```dart
class ThemeController extends GetxController {
  final RxBool isDarkMode = false.obs;
  
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}
```

### Screen Implementations

#### Home Screen
- Featured packages display
- Category filtering
- Search integration
- Responsive grid layout

#### Explore Screen
- Combined view of packages and blogs
- Toggle between content types
- Advanced filtering options
- Search functionality

#### Profile Screen
- User information display
- Editable fields
- Travel statistics
- Preferences management

#### Settings Screen
- Theme toggle implementation
- Navigation to sub-screens
- User preferences management

## 🏗️ Project Structure

```
lib/
├── data/
│   └── models/              # Data models
│       ├── travel_package.dart
│       └── blog_post.dart
├── presentation/
│   ├── bindings/           # Dependency injection
│   │   └── navigation_binding.dart
│   ├── controllers/        # State management
│   │   ├── navigation_controller.dart
│   │   ├── theme_controller.dart
│   │   ├── profile_controller.dart
│   │   ├── notifications_controller.dart
│   │   └── explore_controller.dart
│   ├── routes/            # Navigation
│   │   └── app_pages.dart
│   ├── screens/           # UI components
│   │   ├── home/
│   │   ├── explore/
│   │   ├── notifications/
│   │   ├── profile/
│   │   └── settings/
│   └── theme/            # App theming
│       └── app_theme.dart
└── assets/
    └── data/             # Mock JSON data
```

## 🛠️ Technical Implementation

### GetX Helpers & Extensions
- **Reactive State**: Using `.obs` for reactive variables
- **GetView**: Base class for views with controller access
- **GetBuilder**: For non-reactive state management
- **Bindings**: Dependency injection setup

### Navigation Patterns
```dart
// Named route navigation
Get.toNamed('/explore', arguments: {'category': 'adventure'});

// Back navigation with data
Get.back(result: selectedItem);

// Snackbar display
Get.snackbar('Title', 'Message');
```

### Theme Implementation
```dart
class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      primaryColor: Colors.blue,
      appBarTheme: const AppBarTheme(
        elevation: 0,
      ),
    );
  }
}
```

### Data Management
- JSON data loading from assets
- Model parsing and serialization
- State persistence using GetX

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (^3.5.4)
- GetX (^4.6.6)
- Dart SDK (latest stable)

### Installation

1. Clone the repository
```bash
git clone https://github.com/Spritan/Flutter_travel_app_dummy.git
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the app
```bash
flutter run
```

## 📱 Platform Support

- iOS (untested)
- Android 

## 🔧 Development Guidelines

### State Management Rules
1. Use `.obs` for reactive state
2. Implement controllers for each feature
3. Use `GetView` for screens with single controller
4. Implement proper dispose methods

### Code Organization
1. Feature-based directory structure
2. Separate business logic from UI
3. Reusable widgets in shared directory
4. Constants in dedicated files

### Error Handling
```dart
try {
  // Operation
} catch (e) {
  Get.snackbar(
    'Error',
    e.toString(),
    snackPosition: SnackPosition.BOTTOM,
  );
}
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## 📄 License

This project is licensed under the MIT License.

## 👥 Authors

- Initial work - [Spritan](https://github.com/Spritan)

## 📞 Support

For support, create an issue in the repository.
