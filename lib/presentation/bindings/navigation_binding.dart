import 'package:flutter_voice_nav/presentation/screens/home/home_controller.dart';
import 'package:get/get.dart';
import '../controllers/navigation_controller.dart';
import '../controllers/theme_controller.dart';
import '../controllers/explore_controller.dart';
import '../controllers/notifications_controller.dart';
import '../controllers/profile_controller.dart';

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
