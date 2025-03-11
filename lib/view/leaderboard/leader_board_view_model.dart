import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tetris_app/models/leaderboard_entry.dart';
import 'package:tetris_app/repositories/leaderboard_repository.dart';
import 'package:tetris_app/view/base_view_model.dart';
import 'package:tetris_app/view/base_view_state.dart';

part 'leader_board_view_event.dart';
part 'leader_board_view_state.dart';

class LeaderboardViewModel
    extends BaseViewModel<LeaderboardEvent, LeaderboardState> {
  // 페이지 사이즈 (한 번에 불러올 아이템 수)
  static const int _pageSize = 20;
  // 현재 페이지 번호 (초기값 1)
  final LeaderboardRepository repository;

  LeaderboardViewModel({required this.repository})
    : super(LeaderboardState.initial()) {
    on<LeaderboardLoadRequested>(_onLoadRequested);
    on<LeaderboardSearchChanged>(_onSearchChanged);
    on<LoadMoreLeaderboard>(_onLoadMore);
  }

  /// 초기 리더보드 목록 로드 (첫 페이지)
  Future<void> _onLoadRequested(
    LeaderboardLoadRequested event,
    Emitter<LeaderboardState> emit,
  ) async {
    emit(state.copyWith(isBusy: true, error: null));
    try {
      final entries = await repository.getLeaderboardEntries(
        keyword: state.keyword,
        page: 1,
        pageSize: _pageSize,
      );
      emit(state.copyWith(isBusy: false, entries: entries));
      log('Leaderboard loaded: $entries');
    } catch (e) {
      emit(state.copyWith(isBusy: false, error: e.toString()));
    }
  }

  /// 추가 페이지 로드 이벤트 핸들러 (페이징)
  Future<void> _onLoadMore(
    LoadMoreLeaderboard event,
    Emitter<LeaderboardState> emit,
  ) async {
    if (state.isBusy) return;
    // 현재 state의 currentPage 값을 사용하여 새로운 페이지 번호 계산
    int newPage = state.currentPage + 1;
    emit(state.copyWith(isBusy: true));
    try {
      final moreEntries = await repository.getLeaderboardEntries(
        keyword: state.keyword,
        page: newPage,
        pageSize: _pageSize,
      );
      final updatedEntries = List<LeaderboardEntry>.from(state.entries)
        ..addAll(moreEntries);
      emit(
        state.copyWith(
          isBusy: false,
          entries: updatedEntries,
          currentPage: newPage,
        ),
      );
      log('Loaded more entries: $moreEntries');
    } catch (e) {
      emit(state.copyWith(isBusy: false, error: e.toString()));
    }
  }

  /// 검색어 변경 이벤트 핸들러
  Future<void> _onSearchChanged(
    LeaderboardSearchChanged event,
    Emitter<LeaderboardState> emit,
  ) async {
    final newKeyword = event.keyword;
    if (newKeyword != state.keyword) {
      // 검색어 변경 시 페이징 리셋 (currentPage 1로) 및 데이터 재로드
      emit(state.copyWith(isBusy: true, keyword: newKeyword, currentPage: 1));
      try {
        final newEntries = await repository.getLeaderboardEntries(
          keyword: newKeyword,
          page: 1,
          pageSize: _pageSize,
        );
        emit(state.copyWith(isBusy: false, entries: newEntries));
        log('Leaderboard reloaded with keyword "$newKeyword": $newEntries');
      } catch (e) {
        emit(state.copyWith(isBusy: false, error: e.toString()));
      }
    }
  }
}
