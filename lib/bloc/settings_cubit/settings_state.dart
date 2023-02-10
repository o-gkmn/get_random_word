part of 'settings_cubit.dart';

enum SettingsStatus { initial, loading, loaded, error }

class SettingsState extends Equatable {
  const SettingsState({required this.settingsStatus, this.exception});

  final SettingsStatus settingsStatus;
  final Exception? exception;

  SettingsState copyWith(
      {SettingsStatus? settingsStatus, Exception? exception}) {
    return SettingsState(
        settingsStatus: settingsStatus ?? this.settingsStatus,
        exception: exception ?? this.exception);
  }

  @override
  List<Object> get props => [];
}
