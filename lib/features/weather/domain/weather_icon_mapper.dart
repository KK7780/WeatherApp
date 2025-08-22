import 'package:flutter/cupertino.dart';

import '../../../core/assets/app_icons.dart';

class WeatherIconMapper {
  /// Возвращает путь к PNG для заданного состояния погоды
  static String mapConditionToIconPath(String conditionKey) {
    return AppIcons.weatherIcons[conditionKey] ?? AppIcons.weatherIcons['unknown']!;
  }

  /// Можно сразу возвращать виджет Image
  static Widget mapConditionToWidget(String conditionKey, {double size = 50}) {
    final path = mapConditionToIconPath(conditionKey);
    return Image.asset(
      path,
      width: size,
      height: size,
    );
  }
}
