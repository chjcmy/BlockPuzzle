import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tetris_app/theme/dark_theme.dart';
import 'package:tetris_app/theme/foundation/app_theme.dart';
import 'package:tetris_app/theme/foundation/app_typo.dart';
import 'package:tetris_app/theme/light_theme.dart';

part 'theme_event.dart';

class ThemeService extends Bloc<ThemeServiceEvent, AppTheme> {
  ThemeService({
    AppTheme? theme,
  }) : super(theme ?? LightTetrisTheme()) {
    on<onToggleTheme>((event, emit) {
      emit(state.brightness == Brightness.light ? DarkTetrisTheme() : LightTetrisTheme());
    });
  }

  ThemeData get themeData {
    return ThemeData(
      // scaffold 위젯의 배경색을 지정하는 theme Data의 속성
        scaffoldBackgroundColor: state.color.surface,
        appBarTheme: AppBarTheme(
          // 앱바 백그라운드 컬러 테마에 따라 변경
            backgroundColor: state.color.surface,
            // 앱바 그림자를 0으로 설정하여 평평 하게 만든다
            elevation: 0,
            // 앱바 타이틀을 중앙 정렬하지 않고 기본정렬을 사용하게 만든다
            centerTitle: false,
            iconTheme: IconThemeData(
              color: state.color.text,
            ),
            titleTextStyle:
            state.typo.headline2.copyWith(color: state.color.text)),
        );
  }
}

extension ThemeServiceExt on BuildContext {
  ThemeService get themeService => watch<ThemeService>();
  AppTheme get theme => themeService.state;
  AppColor get color => theme.color;
  AppDeco get deco => theme.deco;
  AppTypo get typo => theme.typo;
}


