import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'temp_settings_state.dart';

class TempSettingsCubit extends Cubit<TempSettingsState> {
  TempSettingsCubit() : super(TempSettingsState.initial());

  void toggleTempUnit() {
    emit(
      state.copyWith(
        tempUnit: state.tempUnit == TempUnit.celsius
            ? TempUnit.fahrenheit
            : TempUnit.celsius,
      ),
    );

    if (kDebugMode) {
      print('tempUnit: $state');
    }
  }
}