import 'package:flutter/material.dart';
import 'package:tetris_app/theme/foundation/app_theme.dart';
import 'package:tetris_app/theme/foundation/app_typo.dart';
import 'package:tetris_app/theme/res/palette.dart';
import 'package:tetris_app/theme/res/typo.dart';


class DarkTetrisTheme implements AppTheme {
  @override
  Brightness brightness = Brightness.dark;

  @override
  AppColor color = const AppColor(
    surface: Palette.greyDark,                // 어두운 계열의 표면 색상
    background: Palette.backgroundDark,         // 전체 배경색 (검정)
    text: Palette.textDark,                     // 기본 텍스트 색상 (흰색)
    subtext: Palette.greyMedium,                // 보조 텍스트 색상 (적당한 명도)
    primary: Palette.primary,                   // 주요 색상 (녹색 계열)
    onPrimary: Palette.black,                   // 주요 색상 위 텍스트 색상 (어두운 색)
    secondary: Palette.secondary,               // 보조 색상 (붉은색 계열)
    onSecondary: Palette.black,                 // 보조 색상 위 텍스트 색상 (어두운 색)
    tertiary: Palette.accent,                   // 강조 색상 (노란색 계열)
    onTertiary: Palette.white,                  // 강조 색상 위 텍스트 색상 (흰색)
  );

  @override
  AppDeco deco = const AppDeco(
    shadows: [
      BoxShadow(
        color: Colors.black54,
        blurRadius: 10,
        offset: Offset(0, 5),
      ),
    ],
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  );

  @override
  AppTypo typo = AppTypo(
    typo: NotoSansTypo(),
    fontColor: Palette.textDark,
  );
}