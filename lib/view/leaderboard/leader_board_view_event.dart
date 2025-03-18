part of 'leader_board_view_model.dart';

/// 리더보드 화면에서 발생하는 이벤트 정의
abstract class LeaderboardEvent extends Equatable {
  const LeaderboardEvent();

  @override
  List<Object?> get props => [];
}

/// 초기 시즌과 연도 데이터를 로드하는 이벤트
class LoadYearsAndSeasonsRequested extends LeaderboardEvent {
  const LoadYearsAndSeasonsRequested();
}

// 연도 선택 이벤트
class YearSelected extends LeaderboardEvent {
  final int year;
  const YearSelected(this.year);

  @override
  List<Object?> get props => [year];
}

// 시즌 토글 이벤트
class SeasonSelected extends LeaderboardEvent {
  final String season;
  const SeasonSelected(this.season);

  @override
  List<Object?> get props => [season];
}

class LeaderboardLoadRequested extends LeaderboardEvent {
  const LeaderboardLoadRequested();
}

class LeaderboardSearchChanged extends LeaderboardEvent {
  final String keyword;
  const LeaderboardSearchChanged(this.keyword);
  
  @override
  List<Object?> get props => [keyword];
}

class LoadMoreLeaderboard extends LeaderboardEvent {
  const LoadMoreLeaderboard();
}