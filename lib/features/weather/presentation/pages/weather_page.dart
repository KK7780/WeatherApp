import 'package:flutter/material.dart';
import '../../data/models/weather_model.dart';
import '../../domain/repositories/fake_weather_repository.dart';
import '../widgets/weather_at_a_certain_time_card.dart';
import '../widgets/weather_day_card.dart';
import '../widgets/weather_details_card.dart';
import '../widgets/weather_main_details_card.dart';

import '../../domain/repositories/fake_weather_repository.dart';

class WeatherPage extends StatelessWidget {
  final String city;
  final titles = const ["Ветер","Влажность","Давление","Ощущается","UV","Видимость"];
  final values = const ["1","1","2","2","3","3"];

  const WeatherPage({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    final repository = FakeWeatherRepository();
    final weather = repository.getWeatherDetail(city);
    final weatherForWeak = repository.getWeatherForWeak(city);
    final hourlyWeather = repository.getHourlyWeather(city);

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

            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: hourlyWeather.length,
                itemBuilder: (context, index) {
                  final hourData = hourlyWeather[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: FractionallySizedBox(
                      heightFactor: 0.95, // 95% от высоты родителя
                      child: WeatherCard(weather: hourData),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 10),

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
                ].map((card) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FractionallySizedBox(
                    heightFactor: 0.95, // 90% от высоты родителя
                    child: card,
                  ),
                )).toList(),
              ),
            ),

            SizedBox(height: 10),

            // Вертикальна панель з карточками погоди на день
          Column(
            children: weatherForWeak.map((weatherData) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: WeatherDayCard(weatherInDate: weatherData),
              );
            }).toList(),
          ),
        ]),
      ),
    );
  }
}

