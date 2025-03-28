import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:BlockPuzzle/models/dto/score_dto.dart';
import 'package:BlockPuzzle/models/score.dart';
import 'package:BlockPuzzle/repositories/score/score_repository.dart';

class ScoreRepositoryImpl implements ScoreRepository {
  Database? _db;
  final Dio dio;
  final String baseUrl;

  ScoreRepositoryImpl({required this.dio, required this.baseUrl, Database? db})
    : _db = db;

  /// DB 초기화 및 테이블 생성
  @override
  Future<void> init() async {
    if (_db != null) return; // 이미 초기화되어 있으면 리턴

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'scores.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE scores(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            userName TEXT,
            score INTEGER,
            dateTime TEXT
          )
        ''');
      },
    );
  }

  /// 점수 서버로 전송
  Future<void> sendScoreToServer(ScoreDto scoreDto) async {
    log("전송 데이터: ${scoreDto.toJson()}"); // 전송 데이터 로그 출력

    final url = "$baseUrl/scores";
    try {
      final response = await dio.post(
        url,
        data: {
          "userName": scoreDto.userName,
          "score": scoreDto.score,
          "dateTime": scoreDto.dateTime,
        },
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        log("POST 점수 전송 성공: ${response.data}");
      } else {
        log(
          "POST 점수 전송 실패: statusCode=${response.statusCode}, response=${response.data}",
        );
        throw Exception("점수 전송에 실패했습니다.");
      }
    } catch (e, stack) {
      log("POST 점수 전송 에러: $e");
      log("$stack");
      throw Exception("점수 전송에 실패했습니다: $e");
    }
  }

  // 기존 메서드들 유지
  @override
  Future<int> addScore(Score score) async {
    if (_db == null) await init();
    return await _db!.insert('scores', score.toMap());
  }

  @override
  Future<void> deleteAllScores() async {
    if (_db == null) await init();
    await _db!.delete('scores');
  }

  @override
  Future<int> deleteScore(int id) async {
    if (_db == null) await init();
    return await _db!.delete('scores', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<Score>> getAllScores() async {
    if (_db == null) await init();
    final List<Map<String, dynamic>> result = await _db!.query(
      'scores',
      orderBy: 'dateTime DESC',
    );
    return result.map((map) => Score.fromMap(map)).toList();
  }

  @override
  Future<Map<String, dynamic>> getSeasonData() async {
    final url = "$baseUrl/scores/season";
    try {
      final response = await dio.get(url);
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        log("GET 시즌 데이터 성공: ${response.data}");
        final data = response.data;
        final seasonBestScore =
            data['seasonBestScore'] != null
                ? Score.fromMap(data['seasonBestScore'])
                : null;
        final percentile = data['percentile']?.toDouble() ?? 0.0;

        return {'seasonBestScore': seasonBestScore, 'percentile': percentile};
      } else {
        log(
          "GET 시즌 데이터 실패: statusCode=${response.statusCode}, response=${response.data}",
        );
        throw Exception("시즌 데이터를 가져오는데 실패했습니다.");
      }
    } catch (e, stack) {
      log("GET 시즌 데이터 에러: $e");
      log("$stack");
      throw Exception("시즌 데이터를 가져오는데 실패했습니다: $e");
    }
  }
}
