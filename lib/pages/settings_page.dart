import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_flutter_simple_weather_app/cubits/temp_settings/temp_settings_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 10.0,
        ),
        child: ListTile(
          title: const Text("Temperature Unit"),
          subtitle: const Text("Celcius / Fahrenheit (Default: Celcius)"),
          trailing: Switch(
            value: context.watch<TempSettingsCubit>().state.tempUnit ==
                TempUnit.celsius,
            onChanged: (_) {
              context.read<TempSettingsCubit>().toggleTempUnit();
            },
          ),
        ),
      ),
    );
  }
}
