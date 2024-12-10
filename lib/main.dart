import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:flutter_voice_nav/presentation/theme/app_theme.dart';
import 'package:flutter_voice_nav/presentation/routes/app_pages.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Your App Name',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
