import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:BlockPuzzle/models/score.dart';
import 'package:BlockPuzzle/service/theme/theme_service.dart';

class ScoreListTile extends StatelessWidget {
  final Score score;

  const ScoreListTile({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme; // ThemeService에서 테마 가져오기

    // 날짜 형식 지정 (yyyy-MM-dd HH:mm)
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    final formattedDate = dateFormat.format(score.dateTime);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: theme.color.border, width: 0.5),
        ), // 테마의 경계선 색상 적용
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 점수 (왼쪽 정렬)
          Text(
            '${score.score}점',
            style: theme.typo.bodyText1.copyWith(
              fontWeight: FontWeight.bold,
            ), // 테마의 텍스트 스타일 적용
            textAlign: TextAlign.left,
          ),

          // 날짜 (점수보다 낮게 만들고 오른쪽 정렬)
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              formattedDate,
              style: theme.typo.caption.copyWith(
                color: theme.color.subtext,
              ), // 테마의 보조 텍스트 스타일 적용
            ),
          ),
        ],
      ),
    );
  }
}
