import 'package:flutter/material.dart';

class CustomPageViewNavigator extends StatefulWidget {
  final List<Widget> pages;

  const CustomPageViewNavigator({super.key, required this.pages});

  @override
  _CustomPageViewNavigatorState createState() =>
      _CustomPageViewNavigatorState();
}

class _CustomPageViewNavigatorState extends State<CustomPageViewNavigator> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // 스와이프 방지
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: widget.pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _pageController.jumpToPage(index); // 페이지 전환
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Leaderboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
