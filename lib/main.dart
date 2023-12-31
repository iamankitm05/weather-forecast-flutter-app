import 'package:flutter/material.dart';

void main() {
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
        useMaterial3: true,
      ),
      home: const Placeholder(),
    );
  }
}