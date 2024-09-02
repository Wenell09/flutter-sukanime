import 'package:flutter/material.dart';
import 'package:flutter_list_anime/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter_list_anime/app/routes/app_pages.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../controllers/home_controller.dart';
import '../../widgets/nointernet_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final profile = Get.put(ProfileController());
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
          () => (controller.connectionType.value == 0)
              ? const NoInternet()
              : (controller.isLoading.value)
                  ? const ShimmerLoading()
                  : Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        ExpandableCarousel.builder(
                            options: CarouselOptions(
                              floatingIndicator: true,
                              autoPlay: true,
                              showIndicator: true,
                              slideIndicator: CircularSlideIndicator(
                                indicatorRadius: 5,
                                indicatorBackgroundColor: (profile.isDark.value)
                                    ? Colors.black
                                    : Colors.white,
                                currentIndicatorColor: Colors.blue,
                              ),
                            ),
                            itemCount: controller.animeImageCard.length,
                            itemBuilder: (context, index, pageViewIndex) {
                              var animeImageCard =
                                  controller.animeImageCard[index];
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    animeImageCard.imageUrlBig,
                                    width: MediaQuery.of(context).size.width,
                                    height: 220,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }),
                        const SizedBox(
                          height: 5,
                        ),
                        const TitleText(
                          title: "Top All Anime",
                          argumentKey: "top_all",
                          argumentField: "Top All Anime",
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 280,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
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
                                  arguments: animeTopCard.malId,
                                ),
                                child: Card(
                                  elevation: 5,
                                  shadowColor: Colors.black,
                                  child: SizedBox(
                                    width: 160,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.network(
                                              animeTopCard.imageUrl,
                                              fit: BoxFit.cover,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Center(
                                            child: Text(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              animeTopCard.title,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
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
                            itemCount: controller.animeTopCard.length,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const TitleText(
                          title: "Top Airing",
                          argumentKey: "airing",
                          argumentField: "Top Airing",
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 280,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.all(8.0),
                            itemBuilder: (context, index) {
                              var animeRecomCard =
                                  controller.animeAiringCard[index];
                              return InkWell(
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  Routes.DETAIL,
                                  arguments: animeRecomCard.malId,
                                ),
                                child: Card(
                                  elevation: 5,
                                  shadowColor: Colors.black,
                                  child: SizedBox(
                                    width: 160,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.network(
                                              animeRecomCard.imageUrl,
                                              fit: BoxFit.cover,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Center(
                                                    child: Text(
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      animeRecomCard.title,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                      ),
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
                              );
                            },
                            itemCount: controller.animeAiringCard.length,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const TitleText(
                          title: "Top Upcoming",
                          argumentKey: "upcoming",
                          argumentField: "Top Upcoming",
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 280,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.all(8.0),
                            itemBuilder: (context, index) {
                              var animeUpcomingCard =
                                  controller.animeUpcomingCard[index];
                              return InkWell(
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  Routes.DETAIL,
                                  arguments: animeUpcomingCard.malId,
                                ),
                                child: Card(
                                  elevation: 5,
                                  shadowColor: Colors.black,
                                  child: SizedBox(
                                    width: 160,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.network(
                                              animeUpcomingCard.imageUrl,
                                              fit: BoxFit.cover,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Center(
                                            child: Text(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              animeUpcomingCard.title,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
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
                            itemCount: controller.animeUpcomingCard.length,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const TitleText(
                          title: "Top Movie",
                          argumentKey: "movie",
                          argumentField: "Top Movie",
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 280,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.all(8.0),
                            itemBuilder: (context, index) {
                              var animeMovieCard =
                                  controller.animeMovieCard[index];
                              return InkWell(
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  Routes.DETAIL,
                                  arguments: animeMovieCard.malId,
                                ),
                                child: Card(
                                  elevation: 5,
                                  shadowColor: Colors.black,
                                  child: SizedBox(
                                    width: 160,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.network(
                                              animeMovieCard.imageUrl,
                                              fit: BoxFit.cover,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Center(
                                            child: Text(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              animeMovieCard.title,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
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
                            itemCount: controller.animeMovieCard.length,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const TitleText(
                          title: "Most Popular",
                          argumentKey: "bypopularity",
                          argumentField: "Most Popular",
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 280,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.all(8.0),
                            itemBuilder: (context, index) {
                              var animePopularCard =
                                  controller.animePopularCard[index];
                              return InkWell(
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  Routes.DETAIL,
                                  arguments: animePopularCard.malId,
                                ),
                                child: Card(
                                  elevation: 5,
                                  shadowColor: Colors.black,
                                  child: SizedBox(
                                    width: 160,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.network(
                                              animePopularCard.imageUrl,
                                              fit: BoxFit.cover,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Center(
                                            child: Text(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              animePopularCard.title,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
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
                            itemCount: controller.animePopularCard.length,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const TitleText(
                          title: "Most Favorited",
                          argumentKey: "favorite",
                          argumentField: "Most Favorited",
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 280,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.all(8.0),
                            itemBuilder: (context, index) {
                              var animeFavoriteCard =
                                  controller.animeFavoriteCard[index];
                              return InkWell(
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  Routes.DETAIL,
                                  arguments: animeFavoriteCard.malId,
                                ),
                                child: Card(
                                  elevation: 5,
                                  shadowColor: Colors.black,
                                  child: SizedBox(
                                    width: 160,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.network(
                                              animeFavoriteCard.imageUrl,
                                              fit: BoxFit.cover,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Center(
                                            child: Text(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              animeFavoriteCard.title,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
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
                            itemCount: controller.animeFavoriteCard.length,
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 220,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.height * 0.03,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 280,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8.0),
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Card(
                  child: Container(
                    width: 160,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              );
            },
            itemCount: 3,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.height * 0.03,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 280,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8.0),
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Card(
                  child: Container(
                    width: 160,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              );
            },
            itemCount: 3,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}

class TitleText extends StatelessWidget {
  final String title;
  final String argumentKey;
  final String argumentField;
  const TitleText({
    super.key,
    required this.title,
    required this.argumentKey,
    required this.argumentField,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
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
              arguments: {
                argumentKey: argumentField,
              },
            ),
            child: const Text(
              "See more",
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
    );
  }
}
