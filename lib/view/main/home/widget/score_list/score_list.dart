import 'package:flutter/material.dart';
import 'package:BlockPuzzle/models/score.dart';
import 'package:BlockPuzzle/view/main/home/widget/score_list/score_list_tile.dart';

class ScoreList extends StatelessWidget {
  final List<Score> scores;

  const ScoreList({super.key, required this.scores});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: scores.length,
      itemBuilder: (context, index) {
        return ScoreListTile(score: scores[index]); // ScoreListTile에 테마 적용됨
      },
    );
  }
}
