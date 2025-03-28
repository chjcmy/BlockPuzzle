import 'package:flutter/material.dart';
import 'package:BlockPuzzle/service/theme/theme_service.dart';

/// 단일 토글 버튼. [isSelected]가 true이면 검정 배경에 흰색 글자,
/// false이면 흰색 배경에 검정 글자와 검정 테두리를 표시
class ToggleButton extends StatelessWidget {
  final bool isSelected;
  final String label;
  final VoidCallback onPressed;
  final double? width; // 선택적 너비 파라미터 추가

  const ToggleButton({
    super.key,
    required this.isSelected,
    required this.label,
    required this.onPressed,
    this.width, // 너비 파라미터를 옵션으로 추가
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme; // ThemeService에서 테마 가져오기

    return SizedBox(
      width: width, // SizedBox로 감싸서 너비 설정 가능하게 함
      height: 40,
      child: MaterialButton(
        onPressed: onPressed,
        color:
            isSelected
                ? theme.color.primary
                : theme.color.surface, // 테마의 주요 색상 및 표면 색상 적용
        shape: RoundedRectangleBorder(
          borderRadius: theme.deco.borderRadius, // 테마의 모서리 둥글기 적용
          side: BorderSide(
            color: theme.color.border,
            width: 1,
          ), // 테마의 경계선 색상 적용
        ),
        child: Text(
          label,
          style: theme.typo.bodyText1.copyWith(
            color:
                isSelected
                    ? theme.color.onPrimary
                    : theme.color.text, // 텍스트 색상 적용
          ),
        ),
      ),
    );
  }
}
