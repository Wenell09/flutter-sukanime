class AnimeTop {
  late int malId;
  late String url;
  late String imageUrl;
  late String title;

  AnimeTop({
    required this.malId,
    required this.url,
    required this.imageUrl,
    required this.title,
  });

  factory AnimeTop.fromJson(Map<String, dynamic> json) {
    return AnimeTop(
        malId: json["mal_id"],
        url: json["url"],
        imageUrl: json["images"]["jpg"]["image_url"],
        title: json["title"]);
  }

  Map<String, dynamic> toJson() => {
        "mal_id": malId,
        "url": url,
        "imageUrl": imageUrl,
        "title": title,
      };
}
