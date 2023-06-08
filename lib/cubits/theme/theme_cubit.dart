import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:learn_flutter_simple_weather_app/constants/constants.dart';
import 'package:learn_flutter_simple_weather_app/cubits/weather/weather_cubit.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  late final StreamSubscription weatherSubscription;
  final WeatherCubit weatherCubit;

  ThemeCubit({
    required this.weatherCubit,
  }) : super(ThemeState.initial()) {
    weatherSubscription = weatherCubit.stream.listen(
      (WeatherState weatherState) {
        if (kDebugMode) {
          print('weatherState: $weatherState');
        }

        if (weatherState.weather.temp > kWarmOrNot) {
          // emit
          emit(state.copyWith(appTheme: AppTheme.light));
        } else {
          // emit
          emit(state.copyWith(appTheme: AppTheme.dark));
        }
      },
    );
  }

  // Since we use StreamSubscription, we need to handle disconnection onClose
  @override
  Future<void> close() {
    weatherSubscription.cancel();
    return super.close();
  }
}
