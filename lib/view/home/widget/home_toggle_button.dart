// lib/view/home/widget/home_toggle_button.dart
import 'package:flutter/material.dart';

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
    return SizedBox(
      width: width, // SizedBox로 감싸서 너비 설정 가능하게 함
      height: 40,
      child: MaterialButton(
        onPressed: onPressed,
        color: isSelected ? Colors.black : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.black, width: 1),
        ),
        child: Text(
          label,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
