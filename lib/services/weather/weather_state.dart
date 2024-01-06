import 'package:weather_forecast_app/models/weather.dart';

abstract class WeatherState {
  const WeatherState();
}

class InitialWeatherState extends WeatherState {
  const InitialWeatherState();
}

class LoadingWeatherState extends WeatherState {
  const LoadingWeatherState();
}

class FetchedWeatherState extends WeatherState {
  final Weather weather; 
  const FetchedWeatherState({required this.weather});
}

class FailureWeatherState extends WeatherState {
  final Exception exception;
  const FailureWeatherState({required this.exception});
}