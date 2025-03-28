import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:BlockPuzzle/models/leaderboard_entry.dart';
import 'package:BlockPuzzle/repositories/leaderboard/leaderboard_repository_impl.dart';
import 'package:BlockPuzzle/view/base_view_model.dart';
import 'package:BlockPuzzle/view/base_view_state.dart';

part 'leader_board_view_event.dart';
part 'leader_board_view_state.dart';

class LeaderboardViewModel
    extends BaseViewModel<LeaderboardEvent, LeaderboardState> {
  // 상수 및 프로퍼티
  static const int _pageSize = 20;
  final LeaderboardRepositoryImpl repository;

  // 생성자
  LeaderboardViewModel({required this.repository})
    : super(LeaderboardState.initial()) {
    // 이벤트 핸들러 등록
    on<LoadYearsAndSeasonsRequested>(_onLoadYearsAndSeasonsRequested);
    on<LeaderboardLoadRequested>(_onLoadRequested);
    on<YearSelected>(_onYearSelected);
    on<SeasonSelected>(_onSeasonSelected);
    on<LeaderboardSearchChanged>(_onSearchChanged);
    on<LoadMoreLeaderboard>(_onLoadMore);
    // 초기 데이터 로드
    add(const LoadYearsAndSeasonsRequested());
  }

  //==================================================
  // 초기화 및 데이터 로드 메서드
  //==================================================

  /// 초기 연도와 시즌 데이터 로드
  Future<void> _onLoadYearsAndSeasonsRequested(
    LoadYearsAndSeasonsRequested event,
    Emitter<LeaderboardState> emit,
  ) async {
    emit(state.copyWith(isBusy: true));

    try {
      // 연도 및 시즌 데이터 로드
      final seasonsData = await repository.getAllYearsAndSeasons();

      // 데이터 가공
      final availableYears =
          seasonsData.map((yearData) => yearData.year).toList();

      final availableSeasons =
          seasonsData.isNotEmpty
              ? seasonsData.first.seasons.map((season) => season.name).toList()
              : <String>[];

      // 기본 선택 값 설정
      final currentDate = DateTime.now();
      final currentYear = currentDate.year;
      final currentMonth = currentDate.month;

      // 현재 월에 따른 시즌 결정
      String currentSeason;
      if (currentMonth >= 3 && currentMonth <= 5) {
        currentSeason = 'SPRING';
      } else if (currentMonth >= 6 && currentMonth <= 8) {
        currentSeason = 'SUMMER';
      } else if (currentMonth >= 9 && currentMonth <= 11) {
        currentSeason = 'AUTUMN';
      } else {
        currentSeason = 'WINTER'; // 12, 1, 2월
      }

      final defaultYear =
          availableYears.contains(currentYear)
              ? currentYear
              : (availableYears.isNotEmpty ? availableYears.last : 0);

      // 현재 시즌이 사용 가능한지 확인하고, 그렇지 않으면 첫 번째 사용 가능한 시즌을 선택
      final defaultSeasons =
          availableSeasons.contains(currentSeason)
              ? [currentSeason]
              : (availableSeasons.isNotEmpty
                  ? [availableSeasons.first]
                  : <String>[]);

      // 상태 업데이트
      emit(
        state.copyWith(
          isBusy: false,
          availableYears: availableYears,
          availableSeasons: availableSeasons,
          selectedYear: defaultYear,
          selectedSeasons: defaultSeasons,
          isNewEntry: false,
        ),
      );

      // 리더보드 데이터 로드
      add(const LeaderboardLoadRequested());
    } catch (e) {
      emit(
        state.copyWith(isBusy: false, error: '연도와 시즌 데이터를 불러오는데 실패했습니다: $e'),
      );
    }
  }

  /// 리더보드 데이터 로드 요청 처리
  Future<void> _onLoadRequested(
    LeaderboardLoadRequested event,
    Emitter<LeaderboardState> emit,
  ) async {
    await _loadEntries(emit);
  }

  //==================================================
  // 필터 선택 이벤트 핸들러
  //==================================================

  /// 연도 선택 이벤트 핸들러
  Future<void> _onYearSelected(
    YearSelected event,
    Emitter<LeaderboardState> emit,
  ) async {
    emit(state.copyWith(selectedYear: event.year, currentPage: 1));
    await _loadEntries(emit);
  }

  /// 시즌 선택 이벤트 핸들러
  Future<void> _onSeasonSelected(
    SeasonSelected event,
    Emitter<LeaderboardState> emit,
  ) async {
    final currentSeasons = List<String>.from(state.selectedSeasons);

    // 이미 선택된 시즌이면 제거, 아니면 추가
    if (currentSeasons.contains(event.season)) {
      // 적어도 하나의 시즌은 선택되어 있어야 함
      if (currentSeasons.length > 1) {
        currentSeasons.remove(event.season);
      }
    } else {
      currentSeasons.add(event.season);
    }

    emit(
      state.copyWith(
        selectedSeasons: currentSeasons,
        currentPage: 1,
        isNewEntry: true,
      ),
    );
    await _loadEntries(emit);
  }

  // 검색어 변경 이벤트 핸들러
  Future<void> _onSearchChanged(
    LeaderboardSearchChanged event,
    Emitter<LeaderboardState> emit,
  ) async {
    // keyword를 변경하고 changeBool을 true로 설정
    emit(
      state.copyWith(
        keyword: event.keyword,
        currentPage: 1,
        isNewEntry: true, // 변경 플래그 활성화
      ),
    );

    // 검색어로 필터링된 데이터 로드
    await _loadEntries(emit);
  }

  //==================================================
  // 유틸리티 메서드
  //==================================================

  /// 리더보드 항목 로드 및 상태 업데이트
  Future<void> _loadEntries(Emitter<LeaderboardState> emit) async {
    emit(state.copyWith(isBusy: true));

    try {
      final entries = await repository.getLeaderboardEntries(
        keyword: state.keyword,
        seasonYear: state.selectedYear,
        seasonNames: state.selectedSeasons,
        page: 1,
        pageSize: _pageSize,
      );

      emit(
        state.copyWith(
          isBusy: false,
          entries: entries,
          isNewEntry: false, // 처리 후 false로 재설정
        ),
      );
    } catch (e) {
      emit(state.copyWith(isBusy: false, error: e.toString()));
    }
  }

  Future<void> _onLoadMore(
    LoadMoreLeaderboard event,
    Emitter<LeaderboardState> emit,
  ) async {
    // 이미 로딩 중인 경우 추가 요청을 무시
    if (state.isBusy) return;

    try {
      // 다음 페이지 데이터 로드
      final entries = await repository.getLeaderboardEntries(
        keyword: state.keyword,
        seasonYear: state.selectedYear,
        seasonNames: state.selectedSeasons,
        page: state.currentPage + 1, // 다음 페이지 번호
        pageSize: _pageSize,
      );

      // 기존 데이터에 새로 로드된 데이터 추가
      final updatedEntries = List<LeaderboardEntry>.from(state.entries)
        ..addAll(entries);

      emit(
        state.copyWith(
          entries: updatedEntries,
          currentPage: state.currentPage + 1,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isBusy: false, error: e.toString()));
    }
  }
}
