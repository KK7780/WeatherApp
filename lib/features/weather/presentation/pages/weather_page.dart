import 'package:flutter/material.dart';
import '../../data/models/weather_model.dart';
import '../../data/repositories/fake_weather_repository.dart';
import '../widgets/weather_details_card.dart';
import '../widgets/weather_main_details_card.dart';

import '../../data/repositories/fake_weather_repository.dart';

class WeatherPage extends StatelessWidget {
  final String city;
  final titles = const ["Ветер","Влажность","Давление","Ощущается","UV","Видимость"];
  final values = const ["1","1","2","2","3","3"];

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
        const SizedBox(height: 10),

        // Горизонтальная панель с маленькими карточками
        SizedBox(
          height: 100, // высота панели
          child: ListView(
            scrollDirection: Axis.horizontal, // горизонтальный скролл
            padding: const EdgeInsets.symmetric(horizontal: 8), // отступ слева и справа
            children: [
              WeatherStatCard(title: "Ветер", value: "5 м/с"),
              WeatherStatCard(title: "Влажность", value: "80%"),
              WeatherStatCard(title: "Давление", value: "1012 hPa"),
              WeatherStatCard(title: "Ощущается", value: "+24°C"),
              WeatherStatCard(title: "UV", value: "5"),
              WeatherStatCard(title: "Видимость", value: "10 км"),
              WeatherStatCard(title: "Ветер", value: "5 м/с"),
              WeatherStatCard(title: "Влажность", value: "80%"),
              WeatherStatCard(title: "Давление", value: "1012 hPa"),
              WeatherStatCard(title: "Ощущается", value: "+24°C"),
              WeatherStatCard(title: "UV", value: "5"),
              WeatherStatCard(title: "Видимость", value: "10 км"),
            ].map((card) => Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: FractionallySizedBox(
                heightFactor: 0.95, // 90% от высоты родителя
                child: card,
              ),
            )).toList(),
          ),
        ),
          ],
        ),
      ),
    );
  }
}

