import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_list_anime/app/data/base/base_url.dart';
import 'package:flutter_list_anime/app/data/models/anime_top.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;

class AllTopAnimeController extends GetxController {
  var isLoading = true.obs;
  var allTopAnime = <AnimeTop>[].obs;
  var currentPage = 1.obs;

  Future<void> fetchAllTopAnime(int page) async {
    try {
      var response = await http.get(Uri.parse("$baseUrl/top/anime?page=$page"));
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)["data"];
        allTopAnime.value = result.map((e) => AnimeTop.fromJson(e)).toList();
        isLoading.value = false;
        currentPage.value = page;
      }
    } catch (e) {
      debugPrint("Gagal fetch $e");
    }
  }

  // Fungsi untuk mengambil halaman berikutnya
  Future<void> fetchNextPage() async {
    isLoading.value = true;
    await fetchAllTopAnime(currentPage.value + 1);
  }

  // Fungsi untuk mengambil halaman sebelumnya
  Future<void> fetchPreviousPage() async {
    isLoading.value = true;
    if (currentPage.value > 1) {
      await fetchAllTopAnime(currentPage.value - 1);
    }
  }

  @override
  void onInit() {
    fetchAllTopAnime(1);
    super.onInit();
  }
}
