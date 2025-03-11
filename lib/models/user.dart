import 'package:equatable/equatable.dart';

/// User 클래스는 간단한 사용자 정보를 관리하기 위한 모델로, Equatable을 상속받아 값 비교가 용이하사옵니다.
class User extends Equatable {
  final String id;
  final String username;
  final String? avatarUrl;

  const User({required this.id, required this.username, this.avatarUrl});

  /// 선택적 속성 변경을 위한 복사 생성자
  User copyWith({String? id, String? username, String? avatarUrl}) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  @override
  List<Object?> get props => [id, username, avatarUrl];
}
