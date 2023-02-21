part of 'settings_cubit.dart';

enum SettingsStatus { initial, loading, loaded, error }

class SettingsState extends Equatable {
  const SettingsState(
      {required this.settingsStatus,
      this.smallPackSetting = false,
      this.mediumPackSetting = false,
      this.largePackSetting = false,
      this.exception});

  final SettingsStatus settingsStatus;
  final bool smallPackSetting;
  final bool mediumPackSetting;
  final bool largePackSetting;
  final Exception? exception;

  SettingsState copyWith(
      {SettingsStatus? settingsStatus,
      bool? smallPackSetting,
      bool? mediumPackSetting,
      bool? largePackSetting,
      Exception? exception}) {
    return SettingsState(
        settingsStatus: settingsStatus ?? this.settingsStatus,
        smallPackSetting: smallPackSetting ?? this.smallPackSetting,
        mediumPackSetting: mediumPackSetting ?? this.mediumPackSetting,
        largePackSetting: largePackSetting ?? this.largePackSetting,
        exception: exception ?? this.exception);
  }

  @override
  List<Object> get props =>
      [settingsStatus, smallPackSetting, mediumPackSetting, largePackSetting];
}
