abstract class WeatherEvent {
  const WeatherEvent();
}

class FetchingWeatherEvent extends WeatherEvent {
  final String cityName;
  const FetchingWeatherEvent({required this.cityName});
}
