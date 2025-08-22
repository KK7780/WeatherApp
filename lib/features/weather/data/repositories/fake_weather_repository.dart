import '../datasources/fake_weather_datasource.dart';
import '../models/weather_model.dart';

class FakeWeatherRepository {
  final FakeWeatherDatasource datasource = FakeWeatherDatasource();

  List<WeatherModel> getWeatherMenu() {
    return datasource.getWeatherMenu();
  }

  WeatherModel getWeatherDetail(String city) {
    return datasource.getWeatherDetail(city);
  }
}
