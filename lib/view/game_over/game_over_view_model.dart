import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:BlockPuzzle/models/score.dart';
import 'package:BlockPuzzle/repositories/score/score_repository_impl.dart';
import 'package:BlockPuzzle/repositories/user/user_repository_impl.dart';
import 'package:BlockPuzzle/view/base_view_model.dart';
import 'package:BlockPuzzle/view/game_over/game_over_view_event.dart';
import 'package:BlockPuzzle/view/game_over/game_over_view_state.dart';

class GameOverViewModel
    extends BaseViewModel<GameOverEvent, GameOverViewState> {
  final ScoreRepositoryImpl scoreRepository;
  final UserRepositoryImpl userRepository;
  // 필요시 UserRepository를 추가하여 사용자 ID를 가져올 수 있음

  GameOverViewModel({
    required this.scoreRepository,
    required this.userRepository,
  }) : super(GameOverViewState.initial()) {
    on<GameOverInitialized>(_onGameOverInitialized);
  }

  /// 게임 오버 이벤트 처리 메서드
  Future<void> _onGameOverInitialized(
    GameOverInitialized event,
    Emitter<GameOverViewState> emit,
  ) async {
    // 로딩 시작: 화면에 로딩 인디케이터 표시
    emit(state.copyWith(isBusy: true));

    final scoreValue = event.lastScore;

    try {
      // 1) 로컬 DB에 점수 저장 (ScoreRepository 사용)
      final now = DateTime.now();
      final scoreObj = Score(score: scoreValue, dateTime: now);
      await scoreRepository.addScore(scoreObj);
      final userId = await userRepository.loadUserId();

      // 2) 서버로 점수 전송
      try {
        await scoreRepository.sendScoreToServer(scoreObj.toDto(userId));
        log('점수 서버 전송 성공: $scoreValue');
      } catch (e) {
        log('점수 서버 전송 실패: $e');
      }

      // 최종 상태 업데이트
      emit(state.copyWith(finalScore: scoreValue, isBusy: false));
    } catch (e) {
      log('오류 발생: $e');
      emit(state.copyWith(finalScore: scoreValue, isBusy: false));
    }
  }
}
