import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_list_anime/app/data/base/base_url.dart';
import 'package:flutter_list_anime/app/data/models/anime_model.dart';
import 'package:flutter_list_anime/app/modules/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;
import 'package:connectivity_plus/connectivity_plus.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;
  var animeTopCard = <AnimeModel>[].obs;
  var animeRecomendCard = <AnimeModel>[].obs;
  RxList<Map<String, dynamic>> favoritesList = RxList<Map<String, dynamic>>();
  var connectionType = 0.obs;
  late StreamSubscription streamSubscription;
  final Connectivity connectivity = Connectivity();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> fetchTopAnime() async {
    try {
      var response = await http.get(Uri.parse("$baseUrl/top/anime?limit=6"));
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)["data"];
        animeTopCard.value = result.map((e) => AnimeModel.fromJson(e)).toList();
        isLoading.value = false;
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

  void addFavorites(
    String id,
    String username,
    int malId,
    String title,
    String imageUrl,
    String airedFrom,
  ) async {
    CollectionReference favorites = firestore.collection("favorites_$username");
    favorites.add({
      "id": id,
      "username": username,
      "malId": malId,
      "title": title,
      "imageUrl": imageUrl,
      "airedFrom": airedFrom,
      "createdAt": FieldValue.serverTimestamp(),
    });
    getFavorites(username);
  }

  void deleteFavorites(String id, String username, int malId) async {
    QuerySnapshot favoritesSnapshot = await firestore
        .collection("favorites_$username")
        .where("id", isEqualTo: id)
        .where("malId", isEqualTo: malId)
        .get();

    // Loop through the documents to delete each matching document
    for (QueryDocumentSnapshot doc in favoritesSnapshot.docs) {
      doc.reference.delete();
    }
    getFavorites(username);
  }

  Future<void> getFavorites(String username) async {
    QuerySnapshot favoritesSnapshot = await FirebaseFirestore.instance
        .collection("favorites_$username")
        .get();
    favoritesList.assignAll(
      favoritesSnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList(),
    );
  }

  Future<void> getConnectivityType() async {
    late ConnectivityResult connectivityResult;
    try {
      connectivityResult = await (connectivity.checkConnectivity());
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return updateState(connectivityResult);
  }

  updateState(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionType.value = 1;
        if (animeTopCard.isEmpty || animeRecomendCard.isEmpty) {
          await fetchTopAnime();
          await fetchRecomAnime();
        }
        break;
      case ConnectivityResult.mobile:
        connectionType.value = 2;
        if (animeTopCard.isEmpty || animeRecomendCard.isEmpty) {
          await fetchTopAnime();
          await fetchRecomAnime();
        }
        break;
      case ConnectivityResult.none:
        connectionType.value = 0;
        break;
      default:
        Get.snackbar("Error", "Failed to get connection type");
        break;
    }
  }

  @override
  void onInit() async {
    streamSubscription = connectivity.onConnectivityChanged.listen(updateState);
    await getConnectivityType();
    if (connectionType.value != 0) {
      await fetchTopAnime();
      await fetchRecomAnime();
      await getFavorites(ProfileController.userName.value);
    }
    super.onInit();
  }

  @override
  void onClose() {
    streamSubscription.cancel();
    super.onClose();
  }
}
