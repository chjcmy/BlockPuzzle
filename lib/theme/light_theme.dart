import 'package:flutter/material.dart';
import 'package:BlockPuzzle/theme/foundation/app_theme.dart';
import 'package:BlockPuzzle/theme/foundation/app_typo.dart';
import 'package:BlockPuzzle/theme/res/typo.dart';

class LightTetrisTheme implements AppTheme {
  @override
  final Brightness brightness = Brightness.light;

  @override
  final AppColor color = AppColor(
    surface: const Color(0xFFF5F5F5),
    background: const Color(0xFFFFFFFF),
    text: const Color(0xFF333333),
    subtext: const Color(0xFF666666),
    primary: const Color(0xFF00796B), // Teal
    onPrimary: const Color(0xFFFFFFFF),
    secondary: const Color(0xFFFBC02D), // Amber
    onSecondary: const Color(0xFF000000),
    tertiary: const Color(0xFF8E24AA), // Purple
    onTertiary: const Color(0xFFFFFFFF),
    border: const Color(0xFFCCCCCC),
    active: const Color(0xFF00796B),
    inactive: const Color(0xFFBDBDBD),
    error: const Color(0xFFD32F2F),
    success: const Color(0xFF388E3C),
    warning: const Color(0xFFFBC02D),
    inputBackground: const Color(0xFFF5F5F5),
    inputText: const Color(0xFF333333),
    shadow: const Color(0x29000000),
    overlay: const Color(0x80000000),
    diamondRank: const Color(0xFF3BE8FF), // 다이아몬드
    platinumRank: const Color(0xFFB191FF), // 플래티넘
    goldRank: Colors.amber, // 골드
    silverRank: Colors.grey, // 실버
    bronzeRank: Colors.brown, // 브론즈
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
  set brightness(Brightness brightness) {}

  @override
  set color(AppColor color) {}

  @override
  set deco(AppDeco deco) {}

  @override
  set typo(AppTypo typo) {}
}
