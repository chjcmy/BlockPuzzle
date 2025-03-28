class ScoreDto {
  final String userName;
  final int score;
  final int dateTime;

  const ScoreDto({
    required this.userName,
    required this.score,
    required this.dateTime,
  });

  Map<String, dynamic> toJson() {
    return {'userName': userName, 'score': score, 'dateTime': dateTime};
  }

  factory ScoreDto.fromJson(Map<String, dynamic> json) {
    return ScoreDto(
      userName: json['userName'] as String,
      score: json['score'] as int,
      dateTime: json['dateTime'] as int,
    );
  }
}
