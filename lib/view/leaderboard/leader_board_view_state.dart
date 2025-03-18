part of 'leader_board_view_model.dart';

class LeaderboardState extends BaseViewState with EquatableMixin {
  final List<LeaderboardEntry> entries; // 점수 리스트들
  final String keyword; // 키워드
  final String? error; // 에러
  final int currentPage; // 지금 페이지 위치
  final int selectedYear; // 단일 연도 선택
  final List<String> selectedSeasons; // 여러 시즌 선택 가능
  final List<int> availableYears; // 선택 할수 있는 년도
  final List<String> availableSeasons; // 선택 할수 있는 시즌

  const LeaderboardState({
    required super.isBusy,
    required this.entries,
    required this.keyword,
    required this.error,
    required this.currentPage,
    required this.selectedYear,
    required this.selectedSeasons,
    required this.availableYears,
    required this.availableSeasons,
  });

  factory LeaderboardState.initial() {
    return const LeaderboardState(
      isBusy: false,
      entries: [],
      keyword: '',
      error: null,
      currentPage: 1,
      selectedYear: 0,
      selectedSeasons: [],
      availableYears: [],
      availableSeasons: [],
    );
  }

  LeaderboardState copyWith({
    bool? isBusy,
    List<LeaderboardEntry>? entries,
    String? keyword,
    String? error,
    int? currentPage,
    int? selectedYear,
    List<String>? selectedSeasons,
    List<int>? availableYears,
    List<String>? availableSeasons,
    bool? isNewEntry,
  }) {
    return LeaderboardState(
      isBusy: isBusy ?? this.isBusy,
      entries: entries ?? this.entries,
      keyword: keyword ?? this.keyword,
      error: error,
      currentPage: currentPage ?? this.currentPage,
      selectedYear: selectedYear ?? this.selectedYear,
      selectedSeasons: selectedSeasons ?? this.selectedSeasons,
      availableYears: availableYears ?? this.availableYears,
      availableSeasons: availableSeasons ?? this.availableSeasons,
    );
  }

  factory LeaderboardState.fromServerData(List<Map<String, dynamic>> data) {
    // 1. 사용 가능한 연도 목록 추출
    final availableYears = data.map((item) => item['year'] as int).toList();

    // 2. 사용 가능한 시즌 목록 추출
    final availableSeasons =
        data.isNotEmpty
            ? (data[0]['seasons'] as List)
                .map((season) => season['name'] as String)
                .toList()
            : <String>[];

    // 3. 기본 선택값 설정 (현재 연도와 첫 번째 시즌)
    final currentYear = DateTime.now().year;
    final defaultYear =
        availableYears.contains(currentYear)
            ? currentYear
            : (availableYears.isNotEmpty ? availableYears.last : 0);

    final defaultSeasons =
        availableSeasons.isNotEmpty ? [availableSeasons[0]] : <String>[];

    return LeaderboardState(
      isBusy: false,
      entries: [],
      keyword: '',
      error: null,
      currentPage: 1,
      selectedYear: defaultYear,
      selectedSeasons: defaultSeasons,
      availableYears: availableYears,
      availableSeasons: availableSeasons,
    );
  }

  @override
  List<Object?> get props => [
    isBusy,
    entries,
    keyword,
    error,
    currentPage,
    selectedYear,
    selectedSeasons,
    availableYears,
    availableSeasons,
  ];
}
