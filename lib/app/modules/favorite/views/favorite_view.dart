import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_list_anime/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_list_anime/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter_list_anime/app/modules/widgets/loading_widget.dart';
import 'package:flutter_list_anime/app/modules/widgets/nointernet_widget.dart';
import 'package:flutter_list_anime/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/favorite_controller.dart';

class FavoriteView extends GetView<FavoriteController> {
  const FavoriteView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final profile = Get.put(ProfileController());
    final home = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Favorite's",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        shadowColor: Colors.black,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Obx(
          () => (controller.connectionType.value == 0)
              ? const NoInternet()
              : (controller.isLoading.value)
                  ? LoadingWidget(
                      color:
                          (profile.isDark.value) ? Colors.white : Colors.black,
                      text: "Memuat list Anime....",
                      mediaQuery: MediaQuery.of(context).size.height * 0.9,
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(8.0),
                      itemBuilder: (context, index) {
                        var favoriteAnime = home.favoritesList[index];
                        return InkWell(
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () => Navigator.pushNamed(
                            context,
                            Routes.DETAIL,
                            arguments: {
                              "id": favoriteAnime["malId"],
                              "image": favoriteAnime["imageUrl"],
                              "title": favoriteAnime["title"],
                              "aired": favoriteAnime["airedFrom"],
                              "type": favoriteAnime["type"],
                              "rating": favoriteAnime["rating"],
                              "score": favoriteAnime["score"],
                              "member": favoriteAnime["member"],
                              "youtube": favoriteAnime["youtubeUrl"],
                            },
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Card(
                              elevation: 5,
                              shadowColor: Colors.black,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.network(
                                          favoriteAnime["imageUrl"],
                                          fit: BoxFit.cover,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              flex: 1,
                                              child: Text(
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                favoriteAnime["title"]
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Flexible(
                                              flex: 1,
                                              child: Text(
                                                maxLines: 1,
                                                controller.formatMonth(
                                                    favoriteAnime["airedFrom"]
                                                        .toString()),
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: home.favoritesList.length,
                    ),
        ),
      ),
    );
  }
}