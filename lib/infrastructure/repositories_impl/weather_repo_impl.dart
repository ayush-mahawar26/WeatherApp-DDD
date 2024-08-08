import 'package:weather_ddd/domain/repositories/weather_repo.dart';
import 'package:weather_ddd/infrastructure/datasource/weather_datasource.dart';

class WeatherRepositoryImplementation extends WeatherRepo {
  final WeatherDataSource weatherDataSource;

  WeatherRepositoryImplementation({required this.weatherDataSource});

  @override
  Future<Map<String, dynamic>?> getWeather() async {
    return await weatherDataSource.getWeather();
  }

  @override
  Future<Map<String, dynamic>?> getWeatherByCity(String city) async {
    return await weatherDataSource.getWeatherCity(city);
  }
}
