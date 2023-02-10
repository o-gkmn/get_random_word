import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState(settingsStatus: SettingsStatus.initial));


  void initSettings(){
    //emit(state.copyWith(settingsStatus: SettingsStatus.loading));
    emit(state.copyWith(settingsStatus: SettingsStatus.loaded));
  }
}
