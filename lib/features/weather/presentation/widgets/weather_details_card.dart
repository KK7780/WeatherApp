import 'package:flutter/material.dart';

class WeatherStatCard extends StatelessWidget {
  final String title;        // підпис, наприклад: "Швидкість вітру"
  final String value;        // значення, наприклад: "5 м/с"
  final Color? color;        // необов'язково: фон картки
  final VoidCallback? onTap; // необов'язково: обробник натискання

  const WeatherStatCard({
    super.key,
    required this.title,
    required this.value,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1, // квадрат 1:1
      child: Material(
        color: color ?? Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),   // скруглення кутів
          side: const BorderSide(                     // контур
            color: Colors.lightBlueAccent,           // колір контуру
            width: 1,                                 // товщина контуру
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
                final valueSize = (side * 0.26).clamp(18, 28).toDouble();

                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Заголовок
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: titleSize,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // Значення
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: valueSize,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          height: 1.0,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
