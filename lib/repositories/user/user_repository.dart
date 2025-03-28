abstract class UserRepository {
  /// 사용자 ID를 저장합니다.
  Future<void> saveUserId(String userId);
  
  /// 저장된 사용자 ID를 불러옵니다.
  Future<String?> loadUserId();
  
  /// 서버에 사용자 ID가 존재하는지 확인합니다.
  Future<bool> checkUserIdExists(String userId);
  
  /// 새로운 사용자 ID를 서버에 등록합니다.
  Future<bool> registerUserId(String userId);
  
  /// 사용자 ID를 검증하고 저장합니다.
  Future<bool> validateAndSaveUserId(String userId);
}