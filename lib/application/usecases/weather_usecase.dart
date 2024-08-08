import 'package:weather_ddd/domain/repositories/weather_repo.dart';

class WeatherUseCase {
  final WeatherRepo weatherRepo;

  WeatherUseCase({required this.weatherRepo});

  Future<Map<String, dynamic>?> getWeather() async {
    return await weatherRepo.getWeather();
  }

  Future<Map<String, dynamic>?> getWeatherByCity(String city) async {
    return await weatherRepo.getWeatherByCity(city);
  }
}
