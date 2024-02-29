import 'package:get/get.dart';

import '../controllers/all_top_anime_controller.dart';

class AllTopAnimeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllTopAnimeController>(
      () => AllTopAnimeController(),
    );
  }
}
