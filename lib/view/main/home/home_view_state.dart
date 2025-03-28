part of 'home_view_model.dart';

/// 홈 화면 상태
class HomeViewState extends BaseViewState with EquatableMixin {
  /// 점수 목록
  final List<Score> scoreList;

  /// 로딩 중인지 여부
  final bool isLoading;

  /// 현재 정렬 방식
  final ScoreSortType sortType;

  /// 에러 메시지 (있을 경우)
  final String? error;

  /// 시즌 최고 점수
  final double? seasonBestScore;

  /// 시즌 점수 퍼센타일 (0-100 사이 값)
  final double? seasonPercentile;

  const HomeViewState({
    required super.isBusy,
    this.scoreList = const [],
    this.isLoading = false,
    this.sortType = ScoreSortType.latest,
    this.error,
    this.seasonBestScore,
    this.seasonPercentile,
  });

  HomeViewState copyWith({
    List<Score>? scoreList,
    bool? isLoading,
    ScoreSortType? sortType,
    String? error,
    bool? isBusy,
    double? seasonBestScore,
    double? seasonPercentile,
  }) {
    return HomeViewState(
      isBusy: isBusy ?? this.isBusy,
      scoreList: scoreList ?? this.scoreList,
      isLoading: isLoading ?? this.isLoading,
      sortType: sortType ?? this.sortType,
      error: error,
      seasonBestScore: seasonBestScore ?? this.seasonBestScore,
      seasonPercentile: seasonPercentile ?? this.seasonPercentile,
    );
  }

  @override
  List<Object?> get props => [
    isBusy,
    scoreList,
    isLoading,
    sortType,
    error,
    seasonBestScore,
    seasonPercentile,
  ];
}
