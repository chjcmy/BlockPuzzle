import 'package:flutter/material.dart';
import 'package:tetris_app/theme/component/bottom_bar/base_bottom_bar.dart';
import 'package:tetris_app/utils/route_path.dart';

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseBottomBar(
      currentIndex: 0,
      onTap: (index) {
        switch (index) {
          case 0:
            // 홈 화면
            Navigator.pushNamed(context, RoutePath.home);
            break;
          case 1:
            Navigator.pushNamed(context, RoutePath.game);
            break;
          case 2:
            Navigator.pushNamed(context, RoutePath.leaderboard);
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard), // 여기서 변경
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.videogame_asset),
          label: '게임 시작',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.leaderboard),
          label: '전체 순위',
        ),
      ],
    );
  }
}