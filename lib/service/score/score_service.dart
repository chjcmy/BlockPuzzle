import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:BlockPuzzle/models/score.dart';
import 'package:BlockPuzzle/models/score_type.dart';
import 'package:BlockPuzzle/repositories/score/score_repository_impl.dart';

part 'score_event.dart';
part 'score_state.dart';

class ScoreService extends Bloc<ScoreEvent, ScoreState> {
  final ScoreRepositoryImpl scoreRepository;

  ScoreService({required this.scoreRepository}) : super(ScoreInitial()) {
    on<LoadScores>(_onLoadScores);
    on<DeleteAllScores>(_onDeleteAllScores);
    on<ScoreUpdated>(_onScoreUpdated);
    on<SortScores>(_onSortScores);
  }

  Future<void> _onLoadScores(LoadScores event, Emitter<ScoreState> emit) async {
    emit(ScoreLoading());
    try {
      final scores = await scoreRepository.getAllScores();
      emit(ScoreLoaded(scores));
    } catch (e) {
      emit(ScoreError('Failed to load scores: $e'));
    }
  }

  Future<void> _onDeleteAllScores(
    DeleteAllScores event,
    Emitter<ScoreState> emit,
  ) async {
    emit(ScoreLoading());
    try {
      await scoreRepository.deleteAllScores();
      emit(const ScoreLoaded([]));
      // 다른 화면에 알리기 위해 ScoreUpdated 이벤트 발생
      add(ScoreUpdated());
    } catch (e) {
      emit(ScoreError('Failed to delete scores: $e'));
    }
  }

  void _onScoreUpdated(ScoreUpdated event, Emitter<ScoreState> emit) {
    // 이미 상태가 ScoreLoaded라면 그대로 유지, 아니면 데이터 로드
    if (state is! ScoreLoaded) {
      add(LoadScores());
    }
  }

  void _onSortScores(SortScores event, Emitter<ScoreState> emit) {
    if (state is ScoreLoaded) {
      final currentScores = (state as ScoreLoaded).scores;
      final sortedScores = List<Score>.from(currentScores);

      if (event.sortType == ScoreSortType.highScore) {
        sortedScores.sort((a, b) => b.score.compareTo(a.score));
      } else {
        sortedScores.sort((a, b) => b.dateTime.compareTo(a.dateTime));
      }

      emit(ScoreLoaded(sortedScores));
    }
  }
}

extension ScoreServiceExt on BuildContext {
  ScoreService get scoreService => read<ScoreService>();
  ScoreState get scoreState => scoreService.state;
  List<Score> get scores =>
      scoreState is ScoreLoaded ? (scoreState as ScoreLoaded).scores : [];
  bool get isScoreLoading => scoreState is ScoreLoading;
  String? get scoreError =>
      scoreState is ScoreError ? (scoreState as ScoreError).message : null;
}
