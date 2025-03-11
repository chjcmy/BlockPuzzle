import 'package:flutter/material.dart';

class BaseBottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavigationBarItem>? items;

  const BaseBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.items,
  });

  List<BottomNavigationBarItem> _buildItems(BuildContext context) {
    return items ??
        [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset),
            label: '게임 시작',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: '전체 순위',
          ),
        ];
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: _buildItems(context),
    );
  }
}