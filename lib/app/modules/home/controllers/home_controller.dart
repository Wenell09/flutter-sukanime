import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_list_anime/app/data/base/base_url.dart';
import 'package:flutter_list_anime/app/data/models/anime_top_card.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;

class HomeController extends GetxController {
  var isLoading = true.obs;
  var animeTopCard = <AnimeTopCard>[].obs;
  var searchAnime = TextEditingController();

  Future<void> fetchTopAnime() async {
    try {
      var response = await http.get(Uri.parse("$baseUrl/top/anime"));
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)["data"];
        animeTopCard.value =
            result.map((e) => AnimeTopCard.fromJson(e)).toList();
        isLoading.value = false;
      }
    } catch (e) {
      debugPrint("Gagal fetch $e");
    }
  }

  @override
  void onInit() {
    fetchTopAnime();
    super.onInit();
  }
}
