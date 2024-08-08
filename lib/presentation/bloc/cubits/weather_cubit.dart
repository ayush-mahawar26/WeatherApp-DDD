import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_ddd/application/usecases/weather_usecase.dart';
import 'package:weather_ddd/presentation/bloc/states/weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherUseCase weatherUseCase;
  WeatherCubit({required this.weatherUseCase}) : super(WeatherInitialState()) {
    // fetchWeatherUsingLatLong();
  }

  void fetchWeatherByCity(String city) async {
    emit(WeatherLoadingState());
    Map<String, dynamic>? weatherData =
        await weatherUseCase.getWeatherByCity(city);
    if (weatherData != null) {
      emit(WeatherFetchedState(weatherData: weatherData));
    } else {
      emit(WeatherFetchErrorState(err: "No city Found"));
    }
  }

  void fetchWeatherUsingLatLong(Position pos) async {
    emit(WeatherLoadingState());
    Map<String, dynamic>? weatherData = await weatherUseCase.getWeather(pos);
    if (weatherData != null) {
      emit(WeatherFetchedState(weatherData: weatherData));
    } else {
      emit(WeatherFetchErrorState(err: "Weather is null"));
    }
  }
}
