import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_list_anime/app/modules/detail/controllers/detail_controller.dart';
import 'package:flutter_list_anime/app/modules/detail/widgets/card_detail.dart';
import 'package:flutter_list_anime/app/modules/detail/widgets/isi_detail.dart';
import 'package:flutter_list_anime/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_list_anime/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter_list_anime/app/modules/widgets/loading_widget.dart';
import 'package:flutter_list_anime/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailView extends StatelessWidget {
  const DetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final darkMode = Get.put(ProfileController());
    final homeController = Get.put(HomeController());
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return GetBuilder<DetailController>(
      global: false,
      init: DetailController(),
      builder: (controller) => DefaultTabController(
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
                child: Obx(
                  () => (controller.isLoading.value)
                      ? const ShimmerLoading()
                      : Container(
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            controller.detailAnime[0].imageUrl,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.detailAnime[0].title,
                                          maxLines: 2,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        (controller.detailAnime[0].airedFrom ==
                                                "")
                                            ? Container()
                                            : Text(
                                                "${controller.formatMonth(controller.detailAnime[0].airedFrom)} • ${controller.detailAnime[0].type} • ${controller.cutString(controller.detailAnime[0].rating)}",
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15,
                                                ),
                                              ),
                                        Text(
                                          "★ ${controller.convertScoreToRating(controller.detailAnime[0].score)} Community Rating",
                                          style: const TextStyle(
                                            color: Colors.green,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          "${controller.detailAnime[0].members} Members Watching",
                                          style: const TextStyle(
                                            color: Colors.blue,
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        StreamBuilder<QuerySnapshot>(
                                          stream: firestore
                                              .collection(
                                                  "favorites_${ProfileController.userName.value}")
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return InkWell(
                                                highlightColor:
                                                    Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                splashColor: Colors.transparent,
                                                onTap: () {
                                                  if (ProfileController
                                                          .userId.value ==
                                                      "") {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        content: const Text(
                                                          "You must Login!",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    bool isFavorite = snapshot
                                                        .data!.docs
                                                        .where((favorite) =>
                                                            favorite["id"] ==
                                                                ProfileController
                                                                    .userId
                                                                    .value &&
                                                            favorite["malId"] ==
                                                                controller
                                                                    .malId)
                                                        .isNotEmpty;
                                                    if (isFavorite) {
                                                      homeController
                                                          .deleteFavorites(
                                                        ProfileController
                                                            .userId.value,
                                                        ProfileController
                                                            .userName.value,
                                                        controller.malId,
                                                      );
                                                      controller
                                                          .isLoadingFavorite
                                                          .value = true;
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                          duration: Duration(
                                                            seconds: 1,
                                                          ),
                                                          content: Text(
                                                            "Success delete from favorite list!",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                      Future.delayed(
                                                          const Duration(
                                                              seconds: 1), () {
                                                        controller
                                                            .isLoadingFavorite
                                                            .value = false;
                                                      });
                                                    } else {
                                                      homeController
                                                          .addFavorites(
                                                        ProfileController
                                                            .userId.value,
                                                        ProfileController
                                                            .userName.value,
                                                        controller.malId,
                                                        controller
                                                            .detailAnime[0]
                                                            .title,
                                                        controller
                                                            .detailAnime[0]
                                                            .imageUrl,
                                                        controller
                                                            .detailAnime[0]
                                                            .airedFrom,
                                                        controller
                                                            .detailAnime[0]
                                                            .type,
                                                        controller
                                                            .detailAnime[0]
                                                            .rating,
                                                        controller
                                                            .detailAnime[0]
                                                            .score,
                                                        controller
                                                            .detailAnime[0]
                                                            .members,
                                                        controller
                                                            .detailAnime[0]
                                                            .youtubeUrl,
                                                      );
                                                      controller
                                                          .isLoadingFavorite
                                                          .value = true;
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                          duration: Duration(
                                                            seconds: 1,
                                                          ),
                                                          content: Text(
                                                            "Success add to favorite list!",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                      Future.delayed(
                                                          const Duration(
                                                              seconds: 1), () {
                                                        controller
                                                            .isLoadingFavorite
                                                            .value = false;
                                                      });
                                                    }
                                                  }
                                                },
                                                child: Obx(
                                                  () => AnimatedContainer(
                                                    curve: Curves.easeInOut,
                                                    duration: const Duration(
                                                        seconds: 1),
                                                    width: (controller
                                                            .isLoadingFavorite
                                                            .value)
                                                        ? 33
                                                        : MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        const Flexible(
                                                          flex: 1,
                                                          child: SizedBox(
                                                            width: 8,
                                                          ),
                                                        ),
                                                        (controller
                                                                .isLoadingFavorite
                                                                .value)
                                                            ? SizedBox(
                                                                width: 25,
                                                                height: 25,
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .blue,
                                                                  color: (darkMode
                                                                          .isDark
                                                                          .value)
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                                ),
                                                              )
                                                            : Icon(
                                                                (snapshot.data!
                                                                        .docs
                                                                        .where((favorite) =>
                                                                            favorite["id"] == ProfileController.userId.value &&
                                                                            favorite["malId"] ==
                                                                                controller
                                                                                    .malId)
                                                                        .isNotEmpty)
                                                                    ? Icons
                                                                        .check_outlined
                                                                    : Icons
                                                                        .bookmark,
                                                                size: 25,
                                                              ),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        Expanded(
                                                          flex: 5,
                                                          child: Text(
                                                            (controller
                                                                    .isLoadingFavorite
                                                                    .value)
                                                                ? ""
                                                                : (snapshot
                                                                        .data!
                                                                        .docs
                                                                        .where((favorite) =>
                                                                            favorite["id"] == ProfileController.userId.value &&
                                                                            favorite["malId"] ==
                                                                                controller.malId)
                                                                        .isNotEmpty)
                                                                    ? "Success Add"
                                                                    : "Add Favorite",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            } else {
                                              return Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              );
                                            }
                                          },
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
              ),
              bottom: TabBar(
                labelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: (darkMode.isDark.value) ? Colors.white : Colors.black,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
                indicatorColor: Colors.blue,
                overlayColor:
                    const MaterialStatePropertyAll(Colors.transparent),
                tabs: const [
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
              Obx(
                () => (controller.isLoading.value)
                    ? LoadingWidget(
                        color: (darkMode.isDark.value)
                            ? Colors.white
                            : Colors.black,
                        mediaQuery: MediaQuery.of(context).size.height * 0.5,
                      )
                    : ListView(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var detailAnime = controller.detailAnime[index];
                              List<String> genreNames = [];
                              for (var genre in detailAnime.genres) {
                                genreNames.add(genre['name']);
                              }
                              return (controller.malId != detailAnime.malId)
                                  ? Center(
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Icon(
                                            FontAwesomeIcons.circleXmark,
                                            color: Colors.grey[800],
                                            size: 100,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            "Data not found !",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          const Text(
                                            "User presses quickly, repeat!",
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
                                                color: (darkMode.isDark.value)
                                                    ? Colors.grey[700]!
                                                    : Colors.grey,
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
                                              color: (darkMode.isDark.value)
                                                  ? Colors.grey[850]
                                                  : Colors.grey[50],
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
                                                (detailAnime.airedFrom.isEmpty)
                                                    ? Container()
                                                    : IsiDetail(
                                                        title:
                                                            "Aired Date(s) • ",
                                                        isi: controller
                                                            .formatDate(
                                                                detailAnime
                                                                    .airedFrom),
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
                                                (detailAnime.studios.isEmpty)
                                                    ? Container()
                                                    : IsiDetail(
                                                        title: "Studio • ",
                                                        isi: detailAnime
                                                                    .studios[0]
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
                          const Text(
                            textAlign: TextAlign.center,
                            "Characters",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final charaAnime = controller.charaAnime[index];
                                return Card(
                                  child: Container(
                                    margin: const EdgeInsets.all(0),
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                            charaAnime.imageUrl,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 30,
                                            decoration: const BoxDecoration(
                                              color: Colors.black54,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                                charaAnime.name,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              itemCount: controller.charaAnime.length,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          (controller.recomenAnime.isEmpty)
                              ? Container()
                              : const Text(
                                  textAlign: TextAlign.center,
                                  "Recommendations",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                          (controller.recomenAnime.isEmpty)
                              ? Container()
                              : Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      final recomenAnime =
                                          controller.recomenAnime[index];
                                      return InkWell(
                                        onTap: () =>
                                            Navigator.of(context).pushNamed(
                                          Routes.DETAIL,
                                          arguments: recomenAnime.malId,
                                        ),
                                        child: Card(
                                          child: Container(
                                            margin: const EdgeInsets.all(0),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.45,
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                    errorBuilder: (context,
                                                            error,
                                                            stackTrace) =>
                                                        const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                    recomenAnime.images,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height: 30,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.black54,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.center,
                                                        recomenAnime.title,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: controller.recomenAnime.length,
                                  ),
                                ),
                        ],
                      ),
              ),
              // bagian tab trailer
              Obx(
                () => (controller.isLoading.value)
                    ? LoadingWidget(
                        color: (darkMode.isDark.value)
                            ? Colors.white
                            : Colors.black,
                        mediaQuery: MediaQuery.of(context).size.height * 0.5,
                      )
                    : Trailer(
                        controller: controller,
                        youtubeId: controller.detailAnime[0].youtubeUrl,
                      ),
              ),
              // bagian tab review
              Obx(
                () => (controller.isLoading.value)
                    ? LoadingWidget(
                        color: (darkMode.isDark.value)
                            ? Colors.white
                            : Colors.black,
                        mediaQuery: MediaQuery.of(context).size.height * 0.5,
                      )
                    : Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: StreamBuilder<QuerySnapshot>(
                              stream: firestore
                                  .collection(
                                      "reviews_${controller.detailAnime[0].title}")
                                  .orderBy("timestamp")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data!.docs.isNotEmpty) {
                                    return ListView(
                                      children: snapshot.data!.docs.map((data) {
                                        Timestamp? timestamp =
                                            data["timestamp"] as Timestamp?;
                                        String formattedTime =
                                            DateFormat('yyyy-MM-dd HH:mm')
                                                .format(timestamp?.toDate() ??
                                                    DateTime.now());
                                        return ListTile(
                                          leading: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                data["profilePicture"]),
                                          ),
                                          title: Text(data["username"]),
                                          subtitle: Text(data["isiReview"]),
                                          trailing: Text(formattedTime),
                                        );
                                      }).toList(),
                                    );
                                  } else {
                                    return const Center(
                                      child: Text(
                                        "There are no reviews about this Anime",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    );
                                  }
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Stack(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.bottomCenter,
                                    margin: const EdgeInsets.only(
                                        left: 10, bottom: 15),
                                    padding: const EdgeInsets.only(left: 10),
                                    width: MediaQuery.of(context).size.width *
                                        0.75,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: (darkMode.isDark.value)
                                          ? Colors.grey[600]
                                          : Colors.grey[350],
                                    ),
                                    child: TextField(
                                      readOnly:
                                          (ProfileController.userId.value == "")
                                              ? true
                                              : false,
                                      cursorColor: Colors.white,
                                      controller: controller.inputReview,
                                      style: TextStyle(
                                        color: (darkMode.isDark.value)
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        hintText:
                                            "Leave a review about this Anime",
                                        hintStyle: TextStyle(
                                          color: (darkMode.isDark.value)
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        border: InputBorder.none,
                                        fillColor: (darkMode.isDark.value)
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      highlightColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      onTap: () {
                                        if (ProfileController.userId.value ==
                                            "") {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              content: const Text(
                                                "You must Login!",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          );
                                        } else if (controller
                                            .inputReview.text.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              duration: Duration(
                                                seconds: 1,
                                              ),
                                              content: Text(
                                                "Review cannot be empty!",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          );
                                        } else {
                                          controller.addReview(
                                            controller.malId,
                                            controller.detailAnime[0].title,
                                            ProfileController.userImage.value,
                                            ProfileController.userName.value,
                                            controller.inputReview.text,
                                          );
                                        }
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          bottom: 15,
                                        ),
                                        height: 45,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.blue,
                                        ),
                                        child: const Center(
                                          child: FaIcon(
                                            FontAwesomeIcons.chevronRight,
                                            size: 28,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Trailer extends StatelessWidget {
  final DetailController controller;
  final String youtubeId;
  const Trailer({
    super.key,
    required this.controller,
    required this.youtubeId,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: YoutubePlayer(
            controller: YoutubePlayerController(
              initialVideoId: YoutubePlayer.convertUrlToId(youtubeId)!,
              flags: const YoutubePlayerFlags(
                autoPlay: false,
              ),
            ),
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
    );
  }
}

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.height * 0.23,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    )
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
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: MediaQuery.of(context).size.height * 0.03,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.025,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.height * 0.025,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.height * 0.025,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.04,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
