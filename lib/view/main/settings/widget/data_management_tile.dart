// lib/view/settings/widgets/data_management_tile.dart
import 'package:flutter/material.dart';

class DataManagementTile extends StatelessWidget {
  final VoidCallback onDeleteRequested;

  const DataManagementTile({super.key, required this.onDeleteRequested});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // 현재 테마 가져오기
    final colorScheme = theme.colorScheme; // 테마의 색상 팔레트 가져오기

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 16.0),
          child: Text(
            '데이터 관리',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ), // 테마의 텍스트 스타일 사용
          ),
        ),
        InkWell(
          onTap: onDeleteRequested,
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            decoration: BoxDecoration(
              color: colorScheme.error.withOpacity(0.1), // 테마의 에러 색상 사용
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: colorScheme.error.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.delete, color: colorScheme.error), // 테마의 에러 색상 사용
                const SizedBox(width: 8),
                Text(
                  '로컬 데이터 삭제',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.error,
                    fontWeight: FontWeight.bold,
                  ), // 테마의 텍스트 스타일 사용
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
