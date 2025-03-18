// leaderboard_repository.dart
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tetris_app/models/leaderboard_entry.dart';
import 'package:tetris_app/models/season.dart';
import 'package:tetris_app/repositories/leaderboard/leaderboard_repository.dart';

class LeaderboardRepositoryImpl implements LeaderboardRepository {
  final Dio dio;
  final String baseUrl;

  // 생성자에 명시적으로 dio와 baseUrl 매개변수 정의
  LeaderboardRepositoryImpl({required this.dio, required this.baseUrl});

  @override
  Future<List<YearSeasons>> getAllYearsAndSeasons() async {
    try {
      final response = await dio.get('$baseUrl/seasons');

      if (response.data is List) {
        return (response.data as List)
            .map((item) => YearSeasons.fromJson(item))
            .toList();
      }

      return []; // 시즌 정보가 없는 경우
    } catch (e) {
      log('getAllYearsAndSeasons 에러: $e');
      return []; // 오류 발생 시 빈 목록 반환
    }
  }

  @override
  Future<List<LeaderboardEntry>> getLeaderboardEntries({
    String? keyword,
    int? seasonYear,
    List<String>? seasonNames,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      // 1. API 엔드포인트 및 쿼리 파라미터 구성
      final Uri uri = Uri.parse('$baseUrl/scores/multi-season/flat');

      final queryParams = <String, String>{
        'skip': ((page - 1) * pageSize).toString(),
        'take': pageSize.toString(),
      };

      // 검색어가 있으면 추가
      if (keyword != null && keyword.isNotEmpty) {
        queryParams['keyword'] = keyword;
      }

      // 시즌 연도가 있으면 추가
      if (seasonYear != null && seasonYear > 0) {
        queryParams['seasonYears'] = seasonYear.toString();
      }

      // 시즌 이름 목록이 있으면 추가
      if (seasonNames != null && seasonNames.isNotEmpty) {
        queryParams['seasonNames'] = seasonNames.join(',');
      }

      final requestUri = uri.replace(queryParameters: queryParams);

      // 2. API 호출
      final response = await dio.getUri(requestUri);

      // 3. 응답 처리
      if (response.statusCode != 200) {
        throw Exception('Failed to load leaderboard: ${response.statusCode}');
      }

      final List<dynamic> data = response.data;

      // 4. 응답 데이터를 LeaderboardEntry 객체로 변환
      final entries = <LeaderboardEntry>[];
      for (int i = 0; i < data.length; i++) {
        final entry = LeaderboardEntry(
          name: data[i]['name'] ?? '',
          score: data[i]['score'] ?? 0,
          dateTime: data[i]['dateTime'] ?? '',
          seasonYear: data[i]['seasonYear'] ?? 0,
          seasonName: data[i]['seasonName'] ?? '',
          percentage: data[i]['percentage'] ?? 0.0,
        );
        entries.add(entry);
      }

      return entries;
    } catch (e) {
      log('getLeaderboardEntries 에러: $e');
      return [];
    }
  }
}
