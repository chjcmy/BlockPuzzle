import 'package:flutter/material.dart';
import 'package:tetris_app/models/tetrimino/piece_type.dart';
import 'package:tetris_app/view/game/game_view_state.dart';

class TetrisBoard extends StatelessWidget {
  final GameViewState state;
  final int gridWidth;
  final int gridHeight;

  const TetrisBoard({
    super.key,
    required this.state,
    required this.gridWidth,
    required this.gridHeight,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: gridWidth / gridHeight,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[300]!, width: 2),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
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
            return _buildGridCell(x, y);
          },
        ),
      ),
    );
  }

  Widget _buildGridCell(int x, int y) {
    Color cellColor = Colors.transparent;
    final key = '$x,$y';

    if (state.grid.containsKey(key)) {
      cellColor = Colors.blueGrey;
    }

    for (final pos in state.activePiecePositions) {
      if (pos.x == x && pos.y == y) {
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
        border:
            cellColor != Colors.transparent
                ? null
                : Border.all(color: Colors.grey[200]!, width: 0.5),
      ),
    );
  }
}
