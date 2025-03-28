import 'package:flutter/material.dart';
import 'package:BlockPuzzle/theme/foundation/app_theme.dart';
import 'package:BlockPuzzle/theme/foundation/app_typo.dart';
import 'package:BlockPuzzle/theme/res/typo.dart';

class DarkTetrisTheme implements AppTheme {
  @override
  final Brightness brightness = Brightness.dark;

  @override
  final AppColor color = AppColor(
    surface: const Color(0xFF212121),
    background: const Color(0xFF121212),
    text: const Color(0xFFFFFFFF),
    subtext: const Color(0xFFEEEEEE),
    primary: const Color(0xFF00BCD4), // Cyan
    onPrimary: const Color(0xFF000000),
    secondary: const Color(0xFFFFC107), // Amber
    onSecondary: const Color(0xFF000000),
    tertiary: const Color(0xFF9C27B0), // Purple
    onTertiary: const Color(0xFF000000),
    border: const Color(0xFF616161),
    active: const Color(0xFF00BCD4),
    inactive: const Color(0xFF616161),
    error: const Color(0xFFD32F2F),
    success: const Color(0xFF388E3C),
    warning: const Color(0xFFFBC02D),
    inputBackground: const Color(0xFF212121),
    inputText: const Color(0xFFFFFFFF),
    shadow: const Color(0x29FFFFFF),
    overlay: const Color(0x80FFFFFF),
    diamondRank: const Color(0xFF00BFFF), // 밝은 하늘색
    platinumRank: const Color(0xFF8A2BE2), // 보라색
    goldRank: const Color(0xFFFFD700), // 금색
    silverRank: const Color(0xFFC0C0C0), // 은색
    bronzeRank: const Color(0xFFCD7F32), // 청동색
  );

  @override
  final AppTypo typo = AppTypo(
    typo: NotoSansTypo(),
    fontColor: const Color(0xFFFFFFFF),
  );

  @override
  final AppDeco deco = AppDeco(
    shadows: [
      BoxShadow(
        color: const Color(0x29FFFFFF),
        blurRadius: 4,
        offset: const Offset(0, 2),
      ),
    ],
    borderRadius: BorderRadius.circular(8),
  );

  @override
  set brightness(Brightness brightness) {}

  @override
  set color(AppColor color) {}

  @override
  set deco(AppDeco deco) {}

  @override
  set typo(AppTypo typo) {}
}
