import 'package:flutter/material.dart';
import 'package:tetris_app/theme/component/constrained_screen.dart';
import 'package:tetris_app/view/game/game_view.dart';
import 'package:tetris_app/view/game_over/game_over_view.dart';
import 'package:tetris_app/view/home/home_view.dart';
import 'package:tetris_app/view/leaderboard/leader_board_view.dart';
import 'package:tetris_app/view/login/login_view.dart';

/// RoutePath는 어플리케이션 내의 각 화면으로의 경로를 정의하고,
/// onGenerateRoute 함수를 통해 화면 전환을 담당하는 클래스이옵니다.
abstract class RoutePath {
  static const String login = 'login';
  static const String home = 'home';
  static const String game = 'game';
  static const String gameOver = 'gameOver';
  static const String leaderboard = 'leaderboard';
  static const String settings = 'settings';

  /// onGenerateRoute는 설정된 경로 이름에 따라 적절한 화면 위젯을 반환하사옵니다.
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    late final Widget page;
    switch (settings.name) {
      case RoutePath.login:
        page = const LoginView();
        break;
      case home:
        page = const HomeView();
        break;
      case game:
        page = const GameView();
        break;
      case gameOver:
        final argScore = settings.arguments as int? ?? 0;
        page = GameOverView(lastScore: argScore);
        break;
      case leaderboard:
        page = LeaderboardView();
        break;
    }
    return MaterialPageRoute(
      builder: (context) => ConstrainedScreen(child: page),
    );
  }
}
