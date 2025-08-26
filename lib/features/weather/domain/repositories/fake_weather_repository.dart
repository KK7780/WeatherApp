import '../../data/datasources/fake_weather_datasource.dart';
import '../../data/models/weather_model.dart';

class FakeWeatherRepository {
  final FakeWeatherDatasource datasource = FakeWeatherDatasource();

  List<WeatherModel> getWeatherMenu() => datasource.getWeatherMenu();

  WeatherModel getWeatherDetail(String city) => datasource.getWeatherDetail(city);

  List<WeatherHourModel> getHourlyWeather(String city) => datasource.getHourlyWeather(city);

  List<WeatherInDateModel> getWeatherForWeak(String city) {
    final rawList = datasource.getWeatherForWeak(city);

    // Преобразуем description в ключ для иконки
    return rawList.map((item) => WeatherInDateModel(
      minTemp: item.minTemp,
      maxTemp: item.maxTemp,
      description: item.description, // ключ для AppIcons
      date: item.date,
    )).toList();
  }

  bool isOblastCity(String city) => datasource.isOblastCity(city);

  bool addUserCity(String city) => datasource.addUserCity(city);

  bool removeUserCity(String city) => datasource.removeUserCity(city);

  List<String> getUserCities() => datasource.userCities;
}
