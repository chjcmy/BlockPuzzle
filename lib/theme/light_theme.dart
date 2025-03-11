import 'package:flutter/material.dart';
import 'package:tetris_app/theme/foundation/app_theme.dart';
import 'package:tetris_app/theme/foundation/app_typo.dart';
import 'package:tetris_app/theme/res/palette.dart';
import 'package:tetris_app/theme/res/typo.dart';


class LightTetrisTheme implements AppTheme {
  @override
  Brightness brightness = Brightness.light;

  @override
  AppColor color = const AppColor(
    surface: Palette.greyLight,             // 카드, 위젯 표면 색상
    background: Palette.backgroundLight,      // 전체 배경색 (흰색)
    text: Palette.textLight,                  // 기본 텍스트 색상 (검정)
    subtext: Palette.greyMedium,              // 보조 텍스트 색상
    primary: Palette.primary,                 // 주요 색상 (녹색 계열)
    onPrimary: Palette.white,                 // 주요 색상 위 텍스트 색상
    secondary: Palette.secondary,             // 보조 색상 (붉은색 계열)
    onSecondary: Palette.white,               // 보조 색상 위 텍스트 색상
    tertiary: Palette.accent,                 // 강조 색상 (노란색 계열)
    onTertiary: Palette.black,                // 강조 색상 위 텍스트 색상
  );

  @override
  AppDeco deco = const AppDeco(
    shadows: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 10,
        offset: Offset(0, 5),
      ),
    ],
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  );

  @override
  AppTypo typo = AppTypo(
    typo: NotoSansTypo(),
    fontColor: Palette.textLight,
  );
}