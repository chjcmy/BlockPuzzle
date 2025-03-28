import 'package:flutter/material.dart';
import 'package:BlockPuzzle/service/theme/theme_service.dart';
import 'package:BlockPuzzle/theme/foundation/app_theme.dart';

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
    final theme = context.theme; // ThemeService에서 테마 가져오기
    final bool canControl = gameRunning && !gameOver;

    return Column(
      children: [
        // Rotation button
        Container(
          width: 70,
          height: 70,
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            border: Border.all(color: theme.color.border),
            borderRadius: theme.deco.borderRadius,
          ),
          child: Material(
            color: theme.color.surface,
            borderRadius: theme.deco.borderRadius,
            child: InkWell(
              onTap: canControl ? onRotate : null,
              borderRadius: theme.deco.borderRadius,
              child: Icon(
                Icons.refresh,
                color: canControl ? theme.color.primary : theme.color.inactive,
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
              theme: theme,
            ),
            const SizedBox(width: 8),
            _buildDirectionButton(
              icon: Icons.arrow_downward,
              enabled: canControl,
              onTap: onMoveDown,
              theme: theme,
            ),
            const SizedBox(width: 8),
            _buildDirectionButton(
              icon: Icons.arrow_forward_ios,
              enabled: canControl,
              onTap: onMoveRight,
              theme: theme,
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
    required AppTheme theme,
  }) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        border: Border.all(color: theme.color.border),
        borderRadius: theme.deco.borderRadius,
      ),
      child: Material(
        color: theme.color.surface,
        borderRadius: theme.deco.borderRadius,
        child: InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: theme.deco.borderRadius,
          child: Icon(
            icon,
            color: enabled ? theme.color.primary : theme.color.inactive,
            size: 32,
          ),
        ),
      ),
    );
  }
}
