import 'package:flutter/cupertino.dart';

import '../../../core/assets/app_icons.dart';

class WeatherIconMapper {
  // Повертає шлях до PNG для заданого стану погоди
  static String mapConditionToIconPath(String conditionKey) {
    // Якщо стан погоди не знайдено, повертаємо іконку "невідомо"
    return AppIcons.weatherIcons[conditionKey] ?? AppIcons.weatherIcons['unknown']!;
  }

  // Можна одразу повертати віджет Image для заданого стану погоди
  static Widget mapConditionToWidget(String conditionKey, {double size = 50}) {
    final path = mapConditionToIconPath(conditionKey);
    return Image.asset(
      path,
      width: size,
      height: size,
    );
  }
}
