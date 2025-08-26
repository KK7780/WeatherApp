class WeatherHour {
  final String hour;
  final String temperature;
  final String icon;

  WeatherHour({
    required this.hour,
    required this.temperature,
    required this.icon,
  });
}

class Weather {
  final String city;
  final String temperature;
  final String description;
  final String conditionKey;
  final List<WeatherHour> hourly;

  Weather({
    required this.city,
    required this.temperature,
    required this.description,
    required this.conditionKey,
    required this.hourly,
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