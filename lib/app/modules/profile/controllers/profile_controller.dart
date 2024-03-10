import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  var isDark = false.obs;
  bool get isDarkMode => isDark.value;

  darkMode(value) {
    if (value == true) {
      isDark.value = true;
      Get.changeTheme(ThemeData.dark());
    } else {
      isDark.value = false;
      Get.changeTheme(ThemeData.light());
    }
  }

  Future<void> loadDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    final getDarkMode = prefs.getBool('darkmode') ?? false;
    isDark.value = getDarkMode;
    Get.changeTheme(getDarkMode ? ThemeData.dark() : ThemeData.light());
  }

  @override
  void onInit() {
    loadDarkMode();
    super.onInit();
  }
}
