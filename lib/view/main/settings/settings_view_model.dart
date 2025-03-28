// lib/view/settings/settings_view_model.dart
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:BlockPuzzle/repositories/user/user_repository_impl.dart';
import 'package:BlockPuzzle/service/score/score_service.dart';
import 'package:BlockPuzzle/view/base_view_model.dart';
import 'package:BlockPuzzle/view/main/settings/settings_view_event.dart';
import 'package:BlockPuzzle/view/main/settings/settings_view_state.dart';

class SettingsViewModel
    extends BaseViewModel<SettingsViewEvent, SettingsViewState> {
  final UserRepositoryImpl userRepository;
  final ScoreService scoreService; // 추가

  SettingsViewModel({
    required this.userRepository,
    required this.scoreService, // 추가
  }) : super(SettingsViewState.initial()) {
    on<SettingsInitialized>(_onSettingsInitialized);
    on<ChangeUserIdRequested>(_onChangeUserIdRequested);
    on<ChangeUserIdConfirmed>(_onChangeUserIdConfirmed);
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
    // 아이디 변경 요청 시 로직 (UI에서 모달을 띄우는 역할)
    log('아이디 변경 요청됨');
  }

  Future<void> _onChangeUserIdConfirmed(
    ChangeUserIdConfirmed event,
    Emitter<SettingsViewState> emit,
  ) async {
    emit(state.copyWith(isBusy: true, error: null));

    try {
      // 아이디 중복 확인
      final userIdExists = await userRepository.checkUserIdExists(event.newUserId);
      if (userIdExists) {
        emit(state.copyWith(
          isBusy: false,
          error: '이미 사용 중인 아이디입니다.',
        ));
        return;
      }

      // 서버에 아이디 저장
      final success = await userRepository.registerUserId(event.newUserId);
      if (!success) {
        emit(state.copyWith(
          isBusy: false,
          error: '아이디 저장 중 오류가 발생했습니다.',
        ));
        return;
      }

      // 로컬에 아이디 저장
      await userRepository.saveUserId(event.newUserId);

      // 상태 업데이트
      emit(state.copyWith(
        isBusy: false,
        userId: event.newUserId,
      ));
    } catch (e) {
      log('아이디 변경 오류: $e');
      emit(state.copyWith(
        isBusy: false,
        error: '아이디 변경 중 오류가 발생했습니다.',
      ));
    }
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
