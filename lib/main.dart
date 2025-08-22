import 'package:flutter/material.dart';
import 'features/weather/presentation/pages/weather_menu_page.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Weather App",
      theme: ThemeData(
        fontFamily: "RedHatDisplay", // choose the style of text
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18),
          bodyMedium: TextStyle(fontSize: 16),
          bodySmall: TextStyle(fontSize: 14),
        ),
      ),
      home: const WeatherMenuPage(),
    );
  }
}
