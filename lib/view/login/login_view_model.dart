import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tetris_app/repositories/user_repository.dart';
import 'package:tetris_app/view/base_view_model.dart';

import 'login_view_event.dart';
import 'login_view_state.dart';

class LoginViewModel extends BaseViewModel<LoginViewEvent, LoginViewState> {
  final UserRepository userRepository;

  LoginViewModel({required this.userRepository})
      : super(LoginViewState(isBusy: false)) {
    // 이벤트 핸들러 등록
    on<UserIdChanged>(_onUserIdChanged);
    on<LoginButtonPressed>(_onLoginButtonPressed);
    _checkPersistedUser();
  }

  Future<void> _onUserIdChanged(
      UserIdChanged event, Emitter<LoginViewState> emit) async {
    emit(state.copyWith(userId: event.userId, error: null));
  }

  Future<void> _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<LoginViewState> emit) async {
    if (state.userId.trim().isEmpty) {
      emit(state.copyWith(error: 'User ID cannot be empty'));
      return;
    }
    emit(state.copyWith(isLoading: true, error: null));

    await Future.delayed(const Duration(seconds: 1));
    await userRepository.saveUserId(state.userId);

    emit(state.copyWith(isLoading: false, isSuccess: true));
  }

  Future<void> _checkPersistedUser() async {
    final storedUserId = await userRepository.loadUserId();
    if (storedUserId != null && storedUserId.trim().isNotEmpty) {
      add(UserIdChanged(storedUserId));
      add(LoginButtonPressed());
    }
  }
}