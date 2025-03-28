import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:BlockPuzzle/theme/achromatopsia_theme.dart';
import 'package:BlockPuzzle/theme/dark_theme.dart';
import 'package:BlockPuzzle/theme/foundation/app_theme.dart';
import 'package:BlockPuzzle/theme/foundation/app_typo.dart';
import 'package:BlockPuzzle/theme/light_theme.dart';
import 'package:BlockPuzzle/theme/protanopia_theme.dart';
import 'package:BlockPuzzle/theme/tritanopia_theme.dart';

part 'theme_event.dart';

enum ThemeType { light, dark, protanopia, tritanopia, achromatopsia }

class ThemeService extends Bloc<ThemeServiceEvent, AppTheme> {
  ThemeService({AppTheme? initialTheme})
    : super(initialTheme ?? LightTetrisTheme()) {
    on<onToggleTheme>(_toggleTheme);
    on<onChangeTheme>(_changeTheme);
  }

  /// 테마 전환 로직
  void _toggleTheme(onToggleTheme event, Emitter<AppTheme> emit) {
    emit(
      state.brightness == Brightness.light
          ? DarkTetrisTheme()
          : LightTetrisTheme(),
    );
  }

  /// 테마 변경 로직
  void _changeTheme(onChangeTheme event, Emitter<AppTheme> emit) {
    emit(_getThemeByType(event.themeType));
  }

  /// ThemeType에 따른 테마 반환
  AppTheme _getThemeByType(ThemeType themeType) {
    switch (themeType) {
      case ThemeType.light:
        return LightTetrisTheme();
      case ThemeType.dark:
        return DarkTetrisTheme();
      case ThemeType.protanopia:
        return ProtanopiaTetrisTheme();
      case ThemeType.tritanopia:
        return TritanopiaTetrisTheme();
      case ThemeType.achromatopsia:
        return AchromatopsiaTetrisTheme();
      }
  }

  ThemeType get currentThemeType {
    if (state is LightTetrisTheme) return ThemeType.light;
    if (state is DarkTetrisTheme) return ThemeType.dark;
    if (state is ProtanopiaTetrisTheme) return ThemeType.protanopia;
    if (state is TritanopiaTetrisTheme) return ThemeType.tritanopia;
    if (state is AchromatopsiaTetrisTheme) return ThemeType.achromatopsia;
    return ThemeType.light; // 기본값
  }

  /// Flutter의 ThemeData로 변환
  ThemeData get themeData {
    return ThemeData(
      brightness: state.brightness, // brightness 추가
      scaffoldBackgroundColor: state.color.background, // background 사용
      appBarTheme: AppBarTheme(
        backgroundColor: state.color.surface,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: state.color.text),
        titleTextStyle: state.typo.headline2,
      ),
      textTheme: TextTheme(
        displayLarge: state.typo.headline1,
        displayMedium: state.typo.headline2,
        bodyLarge: state.typo.bodyText1,
        bodyMedium: state.typo.bodyText2,
        bodySmall: state.typo.caption,
        labelLarge: state.typo.button,
        titleMedium: state.typo.headline2,
        titleSmall: state.typo.bodyText2,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: state.color.primary,
          foregroundColor: state.color.onPrimary,
          textStyle: state.typo.button,
          shape: RoundedRectangleBorder(borderRadius: state.deco.borderRadius),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          textStyle: state.typo.button,
          shape: RoundedRectangleBorder(borderRadius: state.deco.borderRadius),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: state.color.inputBackground,
        border: OutlineInputBorder(
          borderRadius: state.deco.borderRadius,
          borderSide: BorderSide(color: state.color.border),
        ),
        hintStyle: state.typo.bodyText2.copyWith(
          color: state.color.inputText.withOpacity(0.6),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      fontFamily: state.typo.typo.fontFamily,
    );
  }
}

extension ThemeServiceExt on BuildContext {
  ThemeService get themeService => read<ThemeService>();
  AppTheme get theme => themeService.state;
  AppColor get color => theme.color;
  AppDeco get deco => theme.deco;
  AppTypo get typo => theme.typo;
}
