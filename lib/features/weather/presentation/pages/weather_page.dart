import 'package:flutter/material.dart';
import '../../domain/repositories/fake_weather_repository.dart';
import '../widgets/weather_at_a_certain_time_card.dart';
import '../widgets/weather_day_card.dart';
import '../widgets/weather_details_card.dart';
import '../widgets/weather_main_details_card.dart';

class WeatherPage extends StatelessWidget {
  final String city;

  /// Сторінка з детальною погодою для конкретного міста
  const WeatherPage({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    final repository = FakeWeatherRepository();

    // Отримуємо деталі погоди для міста
    final weather = repository.getWeatherDetail(city);
    final weatherForWeak = repository.getWeatherForWeak(city); // прогноз на тиждень
    final hourlyWeather = repository.getHourlyWeather(city); // погодинний прогноз

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
            // Головна детальна карта погоди
            WeatherDetailCard(weather: weather),
            const SizedBox(height: 10),

            // Горизонтальна панель погодинного прогнозу
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
                      heightFactor: 0.95, // 95% від висоти батьківського контейнера
                      child: WeatherCard(weather: hourData),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            // Горизонтальна панель з основними параметрами погоди
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                children: [
                  WeatherStatCard(title: "Вітер", value: "5 м/с"),
                  WeatherStatCard(title: "Вологість", value: "80%"),
                  WeatherStatCard(title: "Тиск", value: "1012 hPa"),
                  WeatherStatCard(title: "Відчувається", value: "+24°C"),
                  WeatherStatCard(title: "UV", value: "5"),
                  WeatherStatCard(title: "Видимість", value: "10 км"),
                ].map((card) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FractionallySizedBox(
                    heightFactor: 0.95,
                    child: card,
                  ),
                )).toList(),
              ),
            ),

            const SizedBox(height: 10),

            // Вертикальна панель з картками погоди на кожен день тижня
            Column(
              children: weatherForWeak.map((weatherData) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: WeatherDayCard(weatherInDate: weatherData),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
