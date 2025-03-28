// lib/view/home/widget/sort_toggel_row.dart
import 'package:flutter/material.dart';
import 'package:BlockPuzzle/models/score_type.dart';
import 'package:BlockPuzzle/view/main/home/widget/home_toggle_button.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ToggleButton(
              isSelected: currentSortType == ScoreSortType.highScore,
              label: '높은 점수순',
              onPressed: () {
                onSortChanged(ScoreSortType.highScore);
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ToggleButton(
              isSelected: currentSortType == ScoreSortType.latest,
              label: '최신순',
              onPressed: () {
                onSortChanged(ScoreSortType.latest);
              },
            ),
          ),
        ],
      ),
    );
  }
}
