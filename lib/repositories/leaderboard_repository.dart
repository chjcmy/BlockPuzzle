// leaderboard_repository.dart
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tetris_app/models/leaderboard_entry.dart';
import 'package:tetris_app/utils/helper/net_helper.dart';

class LeaderboardRepository {
  // 기본 베이스 URL: localhost:3000
  static const String baseUrl = "http://1.232.205.46:3000";
  // dio 인스턴스 (NetworkHelper.dio를 사용한다고 가정)
  final Dio dio = NetworkHelper.dio;

  /// GET /scores?keyword=...&skip=...&take=...
  /// keyword가 주어지면 해당 키워드를 포함한 Score 데이터를 조회하고,
  /// 페이지 번호(page)와 한 페이지 당 항목 수(pageSize)를 적용하여
  /// LeaderboardEntry 리스트를 반환합니다.
  Future<List<LeaderboardEntry>> getLeaderboardEntries({
    String? keyword,
    int page = 1,
    int pageSize = 10,
  }) async {
    // 페이지 번호는 1부터 시작하므로 skip 계산: (page - 1) * pageSize
    final int skip = (page - 1) * pageSize;
    final int take = pageSize;

    // URL 구성: 검색어와 페이징 정보 추가
    String url = "$baseUrl/scores";
    if (keyword != null && keyword.isNotEmpty) {
      url += "?keyword=$keyword&skip=$skip&take=$take";
    } else {
      url += "?skip=$skip&take=$take";
    }

    try {
      final res = await dio.get(url);

      // 응답 데이터 타입에 따라 처리
      final List<dynamic> data;
      if (res.data is String) {
        data = jsonDecode(res.data);
      } else if (res.data is List) {
        data = res.data;
      } else {
        throw Exception(
          "Unexpected response data type: ${res.data.runtimeType}",
        );
      }

      // 각 JSON Map을 LeaderboardEntry 객체로 변환합니다.
      final entries =
          data.map<LeaderboardEntry>((json) {
            return LeaderboardEntry.fromJson(json);
          }).toList();

      // 페이지 기반 순위 재설정 (전체 데이터 기준 순위)
      for (int i = 0; i < entries.length; i++) {
        entries[i] = LeaderboardEntry(
          rank: skip + i + 1,
          name: entries[i].name,
          score: entries[i].score,
        );
      }
      return entries;
    } catch (e, stack) {
      log("getLeaderboardEntries 에러: $e");
      log("$stack");
      return [];
    }
  }

  /// POST /scores
  /// 주어진 Score 데이터를 서버로 전송합니다.
  Future<bool> postScore(Map<String, dynamic> scoreData) async {
    final url = "$baseUrl/scores";
    try {
      final response = await dio.post(
        url,
        data: scoreData,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        log("POST 성공: ${response.data}");
        return true;
      } else {
        log(
          "POST 실패: statusCode=${response.statusCode}, response=${response.data}",
        );
        return false;
      }
    } catch (e, stack) {
      log("POST 에러: $e");
      log("$stack");
      return false;
    }
  }
}
