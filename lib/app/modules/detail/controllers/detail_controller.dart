import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_list_anime/app/data/base/base_url.dart';
import 'package:flutter_list_anime/app/data/models/anime_model.dart';
import 'package:flutter_list_anime/app/data/models/character_model.dart';
import 'package:flutter_list_anime/app/data/models/recommendation_model.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;
import 'package:intl/intl.dart';

class DetailController extends GetxController {
  var isLoading = true.obs;
  var isLoadingFavorite = false.obs;
  var malId = Get.arguments;
  var detailAnime = <AnimeModel>[].obs;
  var charaAnime = <CharacterModel>[].obs;
  var recomenAnime = <RecommendationModel>[].obs;
  var inputReview = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<AnimeModel>> fetchDetailAnime(int id) async {
    try {
      var response = await http.get(Uri.parse("$baseUrl/anime/$id"));
      if (response.statusCode == 200) {
        final Map<String, dynamic> result = jsonDecode(response.body)["data"];
        detailAnime.value = [AnimeModel.fromJson(result)];
        isLoading.value = false;
      }
    } catch (e) {
      debugPrint("Gagal fetch : $e");
    }
    return detailAnime;
  }

  Future<List<CharacterModel>> fetchCharacter(int id) async {
    try {
      final response =
          await http.get(Uri.parse("$baseUrl/anime/$id/characters"));
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)["data"];
        charaAnime.value =
            result.map((json) => CharacterModel.fromJson(json)).toList();
      } else {
        debugPrint("gagal get character");
      }
    } catch (e) {
      debugPrint("error:$e");
    }
    return charaAnime;
  }

  Future<List<RecommendationModel>> fetchRecomenAnime(int id) async {
    try {
      final response =
          await http.get(Uri.parse("$baseUrl/anime/$id/recommendations"));
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)["data"];
        recomenAnime.value =
            result.map((json) => RecommendationModel.fromJson(json)).toList();
      } else {
        debugPrint("gagal get recomen");
      }
    } catch (e) {
      debugPrint("error:$e");
    }
    return recomenAnime;
  }

  Future<void> addReview(
    int malId,
    String title,
    String profilePicture,
    String username,
    String isiReview,
  ) async {
    CollectionReference reviews = firestore.collection("reviews_$title");
    reviews.add({
      "malId": malId,
      "title": title,
      "username": username,
      "profilePicture": profilePicture,
      "isiReview": isiReview,
      "timestamp": FieldValue.serverTimestamp(),
    });
    inputReview.text = "";
  }

  String formatDate(String dateString) {
    final DateTime dateTime = DateTime.parse(dateString);
    final DateFormat formatter = DateFormat('dd MMMM yyyy');
    return formatter.format(dateTime);
  }

  String formatMonth(String dateString) {
    final DateTime dateTime = DateTime.parse(dateString);
    final DateFormat formatter = DateFormat('MMMM yyyy');
    return formatter.format(dateTime);
  }

  String cutString(String inputString) {
    int index = inputString.indexOf('-');
    if (index != -1) {
      return inputString.substring(0, index).trim();
    } else {
      return inputString;
    }
  }

  double convertScoreToRating(double score) {
    // Menggunakan pembulatan ke bawah untuk mendapatkan peringkat 1-5
    double rating = (score / 2).clamp(1.0, 5.0);
    return double.parse(rating.toStringAsFixed(1));
  }

  @override
  void onInit() {
    fetchDetailAnime(malId);
    fetchCharacter(malId);
    fetchRecomenAnime(malId);
    super.onInit();
  }
}
