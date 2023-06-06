// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:learn_flutter_simple_weather_app/constants/constants.dart';
import 'package:learn_flutter_simple_weather_app/exceptions/weather_exception.dart';
import 'package:learn_flutter_simple_weather_app/models/direct_geocoding.dart';
import 'package:learn_flutter_simple_weather_app/models/weather.dart';
import 'package:learn_flutter_simple_weather_app/services/http_error_handler.dart';

class WeatherApiServices {
  final http.Client client;

  WeatherApiServices({
    required this.client,
  });

  Future<DirectGeocoding> getDirectGeocoding(String city) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: kApiHost,
      path: '/geo/1.0/direct',
      queryParameters: {
        'q': city,
        'limit': kLimit,
        'appid': dotenv.env['APP_ID'],
      },
    );

    try {
      final http.Response response = await client.get(uri);

      if (response.statusCode != 200) {
        throw httpErrorHandler(response);
      }

      // If success, decode the body
      final responseBody = json.decode(response.body);

      if (responseBody.isEmpty) {
        throw WeatherException('Cannot get the location of the $city');
      }

      // Define DirectGeocoding
      final directGeocoding = DirectGeocoding.fromJson(responseBody);
      return directGeocoding;
    } catch (err) {
      // Just rethrow it
      rethrow;
    }
  }

  Future<Weather> getWeather(DirectGeocoding directGeocoding) async {
    final Uri uri = Uri(
      scheme: "https",
      host: kApiHost,
      path: '/data/2.5/weather',
      queryParameters: {
        'lat': '${directGeocoding.lat}',
        'lon': '${directGeocoding.lon}',
        'units': kUnit,
        'appid': dotenv.env['APP_ID'],
      },
    );

    try {
      final http.Response response = await client.get(uri);

      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }

      final weatherJson = json.decode(response.body);

      if (weatherJson.isEmpty) {
        throw WeatherException(
          'Cannot get the weather of the ${directGeocoding.name}',
        );
      }

      final Weather weather = Weather.fromJson(weatherJson);
      return weather;
    } catch (err) {
      rethrow;
    }
  }
}
