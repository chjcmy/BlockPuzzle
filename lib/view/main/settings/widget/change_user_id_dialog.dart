import 'package:flutter/material.dart';
import 'package:BlockPuzzle/view/main/settings/settings_view_event.dart';
import 'package:BlockPuzzle/view/main/settings/settings_view_model.dart'; // Import your theme service

class ChangeUserIdDialog extends StatefulWidget {
  final SettingsViewModel viewModel;

  const ChangeUserIdDialog({super.key, required this.viewModel});

  @override
  State<ChangeUserIdDialog> createState() => _ChangeUserIdDialogState();
}

class _ChangeUserIdDialogState extends State<ChangeUserIdDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get the current theme

    return AlertDialog(
      title: Text('아이디 변경', style: theme.textTheme.titleMedium), // Apply theme
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: '새 아이디를 입력하세요',
          hintStyle: theme.textTheme.bodySmall, // Apply theme
        ),
        style: theme.textTheme.bodyMedium, // Apply theme
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('취소', style: theme.textTheme.bodyMedium), // Apply theme
        ),
        TextButton(
          onPressed: () {
            final newUserId = _controller.text.trim();
            if (newUserId.isNotEmpty) {
              widget.viewModel.add(ChangeUserIdConfirmed(newUserId));
              Navigator.of(context).pop();
            }
          },
          child: Text('확인', style: theme.textTheme.bodyMedium), // Apply theme
        ),
      ],
    );
  }
}
