import 'package:flutter/material.dart';
import '../../data/models/weather_model.dart';
import '../../domain/weather_icon_mapper.dart';

class WeatherDayCard extends StatelessWidget {
  final WeatherInDateModel weatherInDate; // модель погоди на день

  const WeatherDayCard({
    super.key,
    required this.weatherInDate,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      height: screenHeight * 0.08, // висота картки приблизно 1/3 великої картки
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Дата зліва
          Text(
            weatherInDate.date,
            style: TextStyle(
              fontSize: screenHeight * 0.02,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),

          // Іконка погоди по центру
          WeatherIconMapper.mapConditionToWidget(
            weatherInDate.description, // ключ для іконки
            size: screenHeight * 0.05,
          ),

          // Мінімальна та максимальна температура справа
          Text(
            "${weatherInDate.minTemp}°C - ${weatherInDate.maxTemp}°C",
            style: TextStyle(
              fontSize: screenHeight * 0.022,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
