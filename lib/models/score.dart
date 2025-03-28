import 'package:equatable/equatable.dart';
import 'package:BlockPuzzle/models/dto/score_dto.dart';

class Score extends Equatable {
  final int score;
  final DateTime dateTime;

  const Score({required this.score, required this.dateTime});

  /// DB 저장/조회 시 Map 변환
  Map<String, dynamic> toMap() {
    return {'score': score, 'dateTime': dateTime.toIso8601String()};
  }

  DateTime get createdAt => dateTime;

  /// DB에서 가져온 Map 데이터를 Score 객체로 변환
  factory Score.fromMap(Map<String, dynamic> map) {
    return Score(
      score: map['score'] as int,
      dateTime: DateTime.parse(map['dateTime'] as String),
    );
  }

  /// Score -> ScoreDto 변환
  ScoreDto toDto(String? userId) {
    return ScoreDto(
      userName: userId ?? 'Unknown', // 사용자 이름은 하드코딩 또는 동적으로 가져올 수 있음
      score: score,
      dateTime: dateTime.millisecondsSinceEpoch,
    );
  }

  @override
  List<Object?> get props => [score, dateTime];
}
