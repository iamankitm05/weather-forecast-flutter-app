import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_forecast_app/services/weather/weather_bloc.dart';
import 'package:weather_forecast_app/services/weather/weather_event.dart';
import 'package:weather_forecast_app/services/weather/weather_state.dart';

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
                fontSize: 26,
                fontWeight: FontWeight.w600,
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
              if(_weatherSearchController.text.isNotEmpty) {
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
              final weather = state.weather;
              return Table(
                border: TableBorder.all(color: Colors.white),
                defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
                children: [
                  _buildWeatherDataView(
                    label: 'City Name',
                    value: weather.name,
                    iconData: Icons.cloud,
                  ),
                  _buildWeatherDataView(
                    label: 'Weather',
                    value: '',
                  ),
                  _buildWeatherDataView(
                    label: 'id',
                    value: weather.weather[0].id.toString(),
                  ),
                  _buildWeatherDataView(
                    label: 'main',
                    value: weather.weather[0].main.toString(),
                  ),
                  _buildWeatherDataView(
                    label: 'Coord',
                    value: '',
                  ),
                  _buildWeatherDataView(
                    label: 'lat',
                    value: weather.coord.lat.toString(),
                  ),
                  _buildWeatherDataView(
                    label: 'lon',
                    value: weather.coord.lon.toString(),
                  ),
                ],
              );
            }
            return const SizedBox();
          }),
        ],
      ),
    );
  }

  TableRow _buildWeatherDataView({
    required String label,
    required String value,
    IconData? iconData,
  }) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(6),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        iconData != null
            ? Icon(
                iconData,
                color: Colors.white,
              )
            : const SizedBox(),
      ],
    );
  }
}
