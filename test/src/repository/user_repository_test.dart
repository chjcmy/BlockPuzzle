import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:BlockPuzzle/repositories/user/user_repository_impl.dart';

import 'user_repository_test.mocks.dart';

@GenerateMocks([Dio, SharedPreferences])
void main() {
  // Flutter 서비스 바인딩 초기화
  TestWidgetsFlutterBinding.ensureInitialized();

  group('UserRepositoryImpl Tests', () {
    late MockDio mockDio;
    late MockSharedPreferences mockSharedPreferences;
    late UserRepositoryImpl userRepository;
    const baseUrl = 'http://localhost:8080';

    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      SharedPreferences.setMockInitialValues({}); // Mock 초기화
      mockDio = MockDio();
      mockSharedPreferences = MockSharedPreferences();
      userRepository = UserRepositoryImpl(
        dio: mockDio,
        baseUrl: baseUrl,
        sharedPreferences: mockSharedPreferences, // MockSharedPreferences 주입
      );
    });

    test('saveUserId saves userId to SharedPreferences', () async {
      when(
        mockSharedPreferences.setString('userId', 'testUser'),
      ).thenAnswer((_) async => true);

      await userRepository.saveUserId('testUser');

      verify(mockSharedPreferences.setString('userId', 'testUser')).called(1);
    });

    test('loadUserId retrieves userId from SharedPreferences', () async {
      when(mockSharedPreferences.getString('userId')).thenReturn('testUser');

      final userId = await userRepository.loadUserId();

      expect(userId, 'testUser');
      verify(mockSharedPreferences.getString('userId')).called(1);
    });

    test('checkUserIdExists returns true if userId exists on server', () async {
      when(
        mockDio.get(
          '$baseUrl/users/check',
          queryParameters: {'userId': 'testUser'},
        ),
      ).thenAnswer(
        (_) async => Response(
          data: {'exists': true},
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final exists = await userRepository.checkUserIdExists('testUser');

      expect(exists, true);
      verify(
        mockDio.get(
          '$baseUrl/users/check',
          queryParameters: {'userId': 'testUser'},
        ),
      ).called(1);
    });

    test(
      'checkUserIdExists returns false if userId does not exist on server',
      () async {
        when(
          mockDio.get(
            '$baseUrl/users/check',
            queryParameters: {'userId': 'testUser'},
          ),
        ).thenAnswer(
          (_) async => Response(
            data: {'exists': false},
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ),
        );

        final exists = await userRepository.checkUserIdExists('testUser');

        expect(exists, false);
        verify(
          mockDio.get(
            '$baseUrl/users/check',
            queryParameters: {'userId': 'testUser'},
          ),
        ).called(1);
      },
    );

    test('registerUserId returns true if registration is successful', () async {
      when(
        mockDio.post('$baseUrl/users/register', data: {'userId': 'testUser'}),
      ).thenAnswer(
        (_) async =>
            Response(statusCode: 201, requestOptions: RequestOptions(path: '')),
      );

      final registered = await userRepository.registerUserId('testUser');

      expect(registered, true);
      verify(
        mockDio.post('$baseUrl/users/register', data: {'userId': 'testUser'}),
      ).called(1);
    });

    test('registerUserId returns false if registration fails', () async {
      when(
        mockDio.post('$baseUrl/users/register', data: {'userId': 'testUser'}),
      ).thenAnswer(
        (_) async =>
            Response(statusCode: 400, requestOptions: RequestOptions(path: '')),
      );

      final registered = await userRepository.registerUserId('testUser');

      expect(registered, false);
      verify(
        mockDio.post('$baseUrl/users/register', data: {'userId': 'testUser'}),
      ).called(1);
    });

    test('validateAndSaveUserId saves userId if it exists on server', () async {
      when(
        mockDio.get(
          '$baseUrl/users/check',
          queryParameters: {'userId': 'testUser'},
        ),
      ).thenAnswer(
        (_) async => Response(
          data: {'exists': true},
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );
      when(
        mockSharedPreferences.setString('userId', 'testUser'),
      ).thenAnswer((_) async => true);

      final result = await userRepository.validateAndSaveUserId('testUser');

      expect(result, true);
      verify(
        mockDio.get(
          '$baseUrl/users/check',
          queryParameters: {'userId': 'testUser'},
        ),
      ).called(1);
      verify(mockSharedPreferences.setString('userId', 'testUser')).called(1);
    });

    test(
      'validateAndSaveUserId registers and saves userId if it does not exist on server',
      () async {
        when(
          mockDio.get(
            '$baseUrl/users/check',
            queryParameters: {'userId': 'testUser'},
          ),
        ).thenAnswer(
          (_) async => Response(
            data: {'exists': false},
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ),
        );
        when(
          mockDio.post('$baseUrl/users/register', data: {'userId': 'testUser'}),
        ).thenAnswer(
          (_) async => Response(
            statusCode: 201,
            requestOptions: RequestOptions(path: ''),
          ),
        );
        when(
          mockSharedPreferences.setString('userId', 'testUser'),
        ).thenAnswer((_) async => true);

        final result = await userRepository.validateAndSaveUserId('testUser');

        expect(result, true);
        verify(
          mockDio.get(
            '$baseUrl/users/check',
            queryParameters: {'userId': 'testUser'},
          ),
        ).called(1);
        verify(
          mockDio.post('$baseUrl/users/register', data: {'userId': 'testUser'}),
        ).called(1);
        verify(mockSharedPreferences.setString('userId', 'testUser')).called(1);
      },
    );

    test('validateAndSaveUserId returns false if registration fails', () async {
      when(
        mockDio.get(
          '$baseUrl/users/check',
          queryParameters: {'userId': 'testUser'},
        ),
      ).thenAnswer(
        (_) async => Response(
          data: {'exists': false},
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );
      when(
        mockDio.post('$baseUrl/users/register', data: {'userId': 'testUser'}),
      ).thenAnswer(
        (_) async =>
            Response(statusCode: 400, requestOptions: RequestOptions(path: '')),
      );

      final result = await userRepository.validateAndSaveUserId('testUser');

      expect(result, false);
      verify(
        mockDio.get(
          '$baseUrl/users/check',
          queryParameters: {'userId': 'testUser'},
        ),
      ).called(1);
      verify(
        mockDio.post('$baseUrl/users/register', data: {'userId': 'testUser'}),
      ).called(1);
    });
  });
}
