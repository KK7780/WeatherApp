import '../../data/datasources/fake_weather_datasource.dart';
import '../../data/models/weather_model.dart';

class FakeWeatherRepository {
  final FakeWeatherDatasource datasource = FakeWeatherDatasource();

  List<WeatherModel> getWeatherMenu() {
    return datasource.getWeatherMenu();
  }

  WeatherModel getWeatherDetail(String city) {
    return datasource.getWeatherDetail(city);
  }

  List<WeatherHourModel> getHourlyWeather(String city) {
    return datasource.getHourlyWeather(city);
  }

  List<WeatherInDateModel> getWeatherForWeak(String city) {
    final rawList = datasource.getWeatherForWeak(city);

    // Преобразуем описание в ключ для иконки
    return rawList.map((item) {
      final iconKey = item.description; // или преобразовать, если нужно
      return WeatherInDateModel(
        minTemp: item.minTemp,
        maxTemp: item.maxTemp,
        description: iconKey, // теперь description соответствует ключу для AppIcons
        date: item.date,
      );
    }).toList();
  }
}
