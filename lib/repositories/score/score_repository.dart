import 'package:BlockPuzzle/models/score.dart';

abstract class ScoreRepository {
  /// 데이터베이스 초기화
  Future<void> init();
  
  /// 점수 기록 추가
  Future<int> addScore(Score score);
  
  /// 모든 점수 기록 불러오기 (최신순)
  Future<List<Score>> getAllScores();
  
  /// 특정 점수 기록 삭제
  Future<int> deleteScore(int id);
  
  /// 모든 점수 기록 삭제
  Future<void> deleteAllScores();
  
  /// 시즌 데이터 가져오기
  Future<Map<String, dynamic>> getSeasonData();
}