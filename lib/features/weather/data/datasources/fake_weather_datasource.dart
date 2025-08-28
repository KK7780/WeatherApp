import 'package:shared_preferences/shared_preferences.dart';
import '../models/weather_model.dart';

class FakeWeatherDatasource {
  // Список міст користувача (додані міста)
  List<String> userCities = [];

  // Список обласних міст
  final List<String> _oblastCities = [
    "Вінниця", "Волинь", "Дніпро", "Донецьк", "Житомир",
    "Закарпаття", "Івано-Франківськ", "Київ", "Кропивницький",
    "Луганськ", "Луцьк", "Львів", "Миколаїв", "Одеса", "Полтава",
    "Рівне", "Суми", "Тернопіль", "Харків", "Херсон",
    "Хмельницький", "Черкаси", "Чернігів", "Чернівці"
  ];

  // Завантаження міст при запуску
  Future<void> loadUserCities() async {
    final prefs = await SharedPreferences.getInstance();
    userCities = prefs.getStringList("userCities") ?? ["Харків"]; // дефолт
  }

  // Збереження міст
  Future<void> saveUserCities() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("userCities", userCities);
  }

  // Додавання міста
  Future<bool> addUserCity(String city) async {
    if (!_oblastCities.contains(city) || userCities.contains(city)) return false;
    userCities.add(city);
    await saveUserCities();
    return true;
  }

  // Видалення міста
  Future<bool> removeUserCity(String city) async {
    if (!userCities.contains(city)) return false;
    userCities.remove(city);
    await saveUserCities(); // обов'язково зберігаємо зміни
    return true;
  }

  // Отримання повного меню міст (тільки userCities)
  List<WeatherModel> getWeatherMenu() {
    return userCities.map((city) => WeatherModel(
      city: city,
      temperature: "${15 + city.length % 10}", // фейкова температура
      description: "Ясно",
      date: "ясно",
    )).toList();
  }

  // Деталі по конкретному місту
  WeatherModel getWeatherDetail(String city) {
    return getWeatherMenu().firstWhere(
          (c) => c.city.toLowerCase() == city.toLowerCase(),
      orElse: () => WeatherModel(
        city: city,
        temperature: "${15 + city.length % 10}",
        description: "Ясно",
        date: "ясно",
      ),
    );
  }

  // Погодинний прогноз (24 години)
  List<WeatherHourModel> getHourlyWeather(String city) {
    return List.generate(24, (index) => WeatherHourModel(
      hour: "${index.toString().padLeft(2, '0')}:00",
      temperature: "${15 + (index % 10)}°C",
      icon: "Ясно",
    ));
  }

  // Прогноз на тиждень
  List<WeatherInDateModel> getWeatherForWeak(String city) {
    return List.generate(7, (index) => WeatherInDateModel(
      minTemp: "${13 + (index % 10)}",
      maxTemp: "${26 + (index % 10)}",
      description: "Ясно",
      date: "${10 + index}.08.2025",
    ));
  }

  // Отримання списку обласних міст
  List<String> getOblastCities() => _oblastCities;

  // Перевірка обласного міста
  bool isOblastCity(String city) => _oblastCities.contains(city);
}
