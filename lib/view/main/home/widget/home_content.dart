import 'package:flutter/material.dart';
import 'package:BlockPuzzle/models/score.dart';
import 'package:BlockPuzzle/models/score_type.dart';
import 'package:BlockPuzzle/service/theme/theme_service.dart';
import 'package:BlockPuzzle/utils/route_path.dart';
import 'package:BlockPuzzle/view/main/home/widget/best_score_card.dart';
import 'package:BlockPuzzle/view/main/home/widget/score_list/score_list.dart';
import 'package:BlockPuzzle/view/main/home/widget/sort_toggel_row.dart';

class HomeContent extends StatelessWidget {
  final List<Score> scoreList;
  final String? error;
  final ScoreSortType sortType;
  final Function(ScoreSortType) onSortChanged;

  const HomeContent({
    super.key,
    required this.scoreList,
    this.error,
    required this.sortType,
    required this.onSortChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme; // ThemeService에서 테마 가져오기

    // 에러가 있으면 에러 표시
    if (error != null) {
      return Center(child: Text('오류: $error', style: theme.typo.error));
    }

    // 데이터가 없으면 "등록된 점수가 없습니다." 표시
    if (scoreList.isEmpty) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 16.0,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.color.primary, // 테마의 주요 색상 적용
                foregroundColor: theme.color.onPrimary, // 테마의 주요 색상 위 텍스트 색상
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: theme.deco.borderRadius, // 테마의 모서리 둥글기 적용
                ),
                elevation: 4,
                minimumSize: const Size(double.infinity, 60),
              ),
              onPressed: () => Navigator.pushNamed(context, RoutePath.game),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.play_arrow, size: 28),
                  const SizedBox(width: 8),
                  Text(
                    '게임 시작',
                    style: theme.typo.emphasized.copyWith(
                      color: theme.color.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Center(child: Text('등록된 점수가 없습니다.', style: theme.typo.bodyText1)),
        ],
      );
    }

    // 최고 점수 계산
    final bestScore = _getBestScore(scoreList);

    return Column(
      children: [
        BestScoreCard(bestScore: bestScore),

        SortToggleRow(currentSortType: sortType, onSortChanged: onSortChanged),

        const SizedBox(height: 16),

        Expanded(child: ScoreList(scores: scoreList)),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.color.primary, // 테마의 주요 색상 적용
              foregroundColor: theme.color.onPrimary, // 테마의 주요 색상 위 텍스트 색상
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: theme.deco.borderRadius, // 테마의 모서리 둥글기 적용
              ),
              elevation: 4,
              minimumSize: const Size(double.infinity, 60),
            ),
            onPressed: () => Navigator.pushNamed(context, RoutePath.game),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.play_arrow, size: 28),
                const SizedBox(width: 8),
                Text(
                  '게임 시작',
                  style: theme.typo.emphasized.copyWith(
                    color: theme.color.onPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // 최고 점수 계산
  Score? _getBestScore(List<Score> scores) {
    if (scores.isEmpty) return null;
    return scores.reduce((a, b) => a.score > b.score ? a : b);
  }
}
