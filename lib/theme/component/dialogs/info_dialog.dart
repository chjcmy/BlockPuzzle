import 'package:flutter/material.dart';

class InfoDialog extends StatelessWidget {
  final String title;
  final String content;
  final String buttonText;
  final VoidCallback onButtonPressed;

  const InfoDialog({
    super.key,
    required this.title,
    required this.content,
    required this.buttonText,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // title: Text(title, style: Theme.of(context).textTheme.headline6),
      // content: Text(content, style: Theme.of(context).textTheme.bodyText2),
      actions: [
        ElevatedButton(onPressed: onButtonPressed, child: Text(buttonText)),
      ],
    );
  }
}
