import 'package:flutter/material.dart';
import 'package:BlockPuzzle/theme/component/constrained_screen.dart';
import 'package:BlockPuzzle/view/game/game_view.dart';
import 'package:BlockPuzzle/view/game_over/game_over_view.dart';
import 'package:BlockPuzzle/view/login/login_view.dart';
import 'package:BlockPuzzle/view/main/home/home_view.dart';
import 'package:BlockPuzzle/view/main/leaderboard/leader_board_view.dart';
import 'package:BlockPuzzle/view/main/settings/settings_view.dart';

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
      case RoutePath.home:
        page = const HomeView();
        break;
      case RoutePath.game:
        page = const GameView();
        break;
      case RoutePath.gameOver:
        final argScore = settings.arguments as int? ?? 0;
        page = GameOverView(lastScore: argScore);
        break;
      case RoutePath.leaderboard:
        page = LeaderboardView();
        break;
      case RoutePath.settings:
        page = const SettingsView();
        break;
      default:
        page = const LoginView(); // 기본 페이지
    }
    return PageRouteBuilder(
      pageBuilder:
          (context, animation, secondaryAnimation) =>
              ConstrainedScreen(child: page),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeInOut;

        final scaleAnimation = Tween<double>(
          begin: 0.9,
          end: 1.0,
        ).chain(CurveTween(curve: curve)).animate(animation);

        return ScaleTransition(
          scale: scaleAnimation,
          child: FadeTransition(opacity: animation, child: child),
        );
      },
    );
  }
}
