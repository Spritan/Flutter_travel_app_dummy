import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  final RxList<Map<String, dynamic>> notifications =
      <Map<String, dynamic>>[].obs;
  final RxString searchQuery = ''.obs;
  final RxBool isSearching = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/data/notifications.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      notifications.assignAll(
          List<Map<String, dynamic>>.from(jsonData['notifications']));
    } catch (e) {
      print('Error loading notifications: $e');
    }
  }

  List<Map<String, dynamic>> get filteredNotifications {
    if (searchQuery.isEmpty) return notifications;
    return notifications.where((notification) {
      final title = notification['title'].toString().toLowerCase();
      final message = notification['message'].toString().toLowerCase();
      final query = searchQuery.value.toLowerCase();
      return title.contains(query) || message.contains(query);
    }).toList();
  }

  void toggleSearch() {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) {
      searchQuery.value = '';
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  void markAsRead(String id) {
    final index = notifications.indexWhere((n) => n['id'] == id);
    if (index != -1) {
      final notification = Map<String, dynamic>.from(notifications[index]);
      notification['isRead'] = true;
      notifications[index] = notification;
    }
  }
}
