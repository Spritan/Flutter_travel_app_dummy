import 'package:get/get.dart';
import '../screens/main_navigation_screen.dart';
import '../bindings/navigation_binding.dart';

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

abstract class Routes {
  static const main = '/';
}
