import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tetris_app/models/score.dart';


class ScoreRepository {
  Database? _db;

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
    final List<Map<String, dynamic>> result =
        await _db!.query('scores', orderBy: 'dateTime DESC');
    return result.map((map) => Score.fromMap(map)).toList();
  }

  /// 점수 기록 삭제 (선택사항)
  Future<int> deleteScore(int id) async {
    if (_db == null) await init();
    return await _db!.delete(
      'scores',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}