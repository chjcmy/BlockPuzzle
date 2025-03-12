import 'package:flutter/material.dart';
import 'package:tetris_app/models/score_type.dart';
import 'package:tetris_app/view/home/widget/home_toggle_button.dart';

class SortToggleRow extends StatelessWidget {
  final ScoreSortType currentSortType;
  final Function(ScoreSortType) onSortChanged;

  const SortToggleRow({
    super.key,
    required this.currentSortType,
    required this.onSortChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ToggleButton(
          isSelected: currentSortType == ScoreSortType.highScore,
          label: '높은 점수순',
          onPressed: () {
            onSortChanged(ScoreSortType.highScore);
          },
        ),
        const SizedBox(width: 8),
        ToggleButton(
          isSelected: currentSortType == ScoreSortType.latest,
          label: '최신순',
          onPressed: () {
            onSortChanged(ScoreSortType.latest);
          },
        ),
      ],
    );
  }
}
