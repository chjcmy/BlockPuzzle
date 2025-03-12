// game_view.dart
// 게임 UI를 담당하는 StatefulWidget 클래스입니다.
// 게임 보드, 점수/레벨 표시 및 블록 조작 버튼들을 배치하며,
// 게임이 끝났을시에 game_over_view로 가게 됩니다.

import 'package:flutter/material.dart';
import 'package:tetris_app/models/tetrimino/direction.dart';
import 'package:tetris_app/models/tetrimino/piece_type.dart';
import 'package:tetris_app/utils/route_path.dart';
import 'package:tetris_app/view/base_view.dart';
import 'package:tetris_app/view/game/game_view_event.dart';
import 'package:tetris_app/view/game/game_view_model.dart';
import 'package:tetris_app/view/game/game_view_state.dart';

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
    // ViewModel 인스턴스 생성
    gameViewModel = GameViewModel();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      gameViewModel.add(GameInitialized());
    });
  }

  @override
  void dispose() {
    // 화면 종료 시 타이머 정리
    gameViewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // BaseView를 사용하여 ViewModel의 상태 변화를 구독하고 UI를 빌드합니다.
    return BaseView(
      viewModel: gameViewModel,
      builder: (context, viewModel) {
        // 여기서 gameOver 상태를 감지하여 네비게이트
        if (viewModel.state.gameOver) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            // 이미 game over라면 네비게이션
            Navigator.pushNamed(
              context,
              RoutePath.gameOver,
              arguments: viewModel.state.score,
            );
          });
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Tetris Game'),
            automaticallyImplyLeading: false, // 뒤로 가기 버튼 제거
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // 상단에 점수와 레벨 표시
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '점수: ${viewModel.state.score}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '레벨: ${viewModel.state.level}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // 게임 오버 메시지 표시 (게임 오버 시)
                if (viewModel.state.gameOver)
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      '게임 오버!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                const SizedBox(height: 8),
                // 게임 보드 영역 (GridView를 이용해 그리드 렌더링)
                Expanded(
                  child: Center(
                    child: AspectRatio(
                      aspectRatio:
                          GameViewModel.GRID_WIDTH / GameViewModel.GRID_HEIGHT,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: _buildGameBoard(viewModel.state),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // 하단에 블록 조작 버튼들 배치
                _buildControls(viewModel, viewModel.state),
              ],
            ),
          ),
        );
      },
    );
  }

  // GridView를 생성하여 게임 보드를 그립니다.
  Widget _buildGameBoard(GameViewState state) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: GameViewModel.GRID_WIDTH, // 열 개수는 게임 보드의 너비로 설정
      ),
      itemCount: GameViewModel.GRID_WIDTH * GameViewModel.GRID_HEIGHT,
      physics: const NeverScrollableScrollPhysics(), // 사용자가 직접 스크롤 불가
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        // 1차원 index를 2차원 (x, y) 좌표로 변환
        final x = index % GameViewModel.GRID_WIDTH; // 열
        final y = index ~/ GameViewModel.GRID_WIDTH; // 행
        // 셀의 기본 배경색 (빈 공간)
        Color cellColor = Colors.grey[200]!;
        final key = '$x,$y';
        // 고정된 블록이 있는 위치인지 확인
        if (state.grid.containsKey(key)) {
          cellColor = Colors.blueGrey; // 고정된 블록은 어두운 색으로 표시
        }
        // 현재 떨어지고 있는 활성 블록의 위치인지 확인
        for (final pos in state.activePiecePositions) {
          if (pos.x == x && pos.y == y) {
            // 활성 조각의 셀인 경우 색상을 다르게 지정 (조각 종류별로 구분 가능)
            switch (state.activePiece) {
              case PieceType.I:
                cellColor = Colors.cyan;
                break;
              case PieceType.J:
                cellColor = Colors.blue;
                break;
              case PieceType.L:
                cellColor = Colors.orange;
                break;
              case PieceType.O:
                cellColor = Colors.yellow;
                break;
              case PieceType.S:
                cellColor = Colors.green;
                break;
              case PieceType.T:
                cellColor = Colors.purple;
                break;
              case PieceType.Z:
                cellColor = Colors.red;
                break;
              default:
                cellColor = Colors.purple;
            }
            break;
          }
        }
        return Container(
          margin: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: cellColor,
            borderRadius: BorderRadius.circular(2),
          ),
        );
      },
    );
  }

  // 좌/우/회전/하강 컨트롤 버튼 위젯들을 생성합니다.
  Widget _buildControls(GameViewModel viewModel, GameViewState state) {
    return Column(
      children: [
        // 좌, 회전, 우 버튼을 한 행에 배치
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildControlButton(
              icon: Icons.arrow_left,
              onPressed:
                  state.gameRunning && !state.gameOver
                      ? () => viewModel.add(PieceMoved(Direction.left))
                      : null,
            ),
            const SizedBox(width: 16),
            _buildControlButton(
              icon: Icons.rotate_right,
              onPressed:
                  state.gameRunning && !state.gameOver
                      ? () => viewModel.add(PieceRotated())
                      : null,
            ),
            const SizedBox(width: 16),
            _buildControlButton(
              icon: Icons.arrow_right,
              onPressed:
                  state.gameRunning && !state.gameOver
                      ? () => viewModel.add(PieceMoved(Direction.right))
                      : null,
            ),
          ],
        ),
        const SizedBox(height: 12),
        // 아래로 내리는 버튼은 별도로 배치
        _buildControlButton(
          icon: Icons.arrow_downward,
          onPressed:
              state.gameRunning && !state.gameOver
                  ? () => viewModel.add(PieceMoved(Direction.down))
                  : null,
          size: 60, // 아래 버튼은 약간 크게
        ),
      ],
    );
  }

  // 조작용 원형 아이콘 버튼 생성 헬퍼 위젯
  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback? onPressed,
    double size = 48,
  }) {
    return Material(
      color: onPressed == null ? Colors.grey : Colors.blue,
      shape: CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: CircleBorder(),
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(icon, color: Colors.white, size: size * 0.5),
        ),
      ),
    );
  }
}
