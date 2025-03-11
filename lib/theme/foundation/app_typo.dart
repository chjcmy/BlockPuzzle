import 'package:flutter/material.dart';
import 'package:tetris_app/theme/res/typo.dart';

class AppTypo {
  final Typo typo;
  final Color fontColor;

  AppTypo({required this.typo, required this.fontColor});

  /// 게임 타이틀, 중요한 정보에 사용 (예: 'GAME OVER' 또는 점수)
  TextStyle get headline1 => TextStyle(
    fontFamily: typo.fontFamily,
    fontSize: 36,
    fontWeight: typo.bold,
    color: fontColor,
  );

  /// 서브 타이틀이나 강조 텍스트에 사용
  TextStyle get headline2 => TextStyle(
    fontFamily: typo.fontFamily,
    fontSize: 28,
    fontWeight: typo.semiBold,
    color: fontColor,
  );

  /// 일반 본문 텍스트 스타일 (예: 게임 설명, 메뉴 텍스트)
  TextStyle get bodyText1 => TextStyle(
    fontFamily: typo.fontFamily,
    fontSize: 16,
    fontWeight: typo.regular,
    color: fontColor,
  );

  /// 보조 텍스트 스타일 (예: 캡션, 날짜, 소제목)
  TextStyle get caption => TextStyle(
    fontFamily: typo.fontFamily,
    fontSize: 12,
    fontWeight: typo.light,
  );

  /// 버튼 텍스트 스타일
  TextStyle get button => TextStyle(
    fontFamily: typo.fontFamily,
    fontSize: 16,
    fontWeight: typo.semiBold,
    color: fontColor,
  );
}
