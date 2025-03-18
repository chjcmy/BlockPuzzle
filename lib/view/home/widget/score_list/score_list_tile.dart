import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tetris_app/models/score.dart';

class ScoreListTile extends StatelessWidget {
  final Score score;

  const ScoreListTile({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    // 날짜 형식 지정 (yyyy-MM-dd HH:mm)
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    final formattedDate = dateFormat.format(score.dateTime);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 점수 (왼쪽 정렬)
          Text(
            '${score.score}점',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),

          // 날짜 (점수보다 낮게 만들고 오른쪽 정렬)
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              formattedDate,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
