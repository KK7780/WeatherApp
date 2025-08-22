import '../models/weather_model.dart';

class FakeWeatherDatasource {
  // Возвращает список городов с погодой
  List<WeatherModel> getWeatherMenu() {
    return [
      WeatherModel(city: "Kyiv", temperature: "18", description: "Ясно", conditionKey: "ясно"),
      WeatherModel(city: "Lviv", temperature: "16", description: "Облачно", conditionKey: "облачно"),
      WeatherModel(city: "Odessa", temperature: "22", description: "Солнечно", conditionKey: "ясно"),
    ];
  }

  // Возвращает детальную информацию о погоде по городу
  WeatherModel getWeatherDetail(String city) {
    switch (city) {
      case "Kyiv":
        return WeatherModel(city: "Kyiv", temperature: "18", description: "Ясно", conditionKey: "ясно");
      case "Lviv":
        return WeatherModel(city: "Lviv", temperature: "16", description: "Облачно", conditionKey: "облачно");
      case "Odessa":
        return WeatherModel(city: "Odessa", temperature: "22", description: "Солнечно", conditionKey: "ясно");
      default:
        return WeatherModel(city: city, temperature: "—", description: "—", conditionKey: "ясно");
    }
  }
}
