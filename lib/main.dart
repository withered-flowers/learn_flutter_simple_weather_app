import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:learn_flutter_simple_weather_app/cubits/weather/weather_cubit.dart';
import 'package:learn_flutter_simple_weather_app/pages/home_page.dart';
import 'package:learn_flutter_simple_weather_app/repositories/weather_repository.dart';
import 'package:learn_flutter_simple_weather_app/services/weather_api_service.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Simple test for the weather cubit if it's working or note

    // Wrap the MaterialApp with RepositoryProvider
    return RepositoryProvider(
      create: (context) => WeatherRepository(
        weatherApiServices: WeatherApiServices(
          client: http.Client(),
        ),
      ),
      // Wrap the MaterialApp with MultiBlocProvider
      child: MultiBlocProvider(
        providers: [
          // We will use the WeatherCubit as the first provider
          BlocProvider<WeatherCubit>(
            create: (context) => WeatherCubit(
              weatherRepository: context.read<WeatherRepository>(),
            ),
          )
        ],
        child: MaterialApp(
          title: 'Weather App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
            useMaterial3: true,
          ),
          home: const HomePage(),
        ),
      ),
    );
  }
}
