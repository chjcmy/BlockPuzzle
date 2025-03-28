// lib/view/settings/widgets/app_info_tile.dart
import 'package:flutter/material.dart';

class AppInfoTile extends StatelessWidget {
  final String version;
  final String developer;

  const AppInfoTile({
    super.key,
    required this.version,
    required this.developer,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get the current theme

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 16.0),
          child: Text(
            '앱 정보',
            style: theme.textTheme.titleMedium, // Use themed TextStyle
          ),
        ),
        ListTile(
          title: Text(
            '버전',
            style: theme.textTheme.bodyMedium,
          ), // Use themed TextStyle
          trailing: Text(
            version,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ), // Use themed TextStyle with color
          ),
        ),
        ListTile(
          title: Text(
            '개발자',
            style: theme.textTheme.bodyMedium,
          ), // Use themed TextStyle
          trailing: Text(
            developer,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ), // Use themed TextStyle with color
          ),
        ),
      ],
    );
  }
}
