import 'package:flutter/material.dart';

import '../../../../core/assets/app_icons.dart';
import '../../data/models/weather_model.dart';

class WeatherCard extends StatelessWidget {
  final WeatherHourModel weather; // модель погоди на певну годину
  final Color? color;
  final VoidCallback? onTap;

  const WeatherCard({
    super.key,
    required this.weather,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1, // квадратна картка
      child: Material(
        color: color ?? Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(
            color: Colors.lightBlueAccent, // обводка
            width: 1,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final side = constraints.biggest.shortestSide;
                final titleSize = (side * 0.12).clamp(12, 18).toDouble();
                final valueSize = (side * 0.22).clamp(18, 26).toDouble();
                final iconSize = side * 0.35;

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Час
                      Text(
                        weather.hour,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: titleSize,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      // Іконка погоди (беремо за ключем)
                      AppIcons.getWeatherIcon(
                        weather.icon, // ключ, наприклад "Ясно"
                        size: iconSize,
                      ),

                      // Температура
                      Text(
                        weather.temperature,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: valueSize,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          height: 1.0,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
