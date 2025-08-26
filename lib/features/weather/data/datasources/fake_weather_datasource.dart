import '../models/weather_model.dart';

class FakeWeatherDatasource {
  // Список городов пользователя (добавленные города)
  final List<String> userCities = ["Харків"];

  // Список областных городов
  final List<String> _oblastCities = [
    "Вінниця", "Волинь", "Дніпро", "Донецьк", "Житомир",
    "Закарпаття", "Івано-Франківськ", "Київ", "Кропивницький",
    "Луганськ", "Луцьк", "Львів", "Миколаїв", "Одеса", "Полтава",
    "Рівне", "Суми", "Тернопіль", "Харків", "Херсон",
    "Хмельницький", "Черкаси", "Чернігів", "Чернівці"
  ];

  // Получение полного меню городов (только userCities)
  List<WeatherModel> getWeatherMenu() {
    return userCities.map((city) => WeatherModel(
      city: city,
      temperature: "${15 + city.length % 10}", // фейковая температура
      description: "Ясно",
      date: "ясно",
    )).toList();
  }

  // Детали по конкретному городу
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

  // Почасовой прогноз (24 часа)
  List<WeatherHourModel> getHourlyWeather(String city) {
    return List.generate(24, (index) => WeatherHourModel(
      hour: "${index.toString().padLeft(2, '0')}:00",
      temperature: "${15 + (index % 10)}°C",
      icon: "Ясно",
    ));
  }

  // Прогноз на неделю
  List<WeatherInDateModel> getWeatherForWeak(String city) {
    return List.generate(7, (index) => WeatherInDateModel(
      minTemp: "${13 + (index % 10)}",
      maxTemp: "${26 + (index % 10)}",
      description: "Ясно",
      date: "${10 + index}.08.2025",
    ));
  }

  // Добавление города
  bool addUserCity(String city) {
    if (!_oblastCities.contains(city) || userCities.contains(city)) return false;
    userCities.add(city);
    return true;
  }

  // Удаление города
  bool removeUserCity(String city) {
    return userCities.remove(city);
  }

  // Получение списка областных городов
  List<String> getOblastCities() => _oblastCities;

  // Проверка областного города
  bool isOblastCity(String city) => _oblastCities.contains(city);
}
