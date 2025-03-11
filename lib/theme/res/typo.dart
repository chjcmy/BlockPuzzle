import 'package:flutter/material.dart';

/// 앱 전반에서 사용할 폰트 정보와 폰트 굵기를 정의한 추상 클래스
abstract class Typo {
  String get fontFamily;
  FontWeight get light;
  FontWeight get regular;
  FontWeight get semiBold;
  FontWeight get bold;
}

/// Tetris 어플에 적합한 NotoSans 폰트를 사용하는 Typo 구현체
class NotoSansTypo implements Typo {
  @override
  final String fontFamily = 'NotoSans';  // Noto Sans 폰트 (프로젝트에 포함 필요)

  @override
  final FontWeight light = FontWeight.w300;

  @override
  final FontWeight regular = FontWeight.w400;

  @override
  final FontWeight semiBold = FontWeight.w600;

  @override
  final FontWeight bold = FontWeight.w700;
}