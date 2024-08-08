abstract class WeatherRepo {
  Future<Map<String, dynamic>?> getWeather();
  Future<Map<String, dynamic>?> getWeatherByCity(String city);
}
