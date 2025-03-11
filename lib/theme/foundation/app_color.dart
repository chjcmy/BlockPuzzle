part of 'app_theme.dart';

/// Tetris 어플리케이션 전용 색상 팔레트
class AppColor {
  /// 카드나 위젯 표면 배경 색상
  final Color surface;

  /// 전체 배경 색상
  final Color background;

  /// 기본 텍스트 색상
  final Color text;

  /// 보조 텍스트 색상
  final Color subtext;

  /// 주요 색상 (버튼, 헤더 등 강조 요소)
  final Color primary;

  /// 주요 색상 위의 텍스트/아이콘 색상
  final Color onPrimary;

  /// 보조 색상
  final Color secondary;

  /// 보조 색상 위의 텍스트/아이콘 색상
  final Color onSecondary;

  /// 추가 강조 색상
  final Color tertiary;

  /// 추가 강조 색상 위의 텍스트/아이콘 색상
  final Color onTertiary;

  const AppColor({
    required this.surface,
    required this.background,
    required this.text,
    required this.subtext,
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.tertiary,
    required this.onTertiary,
  });
}