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

  /// 경계선 색상
  final Color border;

  /// 활성 상태 색상 (예: 활성화된 버튼, 선택된 항목)
  final Color active;

  /// 비활성 상태 색상 (예: 비활성화된 버튼, 선택되지 않은 항목)
  final Color inactive;

  /// 에러 색상 (예: 오류 메시지, 경고)
  final Color error;

  /// 성공 색상 (예: 성공 메시지, 확인 상태)
  final Color success;

  /// 경고 색상 (예: 경고 메시지, 주의 상태)
  final Color warning;

  /// 입력 필드 배경 색상
  final Color inputBackground;

  /// 입력 필드 텍스트 색상
  final Color inputText;

  /// 그림자 색상
  final Color shadow;

  /// 오버레이 색상 (예: 모달 배경)
  final Color overlay;

  /// 랭크 색상
  final Color diamondRank; // 다이아몬드
  final Color platinumRank; // 플래티넘
  final Color goldRank; // 골드
  final Color silverRank; // 실버
  final Color bronzeRank; // 브론즈

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
    required this.border,
    required this.active,
    required this.inactive,
    required this.error,
    required this.success,
    required this.warning,
    required this.inputBackground,
    required this.inputText,
    required this.shadow,
    required this.overlay,
    required this.diamondRank,
    required this.platinumRank,
    required this.goldRank,
    required this.silverRank,
    required this.bronzeRank,
  });
}
