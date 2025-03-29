import 'package:BlockPuzzle/theme/foundation/app_theme.dart';
import 'package:BlockPuzzle/theme/foundation/app_typo.dart';
import 'package:BlockPuzzle/theme/res/typo.dart';
import 'package:flutter/material.dart';

class TritanopiaBlockPuzzleTheme implements AppTheme {
  @override
  final Brightness brightness = Brightness.light;

  @override
  final AppColor color = AppColor(
    surface: const Color(0xFFEFEFEF),
    background: const Color(0xFFFFFFFF),
    text: const Color(0xFF333333),
    subtext: const Color(0xFF666666),
    primary: const Color(0xFF8E24AA), // 보라색
    onPrimary: const Color(0xFFFFFFFF),
    secondary: const Color(0xFFFF7043), // 밝은 주황색
    onSecondary: const Color(0xFF000000),
    tertiary: const Color(0xFF00796B), // 청록색
    onTertiary: const Color(0xFFFFFFFF),
    border: const Color(0xFFCCCCCC),
    active: const Color(0xFF8E24AA),
    inactive: const Color(0xFFBDBDBD),
    error: const Color(0xFFD32F2F),
    success: const Color(0xFF388E3C),
    warning: const Color(0xFFFBC02D),
    inputBackground: const Color(0xFFF5F5F5),
    inputText: const Color(0xFF333333),
    shadow: const Color(0x29000000),
    overlay: const Color(0x80000000),
    diamondRank: const Color(0xFF00BFFF), // 밝은 하늘색
    platinumRank: const Color(0xFF8A2BE2), // 보라색
    goldRank: const Color(0xFFFFD700), // 금색
    silverRank: const Color(0xFFC0C0C0), // 은색
    bronzeRank: const Color(0xFFCD7F32), // 청동색
  );

  @override
  final AppTypo typo = AppTypo(
    typo: NotoSansTypo(), // Typo() 대신 NotoSansTypo() 사용
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
