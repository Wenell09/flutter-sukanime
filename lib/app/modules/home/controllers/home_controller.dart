import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_list_anime/app/data/base/base_url.dart';
import 'package:flutter_list_anime/app/data/models/anime_model.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;

class HomeController extends GetxController {
  var isLoading = true.obs;
  var animeTopCard = <AnimeModel>[].obs;
  var animeRecomendCard = <AnimeModel>[].obs;

  Future<void> fetchTopAnime() async {
    try {
      var response = await http.get(Uri.parse("$baseUrl/top/anime?limit=6"));
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)["data"];
        animeTopCard.value = result.map((e) => AnimeModel.fromJson(e)).toList();
        isLoading.value = !isLoading.value;
      }
    } catch (e) {
      debugPrint("Gagal fetch $e");
    }
  }

  Future<void> fetchRecomAnime() async {
    try {
      var response = await http.get(Uri.parse(
          "$baseUrl/top/anime?rating=r17&limit=25&filter=bypopularity"));
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)["data"];
        animeRecomendCard.value =
            result.map((e) => AnimeModel.fromJson(e)).toList();
      }
    } catch (e) {
      debugPrint("Gagal fetch $e");
    }
  }

  @override
  void onInit() {
    fetchTopAnime();
    fetchRecomAnime();
    super.onInit();
  }
}
