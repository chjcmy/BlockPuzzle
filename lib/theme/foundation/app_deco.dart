part of 'app_theme.dart';

/// 앱 전반에 적용할 데코레이션(그림자, 모서리 둥글기 등)을 관리하는 클래스
class AppDeco {
  /// 위젯에 적용할 그림자 효과 리스트
  final List<BoxShadow> shadows;

  /// 위젯의 기본 모서리 둥글기
  final BorderRadius borderRadius;

  const AppDeco({
    this.shadows = const [],
    this.borderRadius = BorderRadius.zero,
  });
}