import 'package:flutter/material.dart';
import 'package:BlockPuzzle/models/leaderboard_entry.dart';
import 'package:BlockPuzzle/service/theme/theme_service.dart';

class LeaderboardTile extends StatelessWidget {
  final LeaderboardEntry entry;

  const LeaderboardTile({super.key, required this.entry});

  Widget _buildRankWidget(BuildContext context, int percentage) {
    final theme = context.theme; // ThemeService에서 테마 가져오기

    if (percentage >= 95) {
      // 다이아몬드 티어 (상위 5%)
      return CircleAvatar(
        backgroundColor: theme.color.diamondRank, // 테마의 다이아몬드 색상 적용
        child: const Icon(Icons.diamond, color: Colors.white),
      );
    } else if (percentage >= 90) {
      // 플래티넘 티어 (상위 5-10%)
      return CircleAvatar(
        backgroundColor: theme.color.platinumRank, // 테마의 플래티넘 색상 적용
        child: const Icon(Icons.workspace_premium, color: Colors.white),
      );
    } else if (percentage >= 75) {
      // 골드 티어 (상위 10-25%)
      return CircleAvatar(
        backgroundColor: theme.color.goldRank, // 테마의 골드 색상 적용
        child: const Icon(Icons.emoji_events, color: Colors.white),
      );
    } else if (percentage >= 50) {
      // 실버 티어 (상위 25-50%)
      return CircleAvatar(
        backgroundColor: theme.color.silverRank, // 테마의 실버 색상 적용
        child: const Icon(Icons.shield, color: Colors.white),
      );
    } else {
      // 브론즈 티어 (하위 50%)
      return CircleAvatar(
        backgroundColor: theme.color.bronzeRank, // 테마의 브론즈 색상 적용
        child: const Icon(Icons.military_tech, color: Colors.white),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme; // ThemeService에서 테마 가져오기

    return ListTile(
      leading: _buildRankWidget(context, entry.percentage),
      title: Text(
        entry.name,
        style: theme.typo.bodyText1.copyWith(
          fontWeight: FontWeight.bold,
        ), // 테마의 본문 스타일 적용
      ),
      subtitle: Text(
        '${entry.seasonYear}/${entry.seasonName}',
        style: theme.typo.caption.copyWith(
          color: theme.color.subtext,
        ), // 테마의 캡션 스타일 적용
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '${entry.score}점',
            style: theme.typo.bodyText1.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            entry.dateTime,
            style: theme.typo.caption.copyWith(color: theme.color.subtext),
          ),
        ],
      ),
    );
  }
}
