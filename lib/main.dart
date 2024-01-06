import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_forecast_app/screens/home_screen.dart';
import 'package:weather_forecast_app/services/weather/weather_bloc.dart';

void main() async {
  await dotenv.load();
  runApp(const WeatherForecast());
}

class WeatherForecast extends StatelessWidget {
  const WeatherForecast({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather forecast',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8400FF),
          background: const Color(0xff000d21),
          primary: const Color(0xFF8400FF),
        ),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (_) => WeatherBloc(),
        child: const HomeScreen(),
      ),
    );
  }
}
