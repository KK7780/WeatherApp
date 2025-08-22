import 'package:flutter/material.dart';

class WeatherPage extends StatelessWidget {
  final String city;

  const WeatherPage({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Погода: $city"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Погода в $city", style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            const Text("🌤 +25°C", style: TextStyle(fontSize: 32)),
          ],
        ),
      ),
    );
  }
}
