import 'package:flutter/material.dart';
import 'package:BlockPuzzle/theme/foundation/app_theme.dart';
import 'package:BlockPuzzle/theme/foundation/app_typo.dart';
import 'package:BlockPuzzle/theme/res/typo.dart';

class AchromatopsiaTetrisTheme implements AppTheme {
  @override
  final Brightness brightness = Brightness.light;

  @override
  final AppColor color = AppColor(
    surface: const Color(0xFFEFEFEF),
    background: const Color(0xFFFFFFFF),
    text: const Color(0xFF333333),
    subtext: const Color(0xFF666666),
    primary: const Color(0xFFBDBDBD), // 중간 회색
    onPrimary: const Color(0xFFFFFFFF),
    secondary: const Color(0xFF757575), // 어두운 회색
    onSecondary: const Color(0xFFFFFFFF),
    tertiary: const Color(0xFF9E9E9E), // 밝은 회색
    onTertiary: const Color(0xFFFFFFFF),
    border: const Color(0xFFCCCCCC),
    active: const Color(0xFFBDBDBD),
    inactive: const Color(0xFFBDBDBD),
    error: const Color(0xFFD32F2F),
    success: const Color(0xFF388E3C),
    warning: const Color(0xFFFBC02D),
    inputBackground: const Color(0xFFF5F5F5),
    inputText: const Color(0xFF333333),
    shadow: const Color(0x29000000),
    overlay: const Color(0x80000000),
    diamondRank: const Color(0xFFB0BEC5), // 밝은 회색
    platinumRank: const Color(0xFF90A4AE), // 중간 회색
    goldRank: const Color(0xFF78909C), // 어두운 회색
    silverRank: const Color(0xFF546E7A), // 더 어두운 회색
    bronzeRank: const Color(0xFF37474F), // 가장 어두운 회색
  );

  @override
  final AppTypo typo = AppTypo(
    typo: NotoSansTypo(),
    fontColor: const Color(0xFF333333),
  );

  @override
  final AppDeco deco = AppDeco(
    shadows: [
      BoxShadow(
        color: const Color(0x29000000),
        blurRadius: 4,
        offset: const Offset(0, 2),
      ),
    ],
    borderRadius: BorderRadius.circular(8),
  );

  @override
  set brightness(Brightness brightness) {
    // TODO: implement brightness
  }

  @override
  set color(AppColor color) {
    // TODO: implement color
  }

  @override
  set deco(AppDeco deco) {
    // TODO: implement deco
  }

  @override
  set typo(AppTypo typo) {
    // TODO: implement typo
  }
}
