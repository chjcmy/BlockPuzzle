class Season {
  final String name;

  Season({required this.name});

  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(name: json['name'] as String);
  }
}

class YearSeasons {
  final int year;
  final List<Season> seasons;

  YearSeasons({required this.year, required this.seasons});

  factory YearSeasons.fromJson(Map<String, dynamic> json) {
    return YearSeasons(
      year: json['year'] as int,
      seasons: (json['seasons'] as List)
          .map((season) => Season.fromJson(season))
          .toList(),
    );
  }
}
