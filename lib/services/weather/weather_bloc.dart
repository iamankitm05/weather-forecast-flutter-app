import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_forecast_app/models/weather.dart';
import 'package:weather_forecast_app/services/weather/weather_event.dart';
import 'package:weather_forecast_app/services/weather/weather_state.dart';
import 'package:http/http.dart' as http;

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(const InitialWeatherState()) {
    on<FetchingWeatherEvent>(_fetchWeather);
  }

  void _fetchWeather(
    FetchingWeatherEvent event,
    Emitter<WeatherState> emit,
  ) async {
    final cityName = event.cityName;
    final apiKey = dotenv.env['OPENWEATHER_API_KEY'];
    emit(const LoadingWeatherState());
    try {
      // 'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey'
      final uri = Uri(
        scheme: 'https',
        host: 'api.openweathermap.org',
        path: 'data/2.5/weather',
        queryParameters: {
          'q': cityName,
          'appid': apiKey,
        },
      );
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        emit(FetchedWeatherState(weather: weatherFromJson(response.body)));
      } else {
        throw Exception('Failed to load weather data');
      }
    } on Exception catch (e) {
      emit(FailureWeatherState(exception: e));
    }
  }
}
