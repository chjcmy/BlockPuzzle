import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:BlockPuzzle/models/score.dart';
import 'package:BlockPuzzle/service/theme/theme_service.dart';
import 'package:BlockPuzzle/theme/foundation/app_theme.dart';

class BestScoreCard extends StatelessWidget {
  final Score? bestScore;

  const BestScoreCard({super.key, required this.bestScore});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme; // ThemeService에서 테마 가져오기

    // 점수가 없는 경우 처리
    if (bestScore == null) {
      return _buildEmptyCard(theme);
    }

    // 날짜 포맷 설정
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    final formattedDate = dateFormat.format(bestScore!.createdAt);

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.color.primary.withOpacity(0.3),
          width: 1,
        ), // 테마의 주요 색상 적용
        borderRadius: theme.deco.borderRadius, // 테마의 모서리 둥글기 적용
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '나의 최고 점수 기록',
              style: theme.typo.caption, // 테마의 캡션 스타일 적용
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: theme.color.primary,
                  size: 24,
                ), // 테마의 주요 색상 적용
                const SizedBox(width: 8),
                Text(
                  '${bestScore!.score}점',
                  style: theme.typo.bodyText1.copyWith(
                    fontWeight: FontWeight.bold,
                  ), // 테마의 텍스트 스타일 적용
                ),
                const Spacer(),
                Text(
                  formattedDate,
                  style: theme.typo.caption.copyWith(
                    color: theme.color.subtext,
                  ), // 테마의 보조 텍스트 스타일 적용
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyCard(AppTheme theme) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.color.primary.withOpacity(0.3),
          width: 1,
        ),
        borderRadius: theme.deco.borderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('나의 최고 점수 기록', style: theme.typo.caption),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.emoji_events, color: theme.color.primary, size: 24),
                const SizedBox(width: 8),
                Text(
                  '기록 없음',
                  style: theme.typo.bodyText1.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
