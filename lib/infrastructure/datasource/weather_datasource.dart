import 'package:dio/dio.dart';

class WeatherDataSource {
  final Dio dio;

  WeatherDataSource({required this.dio});

  Future<Map<String, dynamic>?> getWeather() async {
    String url =
        "https://api.openweathermap.org/data/2.5/weather?q=delhi&appid=a2b5eaf8400477d096f81ffa7883f3d1";
    final res = await dio.get(url);

    if (res.statusCode == 200) {
      Map<String, dynamic> data = res.data["main"];
      return data;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getWeatherCity(String cityName) async {
    try {
      String url =
          "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=a2b5eaf8400477d096f81ffa7883f3d1";
      Response<Map<String, dynamic>> res = await dio.get(url);
      print(res);

      if (res.statusCode == 200) {
        Map<String, dynamic>? data = res.data;
        if (data!['cod'] == 200) {
          return data["main"];
        } else {
          return data;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
