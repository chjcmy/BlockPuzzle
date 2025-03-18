import 'package:equatable/equatable.dart';

class LeaderboardEntry extends Equatable {
  final String name;
  final int score;
  final String dateTime;
  final int seasonYear;
  final String seasonName;
  final double percentage;

  const LeaderboardEntry({
    required this.name,
    required this.score,
    this.dateTime = '',
    this.seasonYear = 0,
    this.seasonName = '',
    this.percentage = 0,
  });

  @override
  List<Object?> get props => [
    name,
    score,
    dateTime,
    seasonYear,
    seasonName,
    percentage,
  ];

  // fromJson 생성자 수정
  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      name: json['name'] as String? ?? 'unknown',
      score: json['score'] as int? ?? 0,
      dateTime: json['dateTime'] as String? ?? '',
      seasonYear: json['seasonYear'] as int? ?? 0,
      seasonName: json['seasonName'] as String? ?? '',
      percentage: (json['percentage'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
