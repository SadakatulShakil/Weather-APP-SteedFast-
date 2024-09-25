import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_model.dart';

import '../../controllers/weather_controller.dart';

class CurrentWeatherWidget extends StatelessWidget{
  final Weather weather;

  const CurrentWeatherWidget({
    Key? key,
    required this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    final weatherController = Provider.of<WeatherController>(context);
    final temperature = weatherController.convertTemperature(weather.temperature);
    final unit = weatherController.isCelsius ? '°C' : '°F';
    return Column(
      children: [
        Row(
          children: [
            Image.network(
              'https://openweathermap.org/img/wn/${weather.iconCode}@2x.png',
              width: 150,
              height: 150,
            ),
            Text(
              '${temperature.round()}°',
              style: const TextStyle(fontSize: 72, fontWeight: FontWeight.bold, color: Colors.white),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              weather.description,
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            Text(
              ' - H:${weather.tempMax.round()}$unit, L:${weather.tempMin.round()}$unit',
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            )
          ],
        )

      ],
    );
  }

}