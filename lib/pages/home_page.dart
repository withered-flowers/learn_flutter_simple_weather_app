import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:learn_flutter_simple_weather_app/cubits/weather/weather_cubit.dart';
import 'package:learn_flutter_simple_weather_app/pages/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _city;

  // This is just a test code to fetch the weather
  // @override
  // void initState() {
  //   super.initState();
  //   _fetchWeather();
  // }

  // This is the test code function to fetch the weather
  // _fetchWeather() {
  //   // --- UNUSED
  //   // WeatherRepository(
  //   //   weatherApiServices: WeatherApiServices(client: http.Client()),
  //   // ).fetchWeather('Jakarta');
  //   // --- UNUSED

  //   // Now instead of call the WeatherRepository directly
  //   // We will read it from defined WeatherCubit in the Context
  //   context.read<WeatherCubit>().fetchWeather('Jakarta');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Weather App"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            // We will wait for a value from Navigator push
            // So this will be async
            onPressed: () async {
              // We will wait for the value from Navigator.push
              _city = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SearchPage();
                  },
                ),
              );

              if (kDebugMode) {
                print('city: $_city');
              }

              if (_city != null && context.mounted) {
                // Read from the WeatherCubit
                context.read<WeatherCubit>().fetchWeather(_city!);
              }
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Home'),
      ),
    );
  }
}
