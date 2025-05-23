import 'package:BlockPuzzle/repositories/user/user_repository.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepositoryImpl implements UserRepository {
  final Dio dio;
  final String baseUrl;
  final SharedPreferences sharedPreferences;

  UserRepositoryImpl({
    required this.dio,
    required this.baseUrl,
    required this.sharedPreferences,
  });

  @override
  Future<void> saveUserId(String userId) async {
    await sharedPreferences.setString('userId', userId);
  }

  @override
  Future<String?> loadUserId() async {
    return sharedPreferences.getString('userId');
  }

  @override
  Future<bool> checkUserIdExists(String userId) async {
    try {
      final response = await dio.get(
        '$baseUrl/users/check',
        queryParameters: {'userId': userId},
      );

      if (response.statusCode == 200) {
        final exists = response.data['exists'] as bool;
        return exists;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> registerUserId(String userId) async {
    try {
      // 서버로 POST 요청 보내기
      final response = await dio.post(
        '$baseUrl/users/register', // 서버 엔드포인트
        data: {'userId': userId}, // 요청 데이터
      );

      // 응답 상태 코드 확인
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true; // 성공적으로 등록됨
      } else {
        return false; // 등록 실패
      }
    } catch (e) {
      // 예외 처리
      print('Error registering user ID: $e');
      return false;
    }
  }

  @override
  Future<bool> validateAndSaveUserId(String userId) async {
    try {
      // 서버에 ID가 있는지 확인
      final exists = await checkUserIdExists(userId);

      if (exists) {
        // 존재하는 ID면 로컬에만 저장
        await saveUserId(userId);
        return true;
      } else {
        // 존재하지 않으면 서버에 등록 후 로컬에 저장
        final registered = await registerUserId(userId);
        if (registered) {
          await saveUserId(userId);
          return true;
        }
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
