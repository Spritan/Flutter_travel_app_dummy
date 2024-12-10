import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_voice_nav/presentation/controllers/search_controller.dart';
import 'package:get/get.dart';
import '../../../data/models/travel_package.dart';
import '../../../data/models/blog_post.dart';

class ExploreController extends BaseSearchController {
  final RxList<TravelPackage> packages = <TravelPackage>[].obs;
  final RxList<BlogPost> blogs = <BlogPost>[].obs;
  final RxList<dynamic> filteredItems = <dynamic>[].obs;
  final RxString selectedCategory = 'All'.obs;
  final RxBool showingPackages = true.obs;

  final List<String> packageCategories = [
    'All',
    'Popular',
    'Recent',
    'Trending'
  ];
  final List<String> blogCategories = [
    'All',
    'Adventure',
    'Culture',
    'Food',
    'Tips'
  ];

  void _filterPackages() {
    List<TravelPackage> filtered = packages.toList();
    if (searchQuery.value.isNotEmpty) {
      filtered = filtered
          .where((package) =>
              package.name
                  .toLowerCase()
                  .contains(searchQuery.value.toLowerCase()) ||
              package.location
                  .toLowerCase()
                  .contains(searchQuery.value.toLowerCase()))
          .toList();
    }
    filteredItems.assignAll(filtered);
  }

  void _filterBlogs() {
    List<BlogPost> filtered = blogs.toList();
    if (searchQuery.value.isNotEmpty) {
      filtered = filtered
          .where((blog) =>
              blog.title
                  .toLowerCase()
                  .contains(searchQuery.value.toLowerCase()) ||
              blog.content
                  .toLowerCase()
                  .contains(searchQuery.value.toLowerCase()))
          .toList();
    }
    if (selectedCategory.value != 'All') {
      filtered = filtered
          .where((blog) => blog.tags.contains(selectedCategory.value))
          .toList();
    }
    filteredItems.assignAll(filtered);
  }

  void filterItems([String? query]) {
    if (showingPackages.value) {
      _filterPackages();
    } else {
      _filterBlogs();
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadData();
    ever(searchQuery, filterItems);
    ever(selectedCategory, filterItems);
    ever(showingPackages, (_) {
      selectedCategory.value = 'All';
      filterItems();
    });
  }

  Future<void> loadData() async {
    await Future.wait([
      loadPackages(),
      loadBlogs(),
    ]);
    filterItems();
  }

  Future<void> loadPackages() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/data/travel_packages.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> packageList = jsonData['packages'];
      packages.assignAll(
          packageList.map((json) => TravelPackage.fromJson(json)).toList());
    } catch (e) {
      print('Error loading packages: $e');
    }
  }

  Future<void> loadBlogs() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/data/blog_posts.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> blogList = jsonData['posts'];
      blogs.assignAll(blogList.map((json) => BlogPost.fromJson(json)).toList());
    } catch (e) {
      print('Error loading blogs: $e');
    }
  }

  void changeCategory(String category) {
    selectedCategory.value = category;
  }

  void toggleView() {
    showingPackages.value = !showingPackages.value;
  }
}
