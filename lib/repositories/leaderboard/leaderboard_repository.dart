// lib/repositories/leaderboard_repository.dart
import 'package:tetris_app/models/leaderboard_entry.dart';
import 'package:tetris_app/models/season.dart';

abstract class LeaderboardRepository {
  
  // 모든 연도와 시즌 정보 가져오기
  Future<List<YearSeasons>> getAllYearsAndSeasons();
  
    // 리더보드 항목 조회 (검색, 필터링, 페이징 지원)
  Future<List<LeaderboardEntry>> getLeaderboardEntries({
    String? keyword,
    int? seasonYear,
    List<String>? seasonNames,
    int page = 1,
    int pageSize = 20,
  });
}
