import '../../data/datasources/fake_weather_datasource.dart';
import '../../data/models/weather_model.dart';

class FakeWeatherRepository {
  // Джерело фейкових даних про погоду
  final FakeWeatherDatasource datasource = FakeWeatherDatasource();

  // Отримати список доданих користувачем міст для головного меню
  List<WeatherModel> getWeatherMenu() => datasource.getWeatherMenu();

  // Отримати деталі по конкретному місту
  WeatherModel getWeatherDetail(String city) => datasource.getWeatherDetail(city);

  // Отримати погодинний прогноз для міста (24 години)
  List<WeatherHourModel> getHourlyWeather(String city) => datasource.getHourlyWeather(city);

  // Отримати прогноз на тиждень для міста
  List<WeatherInDateModel> getWeatherForWeak(String city) {
    final rawList = datasource.getWeatherForWeak(city);

    // Преобразуємо description в ключ для іконки
    return rawList.map((item) => WeatherInDateModel(
      minTemp: item.minTemp,
      maxTemp: item.maxTemp,
      description: item.description, // ключ для AppIcons
      date: item.date,
    )).toList();
  }

  // Перевірка, чи є місто обласним
  bool isOblastCity(String city) => datasource.isOblastCity(city);

  // Додати місто до списку користувача
  Future<bool> addUserCity(String city) => datasource.addUserCity(city);

  // Видалити місто зі списку користувача
  Future<bool> removeUserCity(String city) => datasource.removeUserCity(city);

  // Отримати список всіх доданих міст користувачем
  List<String> getUserCities() => datasource.userCities;
}
