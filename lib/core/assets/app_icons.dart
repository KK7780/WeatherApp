import 'package:flutter/widgets.dart';

class AppIcons {
  // Словарь: ключ состояния погоды → путь к PNG
  static const Map<String, String> weatherIcons = {
    "ясно": "assets/icons/sunny.png",
    "облачно": "assets/icons/cloudy.png",
    "дождь": "assets/icons/rain.png",
    "снег": "assets/icons/snow.png",
    "шторм": "assets/icons/storm.png",
  };

  // Метод для получения виджета Image по ключу
  static Widget getWeatherIcon(String conditionKey, {double size = 50}) {
    final path = weatherIcons[conditionKey] ?? "assets/icons/unknown.png";
    return Image.asset(
      path,
      width: size,
      height: size,
    );
  }
}

