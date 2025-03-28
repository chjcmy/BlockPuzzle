// lib/view/settings/settings_view_event.dart
import 'package:equatable/equatable.dart';

abstract class SettingsViewEvent extends Equatable {
  const SettingsViewEvent();

  @override
  List<Object?> get props => [];
}

class SettingsInitialized extends SettingsViewEvent {
  const SettingsInitialized();
}

class ChangeUserIdRequested extends SettingsViewEvent {
  const ChangeUserIdRequested();
}

class DeleteAllDataRequested extends SettingsViewEvent {
  const DeleteAllDataRequested();
}

class ChangeUserIdConfirmed extends SettingsViewEvent {
  final String newUserId;

  const ChangeUserIdConfirmed(this.newUserId);

  @override
  List<Object?> get props => [newUserId];
}