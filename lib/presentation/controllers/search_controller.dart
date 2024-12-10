import 'package:get/get.dart';

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
