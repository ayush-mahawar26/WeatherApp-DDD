abstract class WeatherState {}

class WeatherInitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherFetchedState extends WeatherState {
  Map<String, dynamic> weatherData;
  WeatherFetchedState({required this.weatherData});
}

class WeatherFetchErrorState extends WeatherState {
  String err;
  WeatherFetchErrorState({required this.err});
}
