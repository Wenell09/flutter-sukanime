class AnimeTopCard {
  late int malId;
  late String url;
  late String imageUrl;
  late String title;

  AnimeTopCard({
    required this.malId,
    required this.url,
    required this.imageUrl,
    required this.title,
  });

  factory AnimeTopCard.fromJson(Map<String, dynamic> json) {
    return AnimeTopCard(
        malId: json["mal_id"],
        url: json["url"],
        imageUrl: json["images"]["jpg"]["image_url"],
        title: json["title"]);
  }
}
