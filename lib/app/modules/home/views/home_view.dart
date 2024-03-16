import 'package:flutter/material.dart';
import 'package:flutter_list_anime/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter_list_anime/app/routes/app_pages.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../widgets/loading_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final darkMode = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sukanime',
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
          () => (controller.isLoading.value)
              ? LoadingWidget(
                  color: (darkMode.isDark.value) ? Colors.white : Colors.black,
                  text: "Memuat list Anime....",
                  mediaQuery: MediaQuery.of(context).size.height * 0.9,
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Top Anime",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          InkWell(
                            highlightColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () => Navigator.pushNamed(
                              context,
                              Routes.ALL_TOP_ANIME,
                            ),
                            child: const Text(
                              "Lihat Lainnya",
                              style: TextStyle(
                                fontSize: 15,
                                decoration: TextDecoration.underline,
                                color: Colors.blue,
                                decorationColor: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        childAspectRatio: 1.5 / 2.3,
                      ),
                      padding: const EdgeInsets.all(8.0),
                      itemBuilder: (context, index) {
                        var animeTopCard = controller.animeTopCard[index];
                        return InkWell(
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () => Navigator.pushNamed(
                            context,
                            Routes.DETAIL,
                            arguments: {
                              "id": animeTopCard.malId,
                              "image": animeTopCard.imageUrl,
                              "title": animeTopCard.title,
                              "aired": animeTopCard.airedFrom,
                              "type": animeTopCard.type,
                              "rating": animeTopCard.rating,
                              "score": animeTopCard.score,
                              "member": animeTopCard.members,
                              "youtube": animeTopCard.youtubeUrl,
                            },
                          ),
                          child: Card(
                            elevation: 5,
                            shadowColor: Colors.black,
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      animeTopCard.imageUrl,
                                      fit: BoxFit.cover,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: Text(
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            animeTopCard.title,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        const Flexible(
                                          flex: 1,
                                          child: Icon(
                                            Icons.bookmark_border_outlined,
                                            color: Colors.blue,
                                            size: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: controller.animeTopCard.length,
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Recommendation",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        childAspectRatio: 1.5 / 2.3,
                      ),
                      padding: const EdgeInsets.all(8.0),
                      itemBuilder: (context, index) {
                        var animeRecomCard =
                            controller.animeRecomendCard[index];
                        return InkWell(
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () => Navigator.pushNamed(
                            context,
                            Routes.DETAIL,
                            arguments: {
                              "id": animeRecomCard.malId,
                              "image": animeRecomCard.imageUrl,
                              "title": animeRecomCard.title,
                              "aired": animeRecomCard.airedFrom,
                              "type": animeRecomCard.type,
                              "rating": animeRecomCard.rating,
                              "score": animeRecomCard.score,
                              "member": animeRecomCard.members,
                              "youtube": animeRecomCard.youtubeUrl,
                            },
                          ),
                          child: Card(
                            elevation: 5,
                            shadowColor: Colors.black,
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      animeRecomCard.imageUrl,
                                      fit: BoxFit.cover,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: Text(
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            animeRecomCard.title,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        const Flexible(
                                          flex: 1,
                                          child: Icon(
                                            Icons.bookmark_border_outlined,
                                            color: Colors.blue,
                                            size: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: controller.animeRecomendCard.length,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
