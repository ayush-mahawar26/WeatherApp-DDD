// ignore_for_file: overridden_fields

import 'dart:convert';

import 'package:weather_ddd/domain/entities/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  double? pressure;
  double? humidity;
  double? seaLevel;
  double? grndLevel;

  WeatherModel(
      {required this.temp,
      required this.feelsLike,
      required this.tempMax,
      required this.tempMin,
      required this.pressure,
      required this.humidity,
      required this.seaLevel,
      required this.grndLevel})
      : super(
            temp: temp,
            feelsLike: feelsLike,
            tempMax: tempMax,
            tempMin: tempMin,
            pressure: pressure,
            humidity: humidity,
            seaLevel: seaLevel,
            grndLevel: grndLevel);

  factory WeatherModel.fromJson(String str) =>
      WeatherModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromMap(Map<String, dynamic> json) => WeatherModel(
        temp: json["temp"]?.toDouble(),
        feelsLike: json["feels_like"]?.toDouble(),
        tempMin: json["temp_min"]?.toDouble(),
        tempMax: json["temp_max"]?.toDouble(),
        pressure: json["pressure"]?.toDouble(),
        humidity: json["humidity"]?.toDouble(),
        seaLevel: json["sea_level"]?.toDouble(),
        grndLevel: json["grnd_level"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "pressure": pressure,
        "humidity": humidity,
        "sea_level": seaLevel,
        "grnd_level": grndLevel,
      };
}
