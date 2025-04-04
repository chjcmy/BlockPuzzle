// lib/view/home/widget/season_best_score_card.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:BlockPuzzle/models/score.dart';

class SeasonBestScoreCard extends StatelessWidget {
  final Score? bestScore;

  const SeasonBestScoreCard({super.key, required this.bestScore});

  @override
  Widget build(BuildContext context) {
    // 점수가 없는 경우 처리
    if (bestScore == null) {
      return _buildEmptyCard();
    }

    // 날짜 포맷 설정
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    final formattedDate = dateFormat.format(bestScore!.dateTime);

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue.withOpacity(0.3), width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '이번 시즌 최고 점수',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.emoji_events, color: Colors.amber, size: 24),
                const SizedBox(width: 8),
                Text(
                  '${bestScore!.score}점',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  formattedDate,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 시즌 최고 점수가 없는 경우 표시할 카드
  Widget _buildEmptyCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue.withOpacity(0.3), width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '이번 시즌 최고 점수',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.emoji_events, color: Colors.amber, size: 24),
                SizedBox(width: 8),
                Text(
                  '기록 없음',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
