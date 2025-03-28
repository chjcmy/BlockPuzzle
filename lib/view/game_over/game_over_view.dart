// game_over_view.dart
// 게임 오버 화면을 담당하는 StatelessWidget입니다.
// GameOverViewModel을 BaseView를 통해 주입받아,
// 로컬 DB 저장 및 서버 POST 작업 후 최종 점수를 표시하고,
// "홈으로 돌아가기" 버튼을 통해 메인 화면으로 이동할 수 있도록 구성합니다.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:BlockPuzzle/utils/route_path.dart';
import 'package:BlockPuzzle/view/base_view.dart';
import 'package:BlockPuzzle/view/game_over/game_over_view_event.dart';
import 'package:BlockPuzzle/view/game_over/game_over_view_model.dart';

class GameOverView extends StatefulWidget {
  final int lastScore;

  const GameOverView({super.key, required this.lastScore});

  @override
  State<GameOverView> createState() => _GameOverViewState();
}

class _GameOverViewState extends State<GameOverView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<GameOverViewModel>(
      routeName: 'game_over', // 추가
      viewModel: GameOverViewModel(
        scoreRepository: context.read(),
        userRepository: context.read(),
      )..add(GameOverInitialized(widget.lastScore)),
      builder: (context, viewModel) {
        final state = viewModel.state;
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                state.isBusy
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '최종 점수: ${state.finalScore}',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            // 홈 화면으로 돌아갑니다.
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              RoutePath.home,
                              (route) => false,
                            );
                          },
                          child: const Text(
                            '홈으로 돌아가기',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
          ),
        );
      },
    );
  }
}
