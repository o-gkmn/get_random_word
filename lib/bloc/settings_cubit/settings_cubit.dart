import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:settings_repository/settings_repository.dart';
import 'package:word_repository/word_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(
      {required WordRepository wordRepository,
      required SettingsRepository settingsRepository})
      : _wordRepository = wordRepository,
        _settingsRepository = settingsRepository,
        super(const SettingsState(settingsStatus: SettingsStatus.initial));

  final WordRepository _wordRepository;
  final SettingsRepository _settingsRepository;

  void initSettings() {
    emit(state.copyWith(settingsStatus: SettingsStatus.loading));

    bool smallPackValue = _settingsRepository.getSmallPackSetting();
    bool mediumPackValue = _settingsRepository.getMediumPackSetting();
    bool largePackValue = _settingsRepository.getLargePackSetting();

    emit(
      state.copyWith(
        settingsStatus: SettingsStatus.loaded,
        smallPackSetting: smallPackValue,
        mediumPackSetting: mediumPackValue,
        largePackSetting: largePackValue,
      ),
    );
  }

  void switchSmallPack(bool isChecked) async {
    if (isChecked) {
      _wordRepository.fetchFromJson(addedBy: AddedBy.smallPack);
      await _settingsRepository.setSmallPackSetting(isChecked);
      emit(state.copyWith(smallPackSetting: true));
    } else {
      _wordRepository.clear(addedBy: AddedBy.smallPack);
      await _settingsRepository.setSmallPackSetting(isChecked);
      emit(state.copyWith(smallPackSetting: false));
    }
  }

  void switchMediumPack(bool isChecked) async {
    if (isChecked) {
      _wordRepository.fetchFromJson(addedBy: AddedBy.mediumPack);
      await _settingsRepository.setMediumPackSetting(isChecked);
      emit(state.copyWith(mediumPackSetting: true));
    } else {
      _wordRepository.clear(addedBy: AddedBy.mediumPack);
      await _settingsRepository.setMediumPackSetting(isChecked);
      emit(state.copyWith(mediumPackSetting: false));
    }
  }

  void switchLargePack(bool isChecked) async {
    if (isChecked) {
      _wordRepository.fetchFromJson(addedBy: AddedBy.largePack);
      await _settingsRepository.setLargePackSetting(isChecked);
      emit(state.copyWith(largePackSetting: true));
    } else {
      _wordRepository.clear(addedBy: AddedBy.largePack);
      await _settingsRepository.setLargePackSetting(isChecked);
      emit(state.copyWith(largePackSetting: false));
    }
  }
}
