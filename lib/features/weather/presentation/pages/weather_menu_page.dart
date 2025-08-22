import 'package:flutter/material.dart';
import 'weather_page.dart';

class WeatherMenuPage extends StatelessWidget {
  const WeatherMenuPage({super.key});

  // Список городов для отображения кнопок
  final List<String> cities = const ["Kyiv", "Lviv", "Odessa"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Верхняя панель приложения
      appBar: AppBar(
        title: const Text("Выбор города",
            style: TextStyle(
              color: Colors.white,
            )
        ),
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
                          onTap: () {
                            Navigator.pop(context);
                            // Логика добавления города
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.delete),
                          title: const Text('Удалить город'),
                          onTap: () {
                            Navigator.pop(context);
                            // Логика удаления города
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),

      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        children: cities.map((city) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7, // 70% ширины экрана
                height: MediaQuery.of(context).size.height * 0.06, // 6% высоты экрана
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => WeatherPage(city: city),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    city,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.02 ,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),

    );
  }
}
