import 'package:flutter/material.dart';
import 'package:tetris_app/models/leaderboard_entry.dart';

class LeaderboardTile extends StatelessWidget {
  final LeaderboardEntry entry;

  const LeaderboardTile({super.key, required this.entry});

  Widget _buildRankWidget(double percentage) {
    if (percentage >= 95) {
      // 다이아몬드 티어 (상위 5%)
      return const CircleAvatar(
        backgroundColor: Color(0xFF3BE8FF), // 다이아몬드 색상
        child: Icon(Icons.diamond, color: Colors.white),
      );
    } else if (percentage >= 90) {
      // 플래티넘 티어 (상위 5-10%)
      return const CircleAvatar(
        backgroundColor: Color(0xFFB191FF), // 플래티넘 색상
        child: Icon(Icons.workspace_premium, color: Colors.white),
      );
    } else if (percentage >= 75) {
      // 골드 티어 (상위 10-25%)
      return const CircleAvatar(
        backgroundColor: Colors.amber,
        child: Icon(Icons.emoji_events, color: Colors.white),
      );
    } else if (percentage >= 50) {
      // 실버 티어 (상위 25-50%)
      return const CircleAvatar(
        backgroundColor: Colors.grey,
        child: Icon(Icons.shield, color: Colors.white),
      );
    } else {
      // 브론즈 티어 (하위 50%)
      return const CircleAvatar(
        backgroundColor: Colors.brown,
        child: Icon(Icons.military_tech, color: Colors.white),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _buildRankWidget(entry.percentage),
      title: Text(
        entry.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text('${entry.seasonYear}/${entry.seasonName}'),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '${entry.score}점',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(entry.dateTime, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
