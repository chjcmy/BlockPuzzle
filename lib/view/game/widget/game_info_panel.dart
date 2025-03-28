import 'package:flutter/material.dart';
import 'package:BlockPuzzle/service/theme/theme_service.dart';

class GameInfoPanel extends StatelessWidget {
  final int score;
  final int level;
  final bool gameOver;

  const GameInfoPanel({
    super.key,
    required this.score,
    required this.level,
    required this.gameOver,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme; // ThemeService에서 테마 가져오기

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '점수: $score',
                style: theme.typo.headline2, // 테마의 헤드라인 스타일 적용
              ),
              Text(
                '레벨: $level',
                style: theme.typo.bodyText1, // 테마의 본문 스타일 적용
              ),
            ],
          ),
          if (gameOver)
            Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.color.error.withOpacity(0.7), // 테마의 에러 색상 적용
                borderRadius: theme.deco.borderRadius,
              ),
              child: Text(
                '게임 오버!',
                style: theme.typo.bodyText1.copyWith(
                  color: theme.color.onPrimary,
                ), // 텍스트 색상 적용
              ),
            ),
        ],
      ),
    );
  }
}
