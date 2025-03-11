import 'package:flutter/material.dart';

import 'app_typo.dart';
part 'app_color.dart';
part 'app_deco.dart';


/// 앱 전반의 테마 정보를 추상화한 클래스
abstract class AppTheme {
  late final Brightness brightness;
  late final AppColor color;
  late final AppDeco deco;
  late final AppTypo typo;
}