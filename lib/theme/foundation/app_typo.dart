import 'package:flutter/material.dart';
import 'package:BlockPuzzle/theme/res/typo.dart';

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
    color: fontColor.withOpacity(0.7),
  );

  /// 버튼 텍스트 스타일
  TextStyle get button => TextStyle(
    fontFamily: typo.fontFamily,
    fontSize: 16,
    fontWeight: typo.semiBold,
    color: fontColor,
  );

  /// 작은 본문 텍스트 스타일 (예: 부가 설명, 작은 텍스트)
  TextStyle get bodyText2 => TextStyle(
    fontFamily: typo.fontFamily,
    fontSize: 14,
    fontWeight: typo.regular,
    color: fontColor.withOpacity(0.8),
  );

  /// 강조된 텍스트 스타일 (예: 경고 메시지, 중요한 정보)
  TextStyle get emphasized => TextStyle(
    fontFamily: typo.fontFamily,
    fontSize: 18,
    fontWeight: typo.bold,
    color: fontColor,
  );

  /// 입력 필드 텍스트 스타일
  TextStyle get inputField => TextStyle(
    fontFamily: typo.fontFamily,
    fontSize: 16,
    fontWeight: typo.regular,
    color: fontColor,
  );

  /// 작은 캡션 스타일 (예: 툴팁, 작은 설명)
  TextStyle get smallCaption => TextStyle(
    fontFamily: typo.fontFamily,
    fontSize: 10,
    fontWeight: typo.light,
    color: fontColor.withOpacity(0.6),
  );

  /// 카드 제목 스타일 (예: 카드 위의 제목)
  TextStyle get cardTitle => TextStyle(
    fontFamily: typo.fontFamily,
    fontSize: 20,
    fontWeight: typo.semiBold,
    color: fontColor,
  );

  /// 카드 본문 스타일 (예: 카드 내부의 본문 텍스트)
  TextStyle get cardBody => TextStyle(
    fontFamily: typo.fontFamily,
    fontSize: 14,
    fontWeight: typo.regular,
    color: fontColor.withOpacity(0.9),
  );

  /// 에러 메시지 스타일
  TextStyle get error => TextStyle(
    fontFamily: typo.fontFamily,
    fontSize: 14,
    fontWeight: typo.regular,
    color: Colors.red,
  );

  /// 성공 메시지 스타일
  TextStyle get success => TextStyle(
    fontFamily: typo.fontFamily,
    fontSize: 14,
    fontWeight: typo.regular,
    color: Colors.green,
  );

  /// 대화형 텍스트 스타일 (예: 링크, 클릭 가능한 텍스트)
  TextStyle get interactive => TextStyle(
    fontFamily: typo.fontFamily,
    fontSize: 16,
    fontWeight: typo.semiBold,
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );
}
