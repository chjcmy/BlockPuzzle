import 'package:flutter/material.dart';

class ColorPalettes {
  // 기본 테마 색상
  static const Color primary = Color(0xFF4CAF50); // 녹색
  static const Color secondary = Color(0xFFFF5722); // 주황색
  static const Color background = Color(0xFFFFFFFF); // 흰색
  static const Color surface = Color(0xFFF5F5F5); // 밝은 회색
  static const Color error = Color(0xFFD32F2F); // 빨간색

  // 적록색약(Protanopia/Deuteranopia) 지원 색상
  static const Color primaryProtanopia = Color(0xFF00796B); // 청록색
  static const Color secondaryProtanopia = Color(0xFFFFA000); // 노란색

  // 청황색약(Tritanopia) 지원 색상
  static const Color primaryTritanopia = Color(0xFF8E24AA); // 보라색
  static const Color secondaryTritanopia = Color(0xFFFF7043); // 밝은 주황색

  // 완전색맹(Achromatopsia) 지원 색상
  static const Color primaryAchromatopsia = Color(0xFFBDBDBD); // 중간 회색
  static const Color secondaryAchromatopsia = Color(0xFF757575); // 어두운 회색
}
