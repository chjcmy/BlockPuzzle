// lib/view/home/widget/home_app_bar.dart
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Home'),
      automaticallyImplyLeading: false, // 뒤로 가기 버튼 제거
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}