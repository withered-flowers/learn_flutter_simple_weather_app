import 'package:learn_flutter_simple_weather_app/exceptions/weather_exception.dart';
import 'package:learn_flutter_simple_weather_app/models/custom_error.dart';
import 'package:learn_flutter_simple_weather_app/models/weather.dart';
import 'package:learn_flutter_simple_weather_app/services/weather_api_service.dart';

class WeatherRepository {
  final WeatherApiServices weatherApiServices;

  WeatherRepository({
    required this.weatherApiServices,
  });

  Future<Weather> fetchWeather(String city) async {
    try {
      final directGeocoding = await weatherApiServices.getDirectGeocoding(city);
      // if (kDebugMode) {
      //   print('directGeocoding $directGeocoding');
      // }

      final Weather tempWeather =
          await weatherApiServices.getWeather(directGeocoding);
      // if (kDebugMode) {
      //   print('tempWeather: $tempWeather');
      // }

      final Weather weather = tempWeather.copyWith(
        name: directGeocoding.name,
        country: directGeocoding.country,
      );

      return weather;
    } on WeatherException catch (err) {
      throw CustomError(errorMsg: err.message);
    } catch (err) {
      throw CustomError(errorMsg: err.toString());
    }
  }
}
