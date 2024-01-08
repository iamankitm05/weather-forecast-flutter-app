import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast_app/services/weather/weather_bloc.dart';
import 'package:weather_forecast_app/services/weather/weather_event.dart';
import 'package:weather_forecast_app/services/weather/weather_state.dart';
import 'package:weather_forecast_app/widgets/weather_report.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController _weatherSearchController;

  @override
  void initState() {
    super.initState();
    _weatherSearchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(height: 120),
          Center(
            child: Text(
              'Weather forecast',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 35,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _weatherSearchController,
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
            decoration: const InputDecoration(
              hintText: 'Know weather forecast by city name',
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              hintStyle: TextStyle(
                color: Colors.white30,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              if (_weatherSearchController.text.isNotEmpty) {
                context.read<WeatherBloc>().add(FetchingWeatherEvent(
                    cityName: _weatherSearchController.text));
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                shape: const RoundedRectangleBorder()),
            child: const Text('Search'),
          ),
          const SizedBox(height: 16),
          BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
            if (state is LoadingWeatherState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is FetchedWeatherState) {
              return WeatherReport(weather: state.weather);
            }
            return const SizedBox();
          }),
        ],
      ),
    );
  }
}
