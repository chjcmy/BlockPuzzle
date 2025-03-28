import 'package:equatable/equatable.dart';
import 'package:BlockPuzzle/models/score.dart';
import 'package:BlockPuzzle/models/score_type.dart';
import 'package:BlockPuzzle/view/base_view_model.dart';
import 'package:BlockPuzzle/view/base_view_state.dart';

part 'home_view_event.dart';
part 'home_view_state.dart';

class HomeViewModel extends BaseViewModel<HomeViewEvent, HomeViewState> {
  HomeViewModel()
    : super(
        HomeViewState(
          isBusy: false,
          sortType: ScoreSortType.latest,
          error: null,
          seasonBestScore: null,
          seasonPercentile: null,
        ),
      ) {
    // 이벤트 핸들러 등록: 점수 목록 로드
    on<LoadScoreList>((event, emit) async {
      emit(state.copyWith(isBusy: true, error: null));
      try {} catch (e) {
        emit(state.copyWith(isBusy: false, error: e.toString()));
      }
    });

    // 이벤트 핸들러 등록: 점수 목록 정렬
    on<SortScoreList>((event, emit) async {
      emit(state.copyWith(sortType: event.sortType));
    });
  }
}
