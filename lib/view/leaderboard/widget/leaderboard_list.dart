import 'package:flutter/material.dart';
import 'package:tetris_app/view/leaderboard/widget/leaderboard_tile.dart';

class LeaderboardList extends StatelessWidget {
  final List<dynamic> entries;
  final ScrollController scrollController;
  final bool isLoading;

  const LeaderboardList({
    super.key,
    required this.entries,
    required this.scrollController,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      itemCount: entries.length + 1,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        if (index < entries.length) {
          final entry = entries[index];
          return LeaderboardTile(entry: entry);
        } else {
          return isLoading
              ? const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: CircularProgressIndicator()),
              )
              : const SizedBox();
        }
      },
    );
  }
}
