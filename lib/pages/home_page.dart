import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learn_flutter_simple_weather_app/repositories/weather_repository.dart';
import 'package:learn_flutter_simple_weather_app/services/weather_api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  _fetchWeather() {
    WeatherRepository(
      weatherApiServices: WeatherApiServices(client: http.Client()),
    ).fetchWeather('Jakarta');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Weather App"),
      ),
      body: const Center(
        child: Text('Home'),
      ),
    );
  }
}
