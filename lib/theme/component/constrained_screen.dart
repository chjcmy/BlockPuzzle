import 'package:flutter/material.dart';
import 'package:tetris_app/service/theme/theme_service.dart';

class ConstrainedScreen extends StatelessWidget {

  const ConstrainedScreen({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      // 자식 위젯을 중앙에 정렬한다
      alignment: Alignment.center,
      color: context.color.surface,
      child: ConstrainedBox(
        // 자식 위젯의 크기를 제약한다
        constraints: const BoxConstraints(),
        // 제한된 크기 내에서 전달 받은 자식 위젯을 표시 한다.
        child: child,
      ),
    );
  }
}