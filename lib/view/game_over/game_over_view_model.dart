import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tetris_app/models/score.dart';
import 'package:tetris_app/repositories/score_repository.dart';
import 'package:tetris_app/view/base_view_model.dart';
import 'package:tetris_app/view/game_over/game_over_view_event.dart';
import 'package:tetris_app/view/game_over/game_over_view_state.dart';

class GameOverViewModel
    extends BaseViewModel<GameOverEvent, GameOverViewState> {
  final ScoreRepository scoreRepo;
  // 필요시 UserRepository를 추가하여 사용자 ID를 가져올 수 있음

  GameOverViewModel({required this.scoreRepo})
    : super(GameOverViewState.initial()) {
    on<GameOverInitialized>(_onGameOverInitialized);
  }

  /// 게임 오버 이벤트 처리 메서드
  /// - isBusy를 true로 설정하여 로딩 상태를 표시합니다.
  /// - 현재 점수와 현재 시각을 로컬 DB에 저장하고,
  /// - 'http://localhost:2222/scores' 엔드포인트로 POST 전송합니다.
  /// - 작업 완료 후 isBusy를 false로 되돌리고, 최종 점수를 상태에 반영합니다.
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
      await scoreRepo.addScore(scoreObj);

      // // 2) 서버에 POST 전송
      // // 여기서는 예시로 사용자 ID를 'player1'로 하드코딩
      // final userId = 'player1';
      // final response = await NetHelper.postJson(
      //   url: 'http://localhost:2222/scores',
      //   body: {'id': userId, 'score': scoreValue},
      // );

      // if (response != null) {
      //   log('POST 성공: $response');
      // } else {
      //   log('POST 실패');
      // }

      // 3) 최종 점수를 상태에 반영하고, 로딩 종료
      emit(state.copyWith(finalScore: scoreValue, isBusy: false));
    } catch (e) {
      log('오류 발생: $e');
      emit(state.copyWith(finalScore: scoreValue, isBusy: false));
    }
  }
}
