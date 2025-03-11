import 'package:equatable/equatable.dart';
import 'package:tetris_app/view/base_view_state.dart';

/// 로그인 화면의 상태를 관리하는 모델 클래스이다.
/// BaseViewState를 상속받고 EquatableMixin을 사용하여 값 비교를 용이하게 구현하였사있다.
class LoginViewState extends BaseViewState with EquatableMixin {
  /// 사용자가 입력한 ID
  final String userId;
  /// 로딩 중인지 여부
  final bool isLoading;
  /// 로그인 성공 여부
  final bool isSuccess;
  /// 에러 메시지 (있을 경우)
  final String? error;

  const LoginViewState({
    this.userId = '',
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
    required super.isBusy,
  });

  /// 상태 변경 시 불변성을 유지하며 새로운 상태를 생성하기 위한 메서드
  LoginViewState copyWith({
    String? userId,
    bool? isLoading,
    bool? isSuccess,
    String? error,
    bool? isBusy,
  }) {
    return LoginViewState(
      userId: userId ?? this.userId,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
      isBusy: isBusy ?? this.isBusy,
    );
  }

  @override
  List<Object?> get props => [userId, isLoading, isSuccess, error, isBusy];
}