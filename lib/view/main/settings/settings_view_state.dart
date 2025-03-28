// lib/view/settings/settings_view_state.dart
import 'package:equatable/equatable.dart';
import 'package:BlockPuzzle/view/base_view_state.dart';

class SettingsViewState extends BaseViewState with EquatableMixin {
  final String userId;
  final String version;
  final String developer;
  final String? error;

  const SettingsViewState({
    required super.isBusy,
    required this.userId,
    required this.version,
    required this.developer,
    this.error,
  });

  factory SettingsViewState.initial() {
    return const SettingsViewState(
      isBusy: false,
      userId: '',
      version: '1.2.0',
      developer: 'Tetris Team',
      error: null,
    );
  }

  SettingsViewState copyWith({
    bool? isBusy,
    String? userId,
    String? version,
    String? developer,
    String? error,
  }) {
    return SettingsViewState(
      isBusy: isBusy ?? this.isBusy,
      userId: userId ?? this.userId,
      version: version ?? this.version,
      developer: developer ?? this.developer,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    isBusy, 
    userId, 
    version, 
    developer,
    error,
  ];
}
