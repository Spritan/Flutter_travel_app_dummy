import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../data/models/travel_package.dart';
import '../../controllers/search_controller.dart';

class HomeController extends BaseSearchController {
  final RxList<TravelPackage> packages = <TravelPackage>[].obs;
  final RxList<TravelPackage> filteredPackages = <TravelPackage>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTravelPackages();
    ever(searchQuery, filterPackages);
  }

  Future<void> loadTravelPackages() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/data/travel_packages.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> packageList = jsonData['packages'];

      packages.assignAll(
        packageList.map((json) => TravelPackage.fromJson(json)).toList(),
      );
      filteredPackages.assignAll(packages);
    } catch (e) {
      print('Error loading travel packages: $e');
    }
  }

  void filterPackages(String query) {
    if (query.isEmpty) {
      filteredPackages.assignAll(packages);
    } else {
      filteredPackages.assignAll(
        packages
            .where((package) =>
                package.name.toLowerCase().contains(query.toLowerCase()) ||
                package.location.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      );
    }
  }
}
