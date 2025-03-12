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
            icon: Text("🏠", style: TextStyle(fontSize: 24)), // 이모지 아이콘
            label: '홈',
          ),
          const BottomNavigationBarItem(
            icon: Text("🎮", style: TextStyle(fontSize: 24)), // 이모지 아이콘
            label: '게임 시작',
          ),
          const BottomNavigationBarItem(
            icon: Text("🏆", style: TextStyle(fontSize: 24)), // 이모지 아이콘
            label: '전체 순위',
          ),
        ];
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: Colors.white, // 배경색 변경
      selectedItemColor: Colors.black, // 선택된 아이템 색상
      unselectedItemColor: Colors.grey, // 선택되지 않은 아이템 색상
      showSelectedLabels: true, // 선택된 아이템 라벨 표시
      showUnselectedLabels: true, // 선택되지 않은 아이템 라벨도 표시
      elevation: 4, // 그림자 효과
      items: _buildItems(context),
    );
  }
}
