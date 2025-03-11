part of 'leader_board_view_model.dart';

class LeaderboardState extends BaseViewState with EquatableMixin {
  /// 리더보드 목록
  final List<LeaderboardEntry> entries;

  /// 검색 키워드
  final String keyword;

  /// 에러 메시지 (null이면 에러 없음)
  final String? error;

  /// 현재 페이지 번호
  final int currentPage;

  const LeaderboardState({
    required super.isBusy,
    required this.entries,
    required this.keyword,
    required this.error,
    required this.currentPage,
  });

  factory LeaderboardState.initial() {
    return const LeaderboardState(
      isBusy: false,
      entries: [],
      keyword: '',
      error: null,
      currentPage: 1,
    );
  }

  LeaderboardState copyWith({
    bool? isBusy,
    List<LeaderboardEntry>? entries,
    String? keyword,
    String? error,
    int? currentPage,
  }) {
    return LeaderboardState(
      isBusy: isBusy ?? this.isBusy,
      entries: entries ?? this.entries,
      keyword: keyword ?? this.keyword,
      error: error,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [isBusy, entries, keyword, error, currentPage];
}
