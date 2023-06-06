import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:learn_flutter_simple_weather_app/models/custom_error.dart';
import 'package:learn_flutter_simple_weather_app/models/weather.dart';
import 'package:learn_flutter_simple_weather_app/repositories/weather_repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherCubit({required this.weatherRepository})
      : super(WeatherState.initial());

  Future<void> fetchWeather(String city) async {
    emit(state.copyWith(status: WeatherStatus.loading));

    try {
      final Weather weather = await weatherRepository.fetchWeather(city);

      // After we get the value, now we will emit the state
      emit(state.copyWith(
        status: WeatherStatus.loaded,
        weather: weather,
      ));

      // On Debug we will print the state
      if (kDebugMode) {
        print('fetchWeather Success state: $state');
      }
    } on CustomError catch (err) {
      // When CustomError occured, we will set the status to error
      // And give the message from err
      emit(state.copyWith(
        status: WeatherStatus.error,
        error: err,
      ));

      // On Debug we will print the state
      if (kDebugMode) {
        print('fetchWeather Error state: $state');
      }
    }
  }
}
