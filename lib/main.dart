import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/weather/domain/repositories/fake_weather_repository.dart';
import 'features/weather/presentation/pages/weather_menu_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Завантажуємо список міст користувача
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final List<String> savedCities = prefs.getStringList('userCities') ?? ["Харків"];

  // Ініціалізуємо репозиторій з збереженими містами
  final repository = FakeWeatherRepository();
  repository.datasource.userCities
    ..clear()
    ..addAll(savedCities);

  runApp(WeatherApp(repository: repository));
}

class WeatherApp extends StatelessWidget {
  final FakeWeatherRepository repository;

  const WeatherApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Погода",
      theme: ThemeData(
        fontFamily: "Roboto",
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18),
          bodyMedium: TextStyle(fontSize: 16),
          bodySmall: TextStyle(fontSize: 14),
        ),
      ),
      home: WeatherMenuPage(repository: repository), // головна сторінка з меню міст
    );
  }
}
