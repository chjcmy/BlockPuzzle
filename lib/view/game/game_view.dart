import 'package:BlockPuzzle/models/tetrimino/direction.dart';
import 'package:BlockPuzzle/service/theme/theme_service.dart';
import 'package:BlockPuzzle/utils/route_path.dart';
import 'package:BlockPuzzle/view/base_view.dart';
import 'package:BlockPuzzle/view/game/game_view_event.dart';
import 'package:BlockPuzzle/view/game/game_view_model.dart';
import 'package:BlockPuzzle/view/game/widget/block_puzzle_board.dart';
import 'package:BlockPuzzle/view/game/widget/game_controls.dart';
import 'package:BlockPuzzle/view/game/widget/game_info_panel.dart';
import 'package:flutter/material.dart';

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  late final GameViewModel gameViewModel;

  @override
  void initState() {
    super.initState();
    gameViewModel = GameViewModel();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      gameViewModel.add(GameInitialized());
    });
  }

  @override
  void dispose() {
    gameViewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme; // ThemeService에서 테마 가져오기

    return BaseView(
      routeName: 'game',

      viewModel: gameViewModel,
      isGameScreen: true,
      builder: (context, viewModel) {
        if (viewModel.state.gameOver) {
          // 게임 오버가 될경우 게임 오버 화면으로 이동
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamed(
              context,
              RoutePath.gameOver,
              arguments: viewModel.state.score,
            );
          });
        }

        return Scaffold(
          backgroundColor: theme.color.background, // 테마의 배경색 적용
          body: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
            ), // 상단과 하단에 20px 여백 추가
            child: Column(
              children: [
                GameInfoPanel(
                  score: viewModel.state.score,
                  level: viewModel.state.level,
                  gameOver: viewModel.state.gameOver,
                ),
                const SizedBox(height: 20), // GameInfoPanel과 게임 보드 사이 여백
                Expanded(
                  child: Center(
                    child: BlockPuzzleBoard(
                      state: viewModel.state,
                      gridWidth: GameViewModel.GRID_WIDTH,
                      gridHeight: GameViewModel.GRID_HEIGHT,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GameControls(
                  gameRunning: viewModel.state.gameRunning,
                  gameOver: viewModel.state.gameOver,
                  onMoveLeft: () => viewModel.add(PieceMoved(Direction.left)),
                  onMoveRight: () => viewModel.add(PieceMoved(Direction.right)),
                  onMoveDown: () => viewModel.add(PieceMoved(Direction.down)),
                  onRotate: () => viewModel.add(PieceRotated()),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
