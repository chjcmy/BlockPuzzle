/// 로그인 화면에서 발생할 수 있는 이벤트들을 정의합니다.
abstract class LoginViewEvent {}

/// 사용자가 ID 입력란의 값을 변경할 때 발생하는 이벤트
class UserIdChanged extends LoginViewEvent {
  final String userId;
  UserIdChanged(this.userId);
}

/// 사용자가 로그인 버튼을 누를 때 발생하는 이벤트
class LoginButtonPressed extends LoginViewEvent {}