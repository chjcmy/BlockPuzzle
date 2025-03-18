// lib/view/settings/widgets/settings_bottom_bar.dart
import 'package:flutter/material.dart';
import 'package:tetris_app/theme/component/bottom_bar/base_bottom_bar.dart';
import 'package:tetris_app/utils/route_path.dart';

class SettingsBottomBar extends StatelessWidget {
  const SettingsBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseBottomBar(
      currentIndex: 2,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, RoutePath.home);
            break;
          case 1:
            Navigator.pushNamed(context, RoutePath.game);
            break;
          case 2:
            // 이미 설정 화면이므로 아무 작업도 하지 않음
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Text("🏠", style: TextStyle(fontSize: 24)),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: Text("🏆", style: TextStyle(fontSize: 24)),
          label: '나의 점수',
        ),
        BottomNavigationBarItem(
          icon: Text("⚙️", style: TextStyle(fontSize: 24)),
          label: '설정',
        ),
      ],
    );
  }
}
