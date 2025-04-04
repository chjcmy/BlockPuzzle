// game_over_view.dart
// 게임 오버 화면을 담당하는 StatelessWidget입니다.
// GameOverViewModel을 BaseView를 통해 주입받아,
// 로컬 DB 저장 및 서버 POST 작업 후 최종 점수를 표시하고,
// "홈으로 돌아가기" 버튼을 통해 메인 화면으로 이동할 수 있도록 구성합니다.

import 'package:BlockPuzzle/view/base_view.dart';
import 'package:BlockPuzzle/view/game_over/game_over_view_event.dart';
import 'package:BlockPuzzle/view/game_over/game_over_view_model.dart';
import 'package:BlockPuzzle/view/game_over/game_over_view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameOverView extends StatefulWidget {
  final int lastScore;
  final bool networkBool = false;

  const GameOverView({super.key, required this.lastScore});

  @override
  State<GameOverView> createState() => _GameOverViewState();
}

class _GameOverViewState extends State<GameOverView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<GameOverViewModel>(
      routeName: 'game_over',
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
                        const SizedBox(height: 20),
                        if (state.serverSaveStatus == ServerSaveStatus.success)
                          const Text(
                            '점수가 서버에 성공적으로 저장되었습니다!',
                            style: TextStyle(fontSize: 16, color: Colors.green),
                          ),
                        if (state.serverSaveStatus == ServerSaveStatus.failure)
                          const Text(
                            '점수 저장에 실패했습니다. 네트워크를 확인해주세요.',
                            style: TextStyle(fontSize: 16, color: Colors.red),
                          ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context); // 홈 화면으로 이동
                          },
                          child: const Text('홈으로 돌아가기'),
                        ),
                      ],
                    ),
          ),
        );
      },
    );
  }
}
