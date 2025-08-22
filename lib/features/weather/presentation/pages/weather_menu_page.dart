import 'package:flutter/material.dart';
import '../../data/models/weather_model.dart';
import '../../data/repositories/fake_weather_repository.dart';
import '../widgets/weather_menu_card.dart';
import 'weather_page.dart';

class WeatherMenuPage extends StatelessWidget {
  const WeatherMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = FakeWeatherRepository();
    final List<WeatherModel> weatherList = repository.getWeatherMenu();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Выбор города", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.add),
                        title: const Text('Добавить город'),
                        onTap: () => Navigator.pop(context),
                      ),
                      ListTile(
                        leading: const Icon(Icons.delete),
                        title: const Text('Удалить город'),
                        onTap: () => Navigator.pop(context),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: weatherList.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final data = weatherList[index];
          return Center(
            child: WeatherMenuCard(
              city: data.city,
              temperature: data.temperature,
              description: data.description,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => WeatherPage(city: data.city),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
