import 'package:flutter/material.dart';
import 'weather_page.dart';

class WeatherMenuPage extends StatelessWidget {
  const WeatherMenuPage({super.key});

  final List<String> cities = const ["Kyiv", "Lviv", "Odessa"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Выбор города")),
      body: ListView.builder(
        itemCount: cities.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cities[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => WeatherPage(city: cities[index]),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // тут будет логика добавления города
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
