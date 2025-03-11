import 'package:equatable/equatable.dart';

/// 리더보드에 표시할 한 명의 데이터 (랭킹, 플레이어 ID, 점수)
class LeaderboardEntry extends Equatable {
  final int rank;
  final String name;
  final int score;

  const LeaderboardEntry({
    required this.rank,
    required this.name,
    required this.score,
  });

  @override
  List<Object?> get props => [rank, name, score];

  // fromJson 생성자: JSON Map으로부터 LeaderboardEntry 객체를 생성합니다.
  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      rank: json['rank'] as int? ?? 0, // 만약 서버에서 rank 정보가 없다면 기본 0
      name: json['name'] as String? ?? 'unknown',
      score: json['score'] as int? ?? 0,
    );
  }
}
