import 'package:BlockPuzzle/service/theme/theme_service.dart';
import 'package:flutter/material.dart';

class BaseBottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavigationBarItem>? items;
  final bool isOnline; // 네트워크 상태를 나타내는 매개변수 추가

  const BaseBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.items,
    required this.isOnline, // isOnline을 필수 매개변수로 추가
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme; // ThemeService에서 테마 가져오기

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: theme.color.primary,
      unselectedItemColor: theme.color.inactive,
      backgroundColor: theme.color.surface,
      items:
          items ??
          [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.leaderboard,
                color: isOnline ? null : Colors.grey, // 네트워크 상태에 따라 색상 변경
              ),
              label: 'Leaderboard',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
    );
  }
}
