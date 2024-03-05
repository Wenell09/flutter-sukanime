import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_list_anime/app/data/base/base_url.dart';
import 'package:flutter_list_anime/app/data/models/anime_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SearchAnimeController extends GetxController {
  final cariAnime = TextEditingController();
  final cardSearchAnime = <AnimeModel>[].obs;
  var isLoading = true.obs;
  var isHide = true.obs;

  Future<void> fetchSearchAnime(String keyword) async {
    try {
      var response =
          await http.get(Uri.parse("$baseUrl/anime?q=$keyword&sfw=true"));
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)["data"];
        cardSearchAnime.value =
            result.map((e) => AnimeModel.fromJson(e)).toList();
        isLoading.value = false;
        isHide.value = false;
        if (keyword == "" || cariAnime.text == "") {
          resetInput();
        }
      }
    } catch (e) {
      debugPrint("Error : $e");
    }
  }

  void resetInput() {
    cariAnime.clear();
    cardSearchAnime.clear();
    isLoading.value = true;
    isHide.value = true;
  }
}
