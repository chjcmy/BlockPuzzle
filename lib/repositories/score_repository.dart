import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tetris_app/models/score.dart';
import 'package:tetris_app/utils/helper/net_helper.dart';

class ScoreRepository {
  Database? _db;
  // 기본 베이스 URL: localhost:3000
  static const String baseUrl = "http://1.232.205.46:3000";
  // dio 인스턴스 (NetworkHelper.dio를 사용한다고 가정)
  final Dio dio = NetworkHelper.dio;

  /// DB 초기화 및 테이블 생성
  Future<void> init() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'scores.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE scores(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            score INTEGER,
            dateTime TEXT
          )
        ''');
      },
    );
  }

  /// 점수 기록 추가
  Future<int> addScore(Score score) async {
    if (_db == null) await init();
    return await _db!.insert('scores', score.toMap());
  }

  /// 모든 점수 기록 불러오기 (최신순)
  Future<List<Score>> getAllScores() async {
    if (_db == null) await init();
    final List<Map<String, dynamic>> result = await _db!.query(
      'scores',
      orderBy: 'dateTime DESC',
    );
    return result.map((map) => Score.fromMap(map)).toList();
  }

  /// 점수 기록 삭제 (선택사항)
  Future<int> deleteScore(int id) async {
    if (_db == null) await init();
    return await _db!.delete('scores', where: 'id = ?', whereArgs: [id]);
  }

  // 점수 기록 삭제 (모두)
  Future<void> deleteAllScores() async {
    if (_db == null) await init();
    await _db!.delete('scores');

    final List<Map<String, dynamic>> result = await _db!.query(
      'scores',
      orderBy: 'dateTime DESC',
    );
  }

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
