import 'package:flutter/material.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(weather.city, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text("${weather.temperature}°C", style: const TextStyle(fontSize: 32, color: Colors.orangeAccent)),
            const SizedBox(height: 12),
            Text(weather.description, style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}

