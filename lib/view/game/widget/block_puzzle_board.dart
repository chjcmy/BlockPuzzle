import 'package:BlockPuzzle/models/tetrimino/piece_type.dart';
import 'package:BlockPuzzle/service/theme/theme_service.dart';
import 'package:BlockPuzzle/view/game/game_view_state.dart';
import 'package:flutter/material.dart';

class BlockPuzzleBoard extends StatelessWidget {
  final GameViewState state;
  final int gridWidth;
  final int gridHeight;

  const BlockPuzzleBoard({
    super.key,
    required this.state,
    required this.gridWidth,
    required this.gridHeight,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme; // ThemeService에서 테마 가져오기

    return AspectRatio(
      aspectRatio: gridWidth / gridHeight,
      child: Container(
        decoration: BoxDecoration(
          color: theme.color.surface, // 테마의 표면 색상 적용
          border: Border.all(
            color: theme.color.border,
            width: 2,
          ), // 테마의 경계선 색상 적용
          borderRadius: theme.deco.borderRadius, // 테마의 모서리 둥글기 적용
          boxShadow: [
            BoxShadow(
              color: theme.color.shadow.withOpacity(0.3), // 테마의 그림자 색상 적용
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridWidth,
          ),
          itemCount: gridWidth * gridHeight,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            final x = index % gridWidth;
            final y = index ~/ gridWidth;
            return _buildGridCell(context, x, y);
          },
        ),
      ),
    );
  }

  Widget _buildGridCell(BuildContext context, int x, int y) {
    final theme = context.theme; // ThemeService에서 테마 가져오기
    Color cellColor = Colors.transparent;
    final key = '$x,$y';

    // 고정된 블록의 색상
    if (state.grid.containsKey(key)) {
      cellColor = theme.color.secondary; // 테마의 보조 색상 적용
    }

    // 활성 블록의 색상
    for (final pos in state.activePiecePositions) {
      if (pos.x == x && pos.y == y) {
        switch (state.activePiece) {
          case PieceType.I:
            cellColor = const Color(0xFF00FFFF); // Cyan
            break;
          case PieceType.J:
            cellColor = const Color(0xFF00008B); // Dark Blue
            break;
          case PieceType.L:
            cellColor = const Color(0xFFFF00FF); // Magenta
            break;
          case PieceType.O:
            cellColor = const Color(0xFFFFD700); // Gold
            break;
          case PieceType.S:
            cellColor = const Color(0xFF32CD32); // Lime
            break;
          case PieceType.T:
            cellColor = const Color(0xFFFF1493); // Pink
            break;
          case PieceType.Z:
            cellColor = const Color(0xFF8B4513); // Brown
            break;
          default:
            cellColor = theme.color.tertiary; // 테마의 추가 강조 색상 적용
        }
        break;
      }
    }

    return Container(
      margin: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: cellColor,
        borderRadius: BorderRadius.circular(2),
        border:
            cellColor != Colors.transparent
                ? null
                : Border.all(
                  color: theme.color.border,
                  width: 0.5,
                ), // 테마의 경계선 색상 적용
      ),
    );
  }
}
