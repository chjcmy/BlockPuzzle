part of 'theme_service.dart';

abstract class ThemeServiceEvent {}

class onToggleTheme extends ThemeServiceEvent {}

class onChangeTheme extends ThemeServiceEvent {
  final ThemeType themeType;

  onChangeTheme(this.themeType);
}