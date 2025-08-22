import 'package:flutter/material.dart';
import '../../domain/weather_icon_mapper.dart';
import '../../data/models/weather_model.dart';

class WeatherDetailCard extends StatelessWidget {
  final WeatherModel weather;

  const WeatherDetailCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      height: screenHeight * 0.25, // ~1/4 высоты экрана
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Левый блок: Город и дата
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                weather.city,
                style: TextStyle(
                  fontSize: screenHeight * 0.03,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                // Форматируем текущую дату, например
                "${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}",
                style: TextStyle(
                  fontSize: screenHeight * 0.018,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          // Правый блок: Иконка и градусы
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WeatherIconMapper.mapConditionToWidget(weather.conditionKey, size: screenHeight * 0.08),
              const SizedBox(height: 8),
              Text(
                "${weather.temperature}°C",
                style: TextStyle(
                  fontSize: screenHeight * 0.028,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
