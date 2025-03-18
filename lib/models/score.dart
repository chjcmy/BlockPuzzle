import 'package:equatable/equatable.dart';

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

  @override
  List<Object?> get props => [score, dateTime];
}
