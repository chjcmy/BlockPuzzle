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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16.0, top: 16.0),
          child: Text(
            '앱 정보',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(
          title: const Text('버전'),
          trailing: Text(version, style: const TextStyle(color: Colors.grey)),
        ),
        ListTile(
          title: const Text('개발자'),
          trailing: Text(developer, style: const TextStyle(color: Colors.grey)),
        ),
      ],
    );
  }
}
