class DetailAnime {
  final int malId;
  final String url;
  final Images images;
  final Trailer trailer;
  final bool approved;
  final List<Title> titles;
  final String title;
  final String titleEnglish;
  final String titleJapanese;
  final List<String> titleSynonyms;
  final String type;
  final String source;
  final int episodes;
  final String status;
  final bool airing;
  final Aired aired;
  final String duration;
  final String rating;
  final double score;
  final int scoredBy;
  final int rank;
  final int popularity;
  final int members;
  final int favorites;
  final String synopsis;
  final String background;
  final String season;
  final int year;
  final Broadcast broadcast;
  final List<Producer> producers;
  final List<Studio> studios;
  final List<Genre> genres;
  final List<Genre> explicitGenres;

  DetailAnime({
    required this.malId,
    required this.url,
    required this.images,
    required this.trailer,
    required this.approved,
    required this.titles,
    required this.title,
    required this.titleEnglish,
    required this.titleJapanese,
    required this.titleSynonyms,
    required this.type,
    required this.source,
    required this.episodes,
    required this.status,
    required this.airing,
    required this.aired,
    required this.duration,
    required this.rating,
    required this.score,
    required this.scoredBy,
    required this.rank,
    required this.popularity,
    required this.members,
    required this.favorites,
    required this.synopsis,
    required this.background,
    required this.season,
    required this.year,
    required this.broadcast,
    required this.producers,
    required this.studios,
    required this.genres,
    required this.explicitGenres,
  });

  factory DetailAnime.fromJson(Map<String, dynamic> json) {
    return DetailAnime(
      malId: json['mal_id'] as int,
      url: json['url'] as String,
      images: Images.fromJson(json['images'] as Map<String, dynamic>),
      trailer: Trailer.fromJson(json['trailer'] as Map<String, dynamic>),
      approved: json['approved'] as bool,
      titles: (json['titles'] as List<dynamic>)
          .map((e) => Title.fromJson(e as Map<String, dynamic>))
          .toList(),
      title: json['title'] as String,
      titleEnglish: json['title_english'] as String,
      titleJapanese: json['title_japanese'] as String,
      titleSynonyms: (json['title_synonyms'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      type: json['type'] as String,
      source: json['source'] as String,
      episodes: json['episodes'] as int,
      status: json['status'] as String,
      airing: json['airing'] as bool,
      aired: Aired.fromJson(json['aired'] as Map<String, dynamic>),
      duration: json['duration'] as String,
      rating: json['rating'] as String,
      score: (json['score'] as num).toDouble(),
      scoredBy: json['scored_by'] as int,
      rank: json['rank'] as int,
      popularity: json['popularity'] as int,
      members: json['members'] as int,
      favorites: json['favorites'] as int,
      synopsis: json['synopsis'] as String,
      background: json['background'] as String,
      season: json['season'] as String,
      year: json['year'] as int,
      broadcast: Broadcast.fromJson(json['broadcast'] as Map<String, dynamic>),
      producers: (json['producers'] as List<dynamic>)
          .map((e) => Producer.fromJson(e as Map<String, dynamic>))
          .toList(),
      studios: (json['studios'] as List<dynamic>)
          .map((e) => Studio.fromJson(e as Map<String, dynamic>))
          .toList(),
      genres: (json['genres'] as List<dynamic>)
          .map((e) => Genre.fromJson(e as Map<String, dynamic>))
          .toList(),
      explicitGenres: (json['explicit_genres'] as List<dynamic>)
          .map((e) => Genre.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Images {
  final Image jpg;
  final Image webp;

  Images({required this.jpg, required this.webp});

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      jpg: Image.fromJson(json['jpg'] as Map<String, dynamic>),
      webp: Image.fromJson(json['webp'] as Map<String, dynamic>),
    );
  }
}

class Image {
  final String imageUrl;
  final String smallImageUrl;
  final String largeImageUrl;

  Image({
    required this.imageUrl,
    required this.smallImageUrl,
    required this.largeImageUrl,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      imageUrl: json['image_url'] as String,
      smallImageUrl: json['small_image_url'] as String,
      largeImageUrl: json['large_image_url'] as String,
    );
  }
}

class Trailer {
  final String youtubeId;
  final String url;
  final String embedUrl;

  Trailer({
    required this.youtubeId,
    required this.url,
    required this.embedUrl,
  });

  factory Trailer.fromJson(Map<String, dynamic> json) {
    return Trailer(
      youtubeId: json['youtube_id'] as String,
      url: json['url'] as String,
      embedUrl: json['embed_url'] as String,
    );
  }
}

class Title {
  final String type;
  final String title;

  Title({required this.type, required this.title});

  factory Title.fromJson(Map<String, dynamic> json) {
    return Title(
      type: json['type'] as String,
      title: json['title'] as String,
    );
  }
}

class Aired {
  final String from;
  final String to;
  final Map<String, dynamic> prop;

  Aired({required this.from, required this.to, required this.prop});

  factory Aired.fromJson(Map<String, dynamic> json) {
    return Aired(
      from: json['from'] as String,
      to: json['to'] as String,
      prop: json['prop'] as Map<String, dynamic>,
    );
  }
}

class Broadcast {
  final String day;
  final String time;
  final String timezone;
  final Map<String, dynamic> prop;

  Broadcast(
      {required this.day,
      required this.time,
      required this.timezone,
      required this.prop});

  factory Broadcast.fromJson(Map<String, dynamic> json) {
    return Broadcast(
      day: json['day'] as String,
      time: json['time'] as String,
      timezone: json['timezone'] as String,
      prop: json['prop'] as Map<String, dynamic>,
    );
  }
}

class Producer {
  final int malId;
  final String type;
  final String name;
  final String url;

  Producer(
      {required this.malId,
      required this.type,
      required this.name,
      required this.url});

  factory Producer.fromJson(Map<String, dynamic> json) {
    return Producer(
      malId: json['mal_id'] as int,
      type: json['type'] as String,
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }
}

class Studio {
  final int malId;
  final String type;
  final String name;
  final String url;

  Studio(
      {required this.malId,
      required this.type,
      required this.name,
      required this.url});

  factory Studio.fromJson(Map<String, dynamic> json) {
    return Studio(
      malId: json['mal_id'] as int,
      type: json['type'] as String,
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }
}

class Genre {
  final int malId;
  final String type;
  final String name;
  final String url;

  Genre(
      {required this.malId,
      required this.type,
      required this.name,
      required this.url});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      malId: json['mal_id'] as int,
      type: json['type'] as String,
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }
}
