import 'package:BlockPuzzle/repositories/leaderboard/leaderboard_repository_impl.dart';
import 'package:BlockPuzzle/repositories/score/score_repository_impl.dart';
import 'package:BlockPuzzle/repositories/user/user_repository_impl.dart';
import 'package:BlockPuzzle/service/connectivity/connectivity_service.dart';
import 'package:BlockPuzzle/service/score/score_service.dart';
import 'package:BlockPuzzle/service/theme/theme_service.dart';
import 'package:BlockPuzzle/utils/helper/net_helper.dart';
import 'package:BlockPuzzle/utils/route_path.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final initialRoute = await getInitialRoute();

  final baseUrl = 'http://1.232.205.46:8080';
  final dio = NetworkHelper.dio;

  final db = await initializeDatabase();

  // SharedPreferences 인스턴스 생성
  final sharedPreferences = await SharedPreferences.getInstance();

  final leaderboardRepo = LeaderboardRepositoryImpl(dio: dio, baseUrl: baseUrl);
  final scoreRepo = ScoreRepositoryImpl(db: db, dio: dio, baseUrl: baseUrl);
  final userRepo = UserRepositoryImpl(
    dio: dio,
    baseUrl: baseUrl,
    sharedPreferences: sharedPreferences,
  );

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => scoreRepo),
        RepositoryProvider(create: (context) => userRepo),
        RepositoryProvider(create: (context) => leaderboardRepo),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeService>(create: (context) => ThemeService()),
          BlocProvider<ScoreService>(
            create:
                (context) => ScoreService(
                  scoreRepository: context.read<ScoreRepositoryImpl>(),
                )..add(LoadScores()), // 점수 로드 이벤트 추가
          ),
          BlocProvider<ConnectivityService>(
            create:
                (context) => ConnectivityService(connectivity: Connectivity()),
          ), // ConnectivityService 추가
        ],
        child: MyApp(initialRoute: initialRoute),
      ),
    ),
  );
}

Future<String> getInitialRoute() async {
  final prefs = await SharedPreferences.getInstance();
  final storedUserId = prefs.getString('userId');
  if (storedUserId != null && storedUserId.trim().isNotEmpty) {
    return RoutePath.home;
  }
  return RoutePath.login;
}

Future<Database> initializeDatabase() async {
  final prefs = await SharedPreferences.getInstance();
  final isDbInitialized = prefs.getBool('isDbInitialized') ?? false;

  final dbPath = await getDatabasesPath();
  final path = join(dbPath, 'scores.db');

  final db = await openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async {
      // 데이터베이스가 처음 생성될 때만 테이블 생성
      await db.execute('''
        CREATE TABLE scores(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          score INTEGER,
          dateTime TEXT
        )
      ''');
    },
  );

  // 데이터베이스가 처음 초기화되었음을 저장
  if (!isDbInitialized) {
    await prefs.setBool('isDbInitialized', true);
  }

  return db;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.initialRoute});
  final String initialRoute;

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      builder:
          (context, child) => Overlay(
            initialEntries: [OverlayEntry(builder: (context) => child!)],
          ),
      theme: context.themeService.themeData,
      initialRoute: initialRoute,
      onGenerateRoute: RoutePath.onGenerateRoute,
    );
  }
}
