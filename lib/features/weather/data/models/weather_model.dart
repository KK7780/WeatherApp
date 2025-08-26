class WeatherHourModel {
  final String hour;         // например "01:00"
  final String temperature;  // температура
  final String icon;         // путь к иконке (например "assets/icons/clear.png")

  WeatherHourModel({
    required this.hour,
    required this.temperature,
    required this.icon,
  });
}

class WeatherModel {
  final String city;
  final String temperature;
  final String description;
  final String date;

  WeatherModel({
    required this.city,
    required this.temperature,
    required this.description,
    required this.date,
  });
}

class WeatherInDateModel {
  final String minTemp;
  final String maxTemp;
  final String description;
  final String date;

  WeatherInDateModel({
    required this.minTemp,
    required this.maxTemp,
    required this.description,
    required this.date,
  });
}