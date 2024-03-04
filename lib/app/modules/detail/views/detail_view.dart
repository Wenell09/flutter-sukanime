import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_list_anime/app/modules/detail/controllers/detail_controller.dart';
import 'package:flutter_list_anime/app/modules/detail/widgets/card_detail.dart';
import 'package:flutter_list_anime/app/modules/detail/widgets/isi_detail.dart';
import 'package:flutter_list_anime/app/modules/widgets/loading_widget.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:readmore/readmore.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailView extends StatelessWidget {
  const DetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DetailController());
    final argument = Get.arguments;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(310),
          child: AppBar(
            title: const Text(
              'Community',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            shadowColor: Colors.black,
            flexibleSpace: SafeArea(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 35,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  argument["image"],
                                  fit: BoxFit.cover,
                                  width: 140,
                                  height: 200,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                argument["title"],
                                maxLines: 2,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "${controller.formatMonth(argument["aired"])} • ${argument["type"]} • ${controller.cutString(argument["rating"])}",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                "★ ${controller.convertScoreToRating(argument["score"])} Community Rating",
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                "${argument["member"]} Members Watching",
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            bottom: const TabBar(
              labelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
              indicatorColor: Colors.blue,
              overlayColor: MaterialStatePropertyAll(Colors.transparent),
              tabs: [
                Tab(
                  text: "Details",
                ),
                Tab(
                  text: "Trailers",
                ),
                Tab(
                  text: "Reviews",
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ListView(
              children: [
                SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Obx(
                    () => (controller.isLoading.value)
                        ? LoadingWidget(
                            text: "loading data....",
                            mediaQuery:
                                MediaQuery.of(context).size.height * 0.5,
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var detailAnime = controller.detailAnime[index];
                              List<String> genreNames = [];
                              for (var genre in detailAnime.genres) {
                                genreNames.add(genre['name']);
                              }
                              return (argument["id"] != detailAnime.malId)
                                  ? const Center(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Icon(
                                            Icons.dangerous_outlined,
                                            color: Colors.blue,
                                            size: 130,
                                          ),
                                          Text(
                                            "Data tidak ditemukan !",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            "User menekan dengan cepat, ulangi kembali!",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          )
                                        ],
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CardDetail(
                                                iconData: FontAwesomeIcons
                                                    .rankingStar,
                                                title: "Rank",
                                                isi:
                                                    detailAnime.rank.toString(),
                                                color: Colors.blue,
                                              ),
                                              CardDetail(
                                                iconData: FontAwesomeIcons.pen,
                                                color: Colors.grey,
                                                title: "Score",
                                                isi: detailAnime.score
                                                    .toString(),
                                              ),
                                              CardDetail(
                                                iconData: FontAwesomeIcons.fire,
                                                color: Colors.green,
                                                title: "Popularity",
                                                isi: detailAnime.popularity
                                                    .toString(),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Text(
                                            "Details",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.95,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[50],
                                              borderRadius:
                                                  BorderRadiusDirectional
                                                      .circular(5),
                                            ),
                                            child: Column(
                                              children: [
                                                IsiDetail(
                                                  title: "Title English • ",
                                                  isi: detailAnime.titleEnglish,
                                                ),
                                                IsiDetail(
                                                  title: "Title Japanese • ",
                                                  isi:
                                                      detailAnime.titleJapanese,
                                                ),
                                                IsiDetail(
                                                  title: "Total Episode • ",
                                                  isi: detailAnime.episodes
                                                      .toString(),
                                                ),
                                                IsiDetail(
                                                  title: "Duration • ",
                                                  isi: detailAnime.duration,
                                                ),
                                                IsiDetail(
                                                  title: "Type • ",
                                                  isi: detailAnime.type,
                                                ),
                                                IsiDetail(
                                                  title: "Season • ",
                                                  isi: detailAnime.season,
                                                ),
                                                IsiDetail(
                                                  title: "Year • ",
                                                  isi: detailAnime.year
                                                      .toString(),
                                                ),
                                                IsiDetail(
                                                  title: "Status • ",
                                                  isi: detailAnime.status,
                                                ),
                                                IsiDetail(
                                                  title: "Aired Date(s) • ",
                                                  isi: controller.formatDate(
                                                      detailAnime.airedFrom),
                                                ),
                                                (detailAnime.airedTo.isEmpty)
                                                    ? Container()
                                                    : IsiDetail(
                                                        title:
                                                            "Date(s) Completed • ",
                                                        isi: controller
                                                            .formatDate(
                                                                detailAnime
                                                                    .airedTo),
                                                      ),
                                                IsiDetail(
                                                  title: "Studio • ",
                                                  isi: detailAnime.studios[0]
                                                          ["name"] ??
                                                      "",
                                                ),
                                                (detailAnime
                                                        .demographics.isEmpty)
                                                    ? IsiDetail(
                                                        title: "Genre • ",
                                                        isi: genreNames
                                                            .join(", "),
                                                      )
                                                    : IsiDetail(
                                                        title: "Genre • ",
                                                        isi:
                                                            "${detailAnime.demographics[0]["name"]}, ${genreNames.join(", ")}",
                                                      ),
                                                IsiDetail(
                                                  title: "Rating • ",
                                                  isi: detailAnime.rating,
                                                ),
                                                IsiDetail(
                                                  title: "Favorites • ",
                                                  isi:
                                                      "${detailAnime.favorites.toString()} Person",
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                ReadMoreText(
                                                  detailAnime.synopsis,
                                                  trimLines: 5,
                                                  trimMode: TrimMode.Line,
                                                  trimCollapsedText: "More",
                                                  trimExpandedText: "Hide",
                                                  lessStyle: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue,
                                                    fontSize: 15,
                                                  ),
                                                  moreStyle: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue,
                                                    fontSize: 15,
                                                  ),
                                                  textAlign: TextAlign.justify,
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                            },
                            itemCount: controller.detailAnime.length,
                          ),
                  ),
                ),
              ],
            ),
            ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: YoutubePlayer(
                    controller: controller.youtubeController,
                    showVideoProgressIndicator: true,
                    bottomActions: [
                      CurrentPosition(),
                      ProgressBar(
                        isExpanded: true,
                        colors: const ProgressBarColors(
                          playedColor: Colors.blue,
                          handleColor: Colors.blue,
                        ),
                      ),
                      const PlaybackSpeedButton(),
                    ],
                  ),
                ),
              ],
            ),
            const Text("INI REVIEWS"),
          ],
        ),
      ),
    );
  }
}
