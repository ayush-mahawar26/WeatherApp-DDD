import 'package:geolocator/geolocator.dart';

abstract class WeatherRepo {
  Future<Map<String, dynamic>?> getWeather(Position pos);
  Future<Map<String, dynamic>?> getWeatherByCity(String city);
}
