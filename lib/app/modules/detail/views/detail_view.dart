import 'package:flutter/material.dart';
import 'package:flutter_list_anime/app/modules/widgets/loading_widget.dart';
import 'package:get/get.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail',
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
            physics: const ScrollPhysics(),
            child: Obx(
              () => (controller.isLoading.value)
                  ? const LoadingWidget()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var detailAnime = controller.detailAnime[index];
                        List<String> genreNames = [];
                        for (var genre in detailAnime.genres) {
                          genreNames.add(genre['name']);
                        }
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        detailAnime.imageUrl,
                                        fit: BoxFit.cover,
                                        width: 200,
                                        height: 250,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          detailAnime.titleEnglish,
                                          maxLines: 2,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        Text(
                                          "${controller.formatMonth(detailAnime.airedFrom)} • ${detailAnime.type} • ${controller.cutString(detailAnime.rating)}",
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          "★ ${controller.convertScoreToRating(detailAnime.score)} Community Rating",
                                          style: const TextStyle(
                                            color: Colors.green,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          "${detailAnime.members} Members Watching",
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
                            ),
                          ],
                        );
                      },
                      itemCount: controller.detailAnime.length,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
