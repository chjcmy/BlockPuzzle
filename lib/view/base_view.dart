import 'package:BlockPuzzle/service/connectivity/connectivity_service.dart';
import 'package:BlockPuzzle/theme/component/bottom_bar/base_bottom_bar.dart';
import 'package:BlockPuzzle/theme/component/theme_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseView<T extends StateStreamableSource<Object?>>
    extends StatelessWidget {
  final T viewModel;
  final Widget Function(BuildContext context, T viewModel) builder;
  final Widget? gameBody;
  final bool isGameScreen;
  final String routeName;

  const BaseView({
    super.key,
    required this.viewModel,
    required this.builder,
    this.gameBody,
    this.isGameScreen = false,
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
              actions: [const ThemeSelector()],
            ),
            body: builder(context, viewModel),
            bottomNavigationBar:
                isGameScreen
                    ? null
                    : BlocBuilder<ConnectivityService, bool>(
                      builder: (context, isOnline) {
                        return BaseBottomBar(
                          currentIndex: _getCurrentIndex(routeName),
                          onTap:
                              (index) => _onTabTapped(context, index, isOnline),
                          isOnline: isOnline,
                        );
                      },
                    ),
          );
        },
      ),
    );
  }

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

  void _onTabTapped(BuildContext context, int index, bool isOnline) {
    if (index == 1 && !isOnline) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('리더보드는 온라인 상태에서만 접근 가능합니다.')),
      );
      return;
    }

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
