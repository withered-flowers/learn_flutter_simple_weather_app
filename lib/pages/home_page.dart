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
      body: _showWeather(),
    );
  }

  Widget _showWeather() {
    // We will use BlocConsumer, to use the WeatherCubit and read its state
    return BlocConsumer<WeatherCubit, WeatherState>(
      listener: (context, state) {
        // Check if status that represent the Fetch status is error?
        if (state.status == WeatherStatus.error) {
          // It will show dialog with error message
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(state.error.errorMsg),
              );
            },
          );
        }
      },
      builder: ((context, state) {
        // If initial, then we will make a city to Choose
        if (state.status == WeatherStatus.initial) {
          return const Center(
            child: Text(
              'Select a city',
              style: TextStyle(fontSize: 20.0),
            ),
          );
        }

        if (state.status == WeatherStatus.loading) {
          return const Center(
            // When loading we will show a CircularProgressIndicator
            child: CircularProgressIndicator(),
          );
        }

        if (state.status == WeatherStatus.error && state.weather.name == '') {
          return const Center(
            child: Text(
              'Select a city',
              style: TextStyle(fontSize: 20.0),
            ),
          );
        }

        return Center(
          child: Text(
            state.weather.name,
            style: const TextStyle(fontSize: 18.0),
          ),
        );
      }),
    );
  }
}
