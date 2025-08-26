import 'package:flutter/widgets.dart';

class AppIcons {
  // Словарь: ключ состояния погоды → путь к PNG
  static const Map<String, String> weatherIcons = {
    "Ясно": "lib/core/assets/icons/sunny_sun_weather_climate_forecast.png",
    "облачно": "lib/core/assets/icons/cloudy.png",
    "дождь": "lib/core/assets/icons/rain.png",
    "снег": "lib/core/assets/icons/snow.png",
    "шторм": "lib/core/assets/icons/storm.png",
  };

  // Метод для получения виджета Image по ключу
  static Widget getWeatherIcon(String conditionKey, {double size = 50}) {
    final path = weatherIcons[conditionKey] ?? "lib/core/assets/icons/sunny_sun_weather_climate_forecast.png";
    return Image.asset(
      path,
      width: size,
      height: size,
    );
  }
}

