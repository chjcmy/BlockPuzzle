import 'package:equatable/equatable.dart';

/// 시즌 점수 정보 (점수, 날짜, 퍼센타일)
class SeasonScore extends Equatable {
  final int score;
  final DateTime dateTime;
  final double percentile;
  
  /// 트로피 색상을 결정하기 위한 등급 (옵션)
  final String? tier;

  const SeasonScore({
    required this.score,
    required this.dateTime,
    required this.percentile,
    this.tier,
  });

  @override
  List<Object?> get props => [score, dateTime, percentile, tier];

  // fromJson 생성자: JSON Map으로부터 SeasonScore 객체를 생성합니다.
  factory SeasonScore.fromJson(Map<String, dynamic> json) {
    return SeasonScore(
      score: json['score'] as int? ?? 0,
      dateTime: json['dateTime'] != null 
          ? DateTime.parse(json['dateTime'] as String) 
          : DateTime.now(),
      percentile: (json['percentile'] as num?)?.toDouble() ?? 0.0,
      tier: json['tier'] as String?,
    );
  }
  
  // toJson 메서드: SeasonScore 객체를 JSON Map으로 변환합니다.
  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'dateTime': dateTime.toIso8601String(),
      'percentile': percentile,
      'tier': tier,
    };
  }
  
  // 퍼센타일에 따른 텍스트 반환 (예: "상위 10.5%")
  String getPercentileText() {
    return '상위 ${percentile.toStringAsFixed(1)}%';
  }
  
  // 시즌 데이터가 없는 경우를 위한 빈 객체 생성
  factory SeasonScore.empty() {
    return SeasonScore(
      score: 0,
      dateTime: DateTime.now(),
      percentile: 0.0,
    );
  }
}

/// 시즌 데이터 응답을 위한 모델 (API 응답 처리용)
class SeasonScoreResponse extends Equatable {
  final SeasonScore? seasonBestScore;
  final double percentile;
  final bool isNewRecord;

  const SeasonScoreResponse({
    this.seasonBestScore,
    this.percentile = 0.0,
    this.isNewRecord = false,
  });

  @override
  List<Object?> get props => [seasonBestScore, percentile, isNewRecord];

  // fromJson 생성자: JSON Map으로부터 SeasonScoreResponse 객체를 생성합니다.
  factory SeasonScoreResponse.fromJson(Map<String, dynamic> json) {
    return SeasonScoreResponse(
      seasonBestScore: json['seasonBestScore'] != null
          ? SeasonScore.fromJson(json['seasonBestScore'] as Map<String, dynamic>)
          : null,
      percentile: (json['percentile'] as num?)?.toDouble() ?? 0.0,
      isNewRecord: json['isNewRecord'] as bool? ?? false,
    );
  }
}
