part of 'leader_board_view_model.dart';

/// 리더보드 화면에서 발생하는 이벤트 정의
abstract class LeaderboardEvent extends Equatable {
  const LeaderboardEvent();

  @override
  List<Object?> get props => [];
}

/// 리더보드 목록을 로드하라는 이벤트 (초기 로드)
class LeaderboardLoadRequested extends LeaderboardEvent {
  const LeaderboardLoadRequested();
}

/// 검색어 변경 이벤트
class LeaderboardSearchChanged extends LeaderboardEvent {
  final String keyword;
  const LeaderboardSearchChanged(this.keyword);

  @override
  List<Object?> get props => [keyword];
}

/// 추가 페이지 로드를 요청하는 이벤트 (페이징)
class LoadMoreLeaderboard extends LeaderboardEvent {
  const LoadMoreLeaderboard();

  @override
  List<Object?> get props => [];
}
