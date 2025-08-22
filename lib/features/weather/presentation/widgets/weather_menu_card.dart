import 'package:flutter/material.dart';

class WeatherMenuCard extends StatelessWidget {
  final String city;
  final String temperature;
  final String description;
  final VoidCallback onTap;

  const WeatherMenuCard({
    super.key,
    required this.city,
    required this.temperature,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.08,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.lightBlueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Город слева
            Text(
              city,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.022,
                color: Colors.white,
              ),
            ),
            // Температура и описание справа
            Row(
              children: [
                Text(
                  "$temperature°C",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.022,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.018,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
