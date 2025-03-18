import 'package:flutter/material.dart';
import 'package:tetris_app/models/tetrimino/direction.dart';
import 'package:tetris_app/utils/route_path.dart';
import 'package:tetris_app/view/base_view.dart';
import 'package:tetris_app/view/game/game_view_event.dart';
import 'package:tetris_app/view/game/game_view_model.dart';
import 'package:tetris_app/view/game/widget/game_controls.dart';
import 'package:tetris_app/view/game/widget/game_info_panel.dart';
import 'package:tetris_app/view/game/widget/tetris_board.dart';

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
    return BaseView(
      viewModel: gameViewModel,
      builder: (context, viewModel) {
        // Handle game over navigation
        if (viewModel.state.gameOver) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamed(
              context,
              RoutePath.gameOver,
              arguments: viewModel.state.score,
            );
          });
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Tetris Block'),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: Container(
            color: Colors.grey[100],
            child: Column(
              children: [
                // Game info (score, level)
                GameInfoPanel(
                  score: viewModel.state.score,
                  level: viewModel.state.level,
                  gameOver: viewModel.state.gameOver,
                ),

                const SizedBox(height: 20),

                // Game board
                Expanded(
                  child: Center(
                    child: TetrisBoard(
                      state: viewModel.state,
                      gridWidth: GameViewModel.GRID_WIDTH,
                      gridHeight: GameViewModel.GRID_HEIGHT,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Game controls
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
