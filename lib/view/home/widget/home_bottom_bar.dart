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
          icon: Text("🏠", style: TextStyle(fontSize: 24)), // 이모지 아이콘
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: Text("🎮", style: TextStyle(fontSize: 24)), // 이모지 아이콘
          label: '게임 시작',
        ),
        BottomNavigationBarItem(
          icon: Text("🏆", style: TextStyle(fontSize: 24)), // 이모지 아이콘
          label: '전체 순위',
        ),
      ],
    );
  }
}
