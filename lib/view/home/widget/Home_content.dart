// lib/view/home/widget/home_content.dart
import 'package:flutter/material.dart';
import 'package:tetris_app/models/score.dart';
import 'package:tetris_app/models/score_type.dart';
import 'package:tetris_app/view/home/widget/best_score_card.dart';
import 'package:tetris_app/view/home/widget/score_list/score_list.dart';
import 'package:tetris_app/view/home/widget/sort_toggel_row.dart';

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
    // 에러가 있으면 에러 표시
    if (error != null) {
      return Center(child: Text('오류: $error'));
    }

    // 데이터가 없으면 "등록된 점수가 없습니다." 표시
    if (scoreList.isEmpty) {
      return const Center(child: Text('등록된 점수가 없습니다.'));
    }

    // 최고 점수 계산
    final bestScore = _getBestScore(scoreList);

    return Column(
      children: [
        // SeasonBestScoreCard(bestScore: seasonBestScore),

        // "나의 최고 기록" 텍스트
        BestScoreCard(bestScore: bestScore),

        SortToggleRow(currentSortType: sortType, onSortChanged: onSortChanged),
        
        const SizedBox(height: 16),

        // 점수 목록
        Expanded(child: ScoreList(scores: scoreList)),
      ],
    );
  }

  // 최고 점수 계산
  Score? _getBestScore(List<Score> scores) {
    if (scores.isEmpty) return null;
    return scores.reduce((a, b) => a.score > b.score ? a : b);
  }
}
