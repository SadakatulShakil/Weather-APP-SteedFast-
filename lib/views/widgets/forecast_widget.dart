import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controllers/weather_controller.dart';
import 'package:intl/intl.dart';
import '../../models/weather_model.dart';

class ForecastWidget extends StatelessWidget{
  final List<Forecast> forecast;

  const ForecastWidget({Key? key, required this.forecast}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '3-Day Forecast',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 16,),
            ...forecast.map((day) => _buildForecastDay(context, day)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildForecastDay(BuildContext context, Forecast day){
    final weatherController = Provider.of<WeatherController>(context);
    final temperature = weatherController.convertTemperature(day.temperature);
    final unit = weatherController.isCelsius ? '°C' : '°F';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(DateFormat('E, MMM d').format(day.date)),
          Image.network(
            'https://openweathermap.org/img/wn/${day.iconCode}@2x.png',
            width: 50,
            height: 50,
          ),
          Text('${temperature.toStringAsFixed(1)}$unit'),
        ],
      ),
    );
  }
}