import 'package:flutter/material.dart';

/// 단일 토글 버튼. [isSelected]가 true이면 검정 배경에 흰색 글자,
/// false이면 흰색 배경에 검정 글자와 검정 테두리를 표시
class ToggleButton extends StatelessWidget {
  final bool isSelected;
  final String label;
  final VoidCallback onPressed;

  const ToggleButton({
    Key? key,
    required this.isSelected,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: isSelected ? Colors.black : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
      minWidth: 100,
      height: 40,
      // 위/아래, 좌/우 여백 등을 조정하고 싶다면 padding 설정 가능
      // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}