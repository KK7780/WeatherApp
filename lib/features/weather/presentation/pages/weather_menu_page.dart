import 'package:flutter/material.dart';
import '../../data/models/weather_model.dart';
import '../../domain/repositories/fake_weather_repository.dart';
import '../widgets/weather_menu_card.dart';
import 'weather_page.dart';

class WeatherMenuPage extends StatefulWidget {
  const WeatherMenuPage({super.key});

  @override
  State<WeatherMenuPage> createState() => _WeatherMenuPageState();
}

class _WeatherMenuPageState extends State<WeatherMenuPage> {
  final FakeWeatherRepository repository = FakeWeatherRepository();
  late List<WeatherModel> weatherList;

  @override
  void initState() {
    super.initState();
    weatherList = repository.getWeatherMenu();
  }

  void _refreshWeatherList() {
    setState(() {
      weatherList = repository.getWeatherMenu();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Выбор города",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => _showMenuBottomSheet(context),
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

  void _showMenuBottomSheet(BuildContext context) {
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
              onTap: () {
                Navigator.pop(context);
                _showAddCityDialog(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Удалить город'),
              onTap: () {
                Navigator.pop(context);
                _showDeleteCityDialog(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showAddCityDialog(BuildContext context) {
    final TextEditingController cityController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Добавить город"),
          content: TextField(
            controller: cityController,
            decoration: const InputDecoration(
              hintText: "Введите город",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Отмена"),
            ),
            ElevatedButton(
              onPressed: () {
                final newCity = cityController.text.trim();
                if (newCity.isNotEmpty) {
                  final added = repository.addUserCity(newCity);
                  if (added) {
                    _refreshWeatherList();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            "Город уже добавлен или отсутствует в списке областных городов"),
                      ),
                    );
                  }
                }
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
  void _showDeleteCityDialog(BuildContext context) {
    final userCities = repository.datasource.userCities;
    final Map<String, bool> selectedCities = {
      for (var city in userCities) city: false
    };

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            final isDeleteEnabled = selectedCities.values.any((v) => v);

            return AlertDialog(
              title: const Text("Удалить город"),
              content: SizedBox(
                width: double.maxFinite,
                child: ListView(
                  shrinkWrap: true,
                  children: selectedCities.keys.map((city) {
                    return CheckboxListTile(
                      title: Text(city),
                      value: selectedCities[city],
                      onChanged: (val) {
                        setState(() {
                          selectedCities[city] = val ?? false;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Отмена"),
                ),
                ElevatedButton(
                  onPressed: isDeleteEnabled
                      ? () {
                    final citiesToDelete = selectedCities.entries
                        .where((e) => e.value)
                        .map((e) => e.key)
                        .toList();

                    Navigator.pop(context); // закрываем первый диалог
                    _confirmDeleteDialog(context, citiesToDelete);
                  }
                      : null,
                  child: const Text("Удалить"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _confirmDeleteDialog(BuildContext context, List<String> citiesToDelete) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Подтверждение"),
          content: Text(
              "Вы действительно хотите удалить следующие города?\n${citiesToDelete.join(", ")}"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Отмена"),
            ),
            ElevatedButton(
              onPressed: () {
                for (var city in citiesToDelete) {
                  repository.removeUserCity(city);
                }
                Navigator.pop(context); // закрываем подтверждение
                _refreshWeatherList(); // обновляем список на экране
              },
              child: const Text("Удалить"),
            ),
          ],
        );
      },
    );
  }

}
