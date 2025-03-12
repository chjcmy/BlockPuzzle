import 'package:flutter/material.dart';
import 'package:tetris_app/models/score.dart';
import 'package:tetris_app/view/home/widget/score_list/score_list_tile.dart';

class ScoreList extends StatelessWidget {
  final List<Score> scores;

  const ScoreList({super.key, required this.scores});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: scores.length,
      itemBuilder: (context, index) {
        return ScoreListTile(score: scores[index]); // ScoreListTile 사용
      },
    );
  }
}