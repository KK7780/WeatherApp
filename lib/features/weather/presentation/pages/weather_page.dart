import 'package:flutter/material.dart';
import '../../data/models/weather_model.dart';
import '../../data/repositories/fake_weather_repository.dart';
import '../widgets/weather_main_details_card.dart';

import '../../data/repositories/fake_weather_repository.dart';

class WeatherPage extends StatelessWidget {
  final String city;

  const WeatherPage({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    final repository = FakeWeatherRepository();
    final weather = repository.getWeatherDetail(city);

    return Scaffold(
      appBar: AppBar(
        title: Text("Погода: ${weather.city}", style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            WeatherDetailCard(weather: weather),
            // Здесь можно добавлять другие виджеты с деталями
          ],
        ),
      ),
    );
  }
}

