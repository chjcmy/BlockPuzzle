// lib/view/settings/settings_view_model.dart
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tetris_app/repositories/user_repository.dart';
import 'package:tetris_app/service/score/score_service.dart';
import 'package:tetris_app/view/base_view_model.dart';
import 'package:tetris_app/view/settings/settings_view_event.dart';
import 'package:tetris_app/view/settings/settings_view_state.dart';

class SettingsViewModel
    extends BaseViewModel<SettingsViewEvent, SettingsViewState> {
  final UserRepository userRepository;
  final ScoreService scoreService; // 추가

  SettingsViewModel({
    required this.userRepository,
    required this.scoreService, // 추가
  }) : super(SettingsViewState.initial()) {
    on<SettingsInitialized>(_onSettingsInitialized);
    on<ChangeUserIdRequested>(_onChangeUserIdRequested);
    on<DeleteAllDataRequested>(_onDeleteAllDataRequested);
  }

  Future<void> _onSettingsInitialized(
    SettingsInitialized event,
    Emitter<SettingsViewState> emit,
  ) async {
    emit(state.copyWith(isBusy: true));

    try {
      final userId = await userRepository.loadUserId() ?? '';

      emit(state.copyWith(isBusy: false, userId: userId));
    } catch (e) {
      log('설정 로드 오류: $e');
      emit(state.copyWith(isBusy: false, error: '설정을 불러오는 중 오류가 발생했습니다.'));
    }
  }

  void _onChangeUserIdRequested(
    ChangeUserIdRequested event,
    Emitter<SettingsViewState> emit,
  ) {
    // 아이디 변경 로직은 별도의 화면으로 이동하므로 여기서는 이벤트만 처리
    log('아이디 변경 요청됨');
  }

  Future<void> _onDeleteAllDataRequested(
    DeleteAllDataRequested event,
    Emitter<SettingsViewState> emit,
  ) async {
    emit(state.copyWith(isBusy: true));

    try {
      scoreService.add(DeleteAllScores());
      emit(state.copyWith(isBusy: false));
    } catch (e) {
      log('데이터 삭제 오류: $e');
      emit(state.copyWith(isBusy: false, error: '데이터를 삭제하는 중 오류가 발생했습니다.'));
    }
  }
}
