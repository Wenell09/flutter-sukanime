import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  var isDark = false.obs;
  bool get isDarkMode => isDark.value;
  final userName = "".obs;
  final userEmail = "".obs;
  final userImage = "".obs;

  setUserDetails(String name, String email, String image) async {
    final prefs = await SharedPreferences.getInstance();
    userName.value = name;
    userEmail.value = email;
    userImage.value = image;
    prefs.setString('displayName', name);
    prefs.setString('email', email);
    prefs.setString('photoURL', image);
  }

  getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final nama = prefs.getString("displayName") ?? "";
    final email = prefs.getString("email") ?? "";
    final image = prefs.getString("photoURL") ?? "";
    userName.value = nama;
    userEmail.value = email;
    userImage.value = image;
  }

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
    getUser();
    super.onInit();
  }
}
