import 'package:flutter/material.dart';
import '../../data/models/weather_model.dart';
import '../../domain/repositories/fake_weather_repository.dart';
import '../widgets/weather_menu_card.dart';
import 'weather_page.dart';

class WeatherMenuPage extends StatefulWidget {
  final FakeWeatherRepository repository;

  const WeatherMenuPage({super.key, required this.repository});

  @override
  State<WeatherMenuPage> createState() => _WeatherMenuPageState();
}

class _WeatherMenuPageState extends State<WeatherMenuPage> {
  List<WeatherModel> weatherList = [];

  @override
  void initState() {
    super.initState();
    _loadWeatherList(); // завантажуємо список міст при старті
  }

  // Завантаження списку погоди
  void _loadWeatherList() {
    setState(() {
      weatherList = widget.repository.getWeatherMenu();
    });
  }

  // Оновлення списку на екрані
  void _refreshWeatherList() {
    setState(() {
      weatherList = widget.repository.getWeatherMenu();
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<WeatherModel> weatherList = widget.repository.getWeatherMenu();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Вибір міста", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              _showMenuBottomSheet(context);
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

  // Показ нижнього меню для додавання або видалення міста
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
              title: const Text('Додати місто'),
              onTap: () {
                Navigator.pop(context);
                _showAddCityDialog(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Видалити місто'),
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

  // Діалог для додавання нового міста
  void _showAddCityDialog(BuildContext context) {
    final TextEditingController cityController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Додати місто"),
          content: TextField(
            controller: cityController,
            decoration: const InputDecoration(
              hintText: "Введіть місто",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Скасувати"),
            ),
            ElevatedButton(
              onPressed: () async {
                final newCity = cityController.text.trim();
                if (newCity.isEmpty) {
                  Navigator.pop(context);
                  return;
                }

                final navigator = Navigator.of(context);
                final scaffoldMessenger = ScaffoldMessenger.of(context);

                final added = await widget.repository.addUserCity(newCity);

                if (!navigator.mounted) return;

                if (added) {
                  _refreshWeatherList();
                } else {
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Місто вже додано або його немає у списку обласних міст",
                      ),
                    ),
                  );
                }

                navigator.pop(); // закриваємо діалог
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  // Діалог для видалення обраних міст
  void _showDeleteCityDialog(BuildContext context) {
    final userCities = widget.repository.datasource.userCities;
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
              title: const Text("Видалити місто"),
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
                  child: const Text("Скасувати"),
                ),
                ElevatedButton(
                  onPressed: isDeleteEnabled
                      ? () {
                    final citiesToDelete = selectedCities.entries
                        .where((e) => e.value)
                        .map((e) => e.key)
                        .toList();

                    Navigator.pop(context); // закриваємо перший діалог
                    _confirmDeleteDialog(context, citiesToDelete);
                  }
                      : null,
                  child: const Text("Видалити"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Підтвердження видалення обраних міст
  void _confirmDeleteDialog(BuildContext context, List<String> citiesToDelete) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Підтвердження"),
          content: Text(
              "Ви дійсно хочете видалити наступні міста?\n${citiesToDelete.join(", ")}"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Скасувати"),
            ),
            ElevatedButton(
              onPressed: () {
                for (var city in citiesToDelete) {
                  widget.repository.removeUserCity(city);
                }
                Navigator.pop(context); // закриваємо підтвердження
                _refreshWeatherList(); // оновлюємо список на екрані
              },
              child: const Text("Видалити"),
            ),
          ],
        );
      },
    );
  }
}
