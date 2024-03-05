import 'package:flutter/material.dart';
import 'package:flutter_list_anime/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed(Routes.BOTTOM_BAR);
    });
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.blue,
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/logoAnime.png",
              width: 250,
              height: 250,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "MYNIMELIST",
              style: TextStyle(fontSize: 32, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
