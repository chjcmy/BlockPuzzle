// home_view_model.dart
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:tetris_app/models/score.dart';
import 'package:tetris_app/models/score_type.dart';
import 'package:tetris_app/repositories/score_repository.dart';
import 'package:tetris_app/view/base_view_model.dart';
import 'package:tetris_app/view/base_view_state.dart';

part 'home_view_event.dart';
part 'home_view_state.dart';

class HomeViewModel extends BaseViewModel<HomeViewEvent, HomeViewState> {
  final ScoreRepository scoreRepository;

  HomeViewModel({required this.scoreRepository})
      : super(HomeViewState(
          isBusy: false,
          scoreList: const [],
          sortType: ScoreSortType.latest,
          error: null,
        )) {
    // 이벤트 핸들러 등록: 점수 목록 로드
    on<LoadScoreList>((event, emit) async {
      emit(state.copyWith(isBusy: true, error: null));
      try {
        final scores = await scoreRepository.getAllScores();
        log('✅ Loaded scores: $scores');
        emit(state.copyWith(isBusy: false, scoreList: scores));
      } catch (e) {
        emit(state.copyWith(isBusy: false, error: e.toString()));
      }
    });

    // 이벤트 핸들러 등록: 점수 목록 정렬
    on<SortScoreList>((event, emit) async {
      final currentList = List<Score>.from(state.scoreList);
      if (event.sortType == ScoreSortType.highScore) {
        currentList.sort((a, b) => b.score.compareTo(a.score));
      } else {
        currentList.sort((a, b) => b.dateTime.compareTo(a.dateTime));
      }
      emit(state.copyWith(scoreList: currentList, sortType: event.sortType));
    });
  }
}