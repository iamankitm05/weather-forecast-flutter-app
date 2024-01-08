import 'package:flutter/material.dart';
import 'package:weather_forecast_app/models/weather.dart';

class WeatherReport extends StatelessWidget {
  final Weather weather;
  const WeatherReport({
    super.key,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(
      color: Colors.white,
      fontSize: 40,
      fontWeight: FontWeight.w400,

    );
    const textStyle = TextStyle(
      color: Colors.white70,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(weather.name, style: titleStyle),
        Text('Lat: ${weather.coord.lat}', style: textStyle),
        Text('Lon: ${weather.coord.lon}', style: textStyle),
        const SizedBox(height: 16),
        Text('Country: ${weather.sys.country}', style: textStyle),
        Text('Temprature: ${weather.main.temp}°k', style: textStyle),
        Text('Humidity: ${weather.main.humidity}', style: textStyle),
        Text('Pressure: ${weather.main.pressure}', style: textStyle),
        const SizedBox(height: 16),
        Text('wind speed: ${weather.wind.speed}', style: textStyle),
        Text('wind deg: ${weather.wind.deg}°', style: textStyle),
        const SizedBox(height: 16),
        Text('Description: ${weather.weather[0].description}', style: textStyle),
        Text('Time: ${weather.dt}', style: textStyle),
      ],
    );
  }
}
