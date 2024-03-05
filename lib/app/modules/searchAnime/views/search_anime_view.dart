import 'package:flutter/material.dart';
import 'package:flutter_list_anime/app/routes/app_pages.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../controllers/search_anime_controller.dart';

class SearchAnimeView extends GetView<SearchAnimeController> {
  const SearchAnimeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Explore',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        shadowColor: Colors.black,
      ),
      body: ListView(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Obx(
              () => Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.only(left: 5),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: TextField(
                      controller: controller.cariAnime,
                      decoration: InputDecoration(
                        focusColor: Colors.white,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        suffixIcon: (controller.isHide.value)
                            ? null
                            : InkWell(
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () => controller.resetInput(),
                                child: const Padding(
                                  padding: EdgeInsets.only(right: 25),
                                  child: Icon(
                                    FontAwesomeIcons.circleXmark,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                        border: InputBorder.none,
                        hintText: "Apa yang ingin kamu cari?",
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 17,
                      ),
                      textInputAction: TextInputAction.search,
                      cursorColor: Colors.black,
                      onChanged: (value) => controller.fetchSearchAnime(value),
                      onSubmitted: (value) =>
                          controller.fetchSearchAnime(value),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  (controller.isLoading.value)
                      ? Column(
                          children: [
                            const SizedBox(
                              height: 130,
                            ),
                            Icon(
                              FontAwesomeIcons.magnifyingGlass,
                              size: 80,
                              color: Colors.grey[800],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Halaman pencarian anime.",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            const Text(
                              "Cari anime kesukaanmu disini!",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        )
                      : GridView.builder(
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
                            var animeSearchCard =
                                controller.cardSearchAnime[index];
                            return InkWell(
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () => Navigator.pushNamed(
                                context,
                                Routes.DETAIL,
                                arguments: {
                                  "id": animeSearchCard.malId,
                                  "image": animeSearchCard.imageUrl,
                                  "title": animeSearchCard.title,
                                  "aired": animeSearchCard.airedFrom,
                                  "type": animeSearchCard.type,
                                  "rating": animeSearchCard.rating,
                                  "score": animeSearchCard.score,
                                  "member": animeSearchCard.members,
                                  "youtube": animeSearchCard.youtubeUrl,
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
                                          animeSearchCard.imageUrl,
                                          fit: BoxFit.cover,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          width:
                                              MediaQuery.of(context).size.width,
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
                                                animeSearchCard.title,
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
                          itemCount: controller.cardSearchAnime.length,
                        ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
