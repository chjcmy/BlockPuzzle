import 'package:flutter/material.dart';
import 'package:tetris_app/theme/component/bottom_bar/base_bottom_bar.dart';
import 'package:tetris_app/utils/route_path.dart';

class LeaderboardBottomBar extends StatelessWidget {
  const LeaderboardBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseBottomBar(
      currentIndex: 2, // 전체 순위 탭이 선택된 상태
      onTap: (index) {
        switch (index) {
          case 0:
            // 홈 화면으로 이동
            Navigator.pushNamed(context, RoutePath.home);
            break;
          case 1:
            // 게임 시작 화면으로 이동
            Navigator.pushNamed(context, RoutePath.game);
            break;
          case 2:
            // 게임 설정 화면으로 이동
            Navigator.pushNamed(context, RoutePath.settings);
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Text("🏠", style: TextStyle(fontSize: 24)),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: Text("🎮", style: TextStyle(fontSize: 24)),
          label: '게임 시작',
        ),
        BottomNavigationBarItem(
          icon: Text("⚙️", style: TextStyle(fontSize: 24)),
          label: '설정',
        ),
      ],
    );
  }
}
