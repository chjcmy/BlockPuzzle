import 'package:flutter/material.dart';
import 'package:tetris_app/service/theme/theme_service.dart';

class CircularIndicator extends StatelessWidget {
  const CircularIndicator({
    super.key,
    required this.child,
    required this.isBusy,
  });

  final Widget child;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        IgnorePointer(
          // 터치 이벤트 차단
          ignoring: !isBusy,
          child: AnimatedOpacity(
            // 투명도 활용
            opacity: isBusy ? 1 : 0,

            duration: const Duration(milliseconds: 222),
            child: Container(
              color: context.color.background,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                color: context.color.primary,
                value: isBusy ? null : 0,
              ),
            ),
          ),
        )
      ],
    );
  }
}
