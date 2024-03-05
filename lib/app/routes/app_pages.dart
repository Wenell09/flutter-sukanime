import 'package:get/get.dart';

import '../modules/allTopAnime/bindings/all_top_anime_binding.dart';
import '../modules/allTopAnime/views/all_top_anime_view.dart';
import '../modules/bottomBar/bindings/bottom_bar_binding.dart';
import '../modules/bottomBar/views/bottom_bar_view.dart';
import '../modules/detail/views/detail_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/searchAnime/bindings/search_anime_binding.dart';
import '../modules/searchAnime/views/search_anime_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOM_BAR,
      page: () => const BottomBarView(),
      binding: BottomBarBinding(),
    ),
    GetPage(
      name: _Paths.ALL_TOP_ANIME,
      page: () => const AllTopAnimeView(),
      binding: AllTopAnimeBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL,
      page: () => const DetailView(),
    ),
    GetPage(
      name: _Paths.SEARCH_ANIME,
      page: () => const SearchAnimeView(),
      binding: SearchAnimeBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
  ];
}
