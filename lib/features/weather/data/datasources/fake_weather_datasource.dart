import '../models/weather_model.dart';

class FakeWeatherDatasource {
  // Меню городов
  List<WeatherModel> getWeatherMenu() {
    return [
      WeatherModel(city: "Kyiv", temperature: "18", description: "Ясно", date: "ясно"),
      WeatherModel(city: "Lviv", temperature: "16", description: "Облачно", date: "облачно"),
      WeatherModel(city: "Odessa", temperature: "22", description: "Солнечно", date: "ясно"),
    ];
  }

  // Детали по городу
  WeatherModel getWeatherDetail(String city) {
    switch (city) {
      case "Kyiv":
        return WeatherModel(city: "Kyiv", temperature: "18", description: "Ясно", date: "ясно");
      case "Lviv":
        return WeatherModel(city: "Lviv", temperature: "16", description: "Ясно", date: "облачно");
      case "Odessa":
        return WeatherModel(city: "Odessa", temperature: "22", description: "Ясно", date: "ясно");
      default:
        return WeatherModel(city: city, temperature: "—", description: "—", date: "ясно");
    }
  }

  // Почасовой прогноз (24 часа)
  List<WeatherHourModel> getHourlyWeather(String city) {
    return List.generate(24, (index) {
      return WeatherHourModel(
        hour: "${index.toString().padLeft(2, '0')}:00",
        temperature: "${15 + (index % 10)}°C",   // условная температура
        icon: "ясно",          // фейковая иконка
      );
    });
  }


  List<WeatherInDateModel> getWeatherForWeak(String city) {
    return List.generate(7, (index) {
      return WeatherInDateModel(
        minTemp: "${13 + (index % 10)}" ,
        maxTemp: "${26 + (index % 10)}",
        description: "Ясно", // фейковая иконка
        date: "${10 + index}.08.2025",
      );
    });
  }
}
