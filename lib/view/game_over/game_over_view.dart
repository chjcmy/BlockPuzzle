// game_over_view.dart
// 게임 오버 화면을 담당하는 StatelessWidget입니다.
// GameOverViewModel을 BaseView를 통해 주입받아,
// 로컬 DB 저장 및 서버 POST 작업 후 최종 점수를 표시하고,
// "홈으로 돌아가기" 버튼을 통해 메인 화면으로 이동할 수 있도록 구성합니다.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tetris_app/utils/route_path.dart';
import 'package:tetris_app/view/base_view.dart';
import 'package:tetris_app/view/game_over/game_over_view_event.dart';
import 'package:tetris_app/view/game_over/game_over_view_model.dart';

class GameOverView extends StatelessWidget {
  final int lastScore;

  const GameOverView({super.key, required this.lastScore});

  @override
  Widget build(BuildContext context) {
    // BaseView를 통해 GameOverViewModel을 주입하고, 초기 이벤트로 마지막 점수를 전달합니다.
    return BaseView<GameOverViewModel>(
      viewModel: GameOverViewModel(scoreRepo: context.read())
        ..add(GameOverInitialized(lastScore)),
      builder: (context, viewModel) {
        final state = viewModel.state;
        return Scaffold(
          appBar: AppBar(title: const Text('Game Over')),
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
