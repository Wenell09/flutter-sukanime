class CharacterModel {
  int malId;
  String name, imageUrl;

  CharacterModel({
    required this.malId,
    required this.name,
    required this.imageUrl,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
        malId: json["character"]["mal_id"] ?? 0,
        name: json["character"]["name"] ?? "",
        imageUrl: json["character"]["images"]["jpg"]["image_url"] ?? "");
  }
}
