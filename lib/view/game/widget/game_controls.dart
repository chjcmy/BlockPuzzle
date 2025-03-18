import 'package:flutter/material.dart';

class GameControls extends StatelessWidget {
  final bool gameRunning;
  final bool gameOver;
  final VoidCallback onMoveLeft;
  final VoidCallback onMoveRight;
  final VoidCallback onMoveDown;
  final VoidCallback onRotate;

  const GameControls({
    super.key,
    required this.gameRunning,
    required this.gameOver,
    required this.onMoveLeft,
    required this.onMoveRight,
    required this.onMoveDown,
    required this.onRotate,
  });

  @override
  Widget build(BuildContext context) {
    final bool canControl = gameRunning && !gameOver;

    return Column(
      children: [
        // Rotation button
        Container(
          width: 70,
          height: 70,
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: canControl ? onRotate : null,
              borderRadius: BorderRadius.circular(8),
              child: Icon(
                Icons.refresh,
                color: canControl ? Colors.blue : Colors.grey,
                size: 32,
              ),
            ),
          ),
        ),

        // Left, Down, Right buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDirectionButton(
              icon: Icons.arrow_back_ios,
              enabled: canControl,
              onTap: onMoveLeft,
            ),
            const SizedBox(width: 8),
            _buildDirectionButton(
              icon: Icons.arrow_downward,
              enabled: canControl,
              onTap: onMoveDown,
            ),
            const SizedBox(width: 8),
            _buildDirectionButton(
              icon: Icons.arrow_forward_ios,
              enabled: canControl,
              onTap: onMoveRight,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDirectionButton({
    required IconData icon,
    required bool enabled,
    required VoidCallback onTap,
  }) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: BorderRadius.circular(8),
          child: Icon(
            icon,
            color: enabled ? Colors.blue : Colors.grey,
            size: 32,
          ),
        ),
      ),
    );
  }
}
