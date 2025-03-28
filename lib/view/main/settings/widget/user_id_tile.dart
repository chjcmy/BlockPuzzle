// lib/view/settings/widgets/user_id_tile.dart
import 'package:flutter/material.dart';

class UserIdTile extends StatelessWidget {
  final String userId;
  final VoidCallback onChangeIdRequested;

  const UserIdTile({
    super.key,
    required this.userId,
    required this.onChangeIdRequested,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '사용자 ID',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              Text(
                userId,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: onChangeIdRequested,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            child: const Text('아이디 변경'),
          ),
        ],
      ),
    );
  }
}
