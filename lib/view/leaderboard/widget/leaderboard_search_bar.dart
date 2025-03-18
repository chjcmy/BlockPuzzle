import 'package:flutter/material.dart';

class LeaderboardSearchBar extends StatelessWidget {
  final bool enabled;
  final Function(String) onSearchChanged;

  const LeaderboardSearchBar({
    super.key,
    required this.enabled,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Search Users',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          enabled: enabled,
          decoration: const InputDecoration(
            hintText: 'Enter username',
            border: OutlineInputBorder(),
          ),
          onChanged: onSearchChanged,
        ),
      ],
    );
  }
}
