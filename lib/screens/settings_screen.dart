import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Consumer<settingProvider>(
        builder: (context, settings, child) {
          return ListView(
            children: [
              _buildTemperatureSetting(settings),
              _buildThemeSetting(context, settings),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTemperatureSetting(settingProvider settings) {
    return ListTile(
      title: const Text('Temperature Unit'),
      subtitle: Text(settings.isCelsius ? 'Celsius (°C)' : 'Fahrenheit (°F)'),
      trailing: Switch(
        value: settings.isCelsius,
        onChanged: (value) {
          settings.toggleUnit();
        },
      ),
    );
  }

  Widget _buildThemeSetting(BuildContext context, settingProvider settings) {
    return ListTile(
      title: const Text('Appearance'),
      subtitle: Text(settings.themeMode.name.capitalize()),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => SimpleDialog(
            title: const Text('Select Theme'),
            children: ThemeMode.values.map((theme) {
              return RadioListTile<ThemeMode>(
                title: Text(theme.name.capitalize()),
                value: theme,
                groupValue: settings.themeMode,
                onChanged: (value) {
                  if (value != null) settings.setThemeMode(value);
                  Navigator.of(context).pop();
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

extension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
