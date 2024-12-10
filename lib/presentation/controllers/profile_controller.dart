import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final Rx<Map<String, dynamic>> userData = Rx<Map<String, dynamic>>({});
  final isLoading = true.obs;
  final isEditing = false.obs;

  // Temporary values for editing
  final nameController = TextEditingController();
  final bioController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadProfileData();
  }

  @override
  void onClose() {
    nameController.dispose();
    bioController.dispose();
    emailController.dispose();
    super.onClose();
  }

  Future<void> loadProfileData() async {
    try {
      isLoading.value = true;
      final String jsonString =
          await rootBundle.loadString('assets/data/profile.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      userData.value = jsonData['user'];
      _initializeControllers();
    } catch (e) {
      print('Error loading profile data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _initializeControllers() {
    nameController.text = userData.value['name'] ?? '';
    bioController.text = userData.value['bio'] ?? '';
    emailController.text = userData.value['email'] ?? '';
  }

  void toggleEditing() {
    if (isEditing.value) {
      // Save changes
      final updatedData = Map<String, dynamic>.from(userData.value);
      updatedData['name'] = nameController.text;
      updatedData['bio'] = bioController.text;
      updatedData['email'] = emailController.text;
      userData.value = updatedData;
    } else {
      // Start editing - reset controllers to current values
      _initializeControllers();
    }
    isEditing.toggle();
  }

  void updatePreference(String key, String value) {
    final updatedData = Map<String, dynamic>.from(userData.value);
    final preferences =
        Map<String, dynamic>.from(updatedData['preferences'] ?? {});
    preferences[key] = value;
    updatedData['preferences'] = preferences;
    userData.value = updatedData;
  }

  Map<String, dynamic> get stats => userData.value['stats'] ?? {};
  Map<String, dynamic> get preferences => userData.value['preferences'] ?? {};
  List<dynamic> get recentActivity => userData.value['recentActivity'] ?? [];
}
