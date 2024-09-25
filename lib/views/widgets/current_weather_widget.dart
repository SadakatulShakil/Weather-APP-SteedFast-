import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controllers/weather_controller.dart';

import '../../models/weather_model.dart';

class CurrentWeatherWidget extends StatelessWidget{
  final Weather weather;

  const CurrentWeatherWidget({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context){
    final weatherController = Provider.of<WeatherController>(context);
    final temperature = weatherController.convertTemperature(weather.temperature);
    final unit = weatherController.isCelsius ? '°C' : '°F';

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              '${temperature.toStringAsFixed(1)}$unit',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 16,),
            Text(
              weather.description,
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildWeatherInfo(Icons.water_drop, '${weather.humidity}%', 'Humidity'),
                _buildWeatherInfo(Icons.wind_power, '${weather.windSpeed} m/s', 'Wind'),
                _buildWeatherInfo(Icons.visibility, '${weather.visibility / 1000} km', 'Visibility'),
              ],
            ),
            const SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildWeatherInfo(Icons.compress, '${weather.pressure} hPa', 'Pressure'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherInfo(IconData icon, String value, String label){
    return Column(
      children: [
        Icon(icon),
        const SizedBox(height: 8,),
        Text(value),
        Text(label),
      ],
    );
  }
}