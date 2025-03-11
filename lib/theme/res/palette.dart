import 'package:flutter/material.dart';

/// Tetris 어플리케이션에서 사용할 색상 팔레트
abstract class Palette {
  // 주요 색상 계열
  static const Color primary = Color(0xFF5AC463);   // 녹색 계열
  static const Color secondary = Color(0xFFFB432F); // 붉은색 계열
  static const Color accent = Color(0xFFFEC85B);    // 노란색 계열

  // 기본 배경 및 텍스트 색상
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  // 배경 색상 (라이트/다크)
  static const Color backgroundLight = Colors.white;
  static const Color backgroundDark = Colors.black;

  // 텍스트 색상 (라이트/다크)
  static const Color textLight = Colors.black;
  static const Color textDark = Colors.white;

  // 추가적인 무채색 계열
  static const Color greyLight = Color(0xFFFAFAFA);
  static const Color greyMedium = Color(0xFFB7B7B7);
  static const Color greyDark = Color(0xFF111111);
}