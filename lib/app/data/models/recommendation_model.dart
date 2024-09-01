class RecommendationModel {
  int malId;
  String title, images;

  RecommendationModel({
    required this.malId,
    required this.title,
    required this.images,
  });

  factory RecommendationModel.fromJson(Map<String, dynamic> json) {
    return RecommendationModel(
        malId: json["entry"]["mal_id"] ?? 0,
        title: json["entry"]["title"] ?? "",
        images: json["entry"]["images"]["jpg"]["image_url"] ?? "");
  }
}
