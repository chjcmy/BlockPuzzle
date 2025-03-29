import 'package:BlockPuzzle/theme/component/bottom_bar/base_bottom_bar.dart';
import 'package:BlockPuzzle/theme/component/theme_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// BaseView: BlocProvider를 사용하여 뷰 모델을 제공하고, 화면을 렌더링하는 공통 위젯
class BaseView<T extends StateStreamableSource<Object?>>
    extends StatelessWidget {
  final T viewModel;
  final Widget Function(BuildContext context, T viewModel) builder;
  final Widget? gameBody; // 게임 화면일 때 보여줄 body 위젯
  final bool isGameScreen; // 게임 화면 여부
  final String routeName;

  const BaseView({
    super.key,
    required this.viewModel,
    required this.builder,
    this.gameBody,
    this.isGameScreen = false, // 기본값은 false
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<T>.value(
      value: viewModel,
      child: BlocBuilder<T, dynamic>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("BlockPuzzle App"),
              automaticallyImplyLeading: false,
              actions: [
                const ThemeSelector(), // 여기에 ThemeSelector 추가
              ],
            ),
            body: builder(context, viewModel), // 게임 화면이 아닐 때는 builder를 사용
            bottomNavigationBar:
                isGameScreen
                    ? null
                    : BaseBottomBar(
                      currentIndex: _getCurrentIndex(routeName),
                      onTap: (index) => _onTabTapped(context, index),
                      items: const [
                        BottomNavigationBarItem(
                          icon: Icon(Icons.home),
                          label: 'home',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.leaderboard),
                          label: 'leaderboard',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.settings),
                          label: 'settings',
                        ),
                      ],
                    ),
          );
        },
      ),
    );
  }

  /// 현재 선택된 탭 인덱스를 반환하는 메서드
  int _getCurrentIndex(String routeName) {
    switch (routeName) {
      case 'home':
        return 0;
      case 'leaderboard':
        return 1;
      case 'settings':
        return 2;
      default:
        return 0;
    }
  }

  /// 탭 변경 시 네비게이션 수행
  void _onTabTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, 'home');
        break;
      case 1:
        Navigator.pushNamed(context, 'leaderboard');
        break;
      case 2:
        Navigator.pushNamed(context, 'settings');
        break;
    }
  }
}
