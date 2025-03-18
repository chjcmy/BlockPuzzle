// lib/view/settings/widgets/data_management_tile.dart
import 'package:flutter/material.dart';

class DataManagementTile extends StatelessWidget {
  final VoidCallback onDeleteRequested;

  const DataManagementTile({super.key, required this.onDeleteRequested});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16.0, top: 16.0),
          child: Text(
            '데이터 관리',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        InkWell(
          onTap: onDeleteRequested,
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.red.withOpacity(0.3)),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.delete, color: Colors.red),
                SizedBox(width: 8),
                Text(
                  '로컬 데이터 삭제',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
