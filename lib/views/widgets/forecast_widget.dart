import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controllers/weather_controller.dart';
import 'package:intl/intl.dart';
import '../../models/weather_model.dart';

class ForecastWidget extends StatelessWidget{
  final List<Forecast> forecast;

  const ForecastWidget({Key? key, required this.forecast}) : super(key: key);

  String _getWeatherIcon(String weatherMode){
    if(weatherMode == 'Rain') return 'assets/images/rain.png';
    if(weatherMode == 'Thunderstorm') return 'assets/images/thunder.png';
    if(weatherMode == 'Clouds') return 'assets/images/prety_cloudy.png';
    if(weatherMode == 'Snow') return 'assets/images/winter.png';
    return 'assets/images/clear_sky.png';
  }

  @override
  Widget build(BuildContext context){
    return Container(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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

    return Container(
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15)
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Text(DateFormat('E, MMM d').format(day.date),
                style: TextStyle(color: Colors.white)),
            Image.asset(_getWeatherIcon(day.main), width: 40, height: 40,),
            SizedBox(height: 10,),
            Text('${temperature.toStringAsFixed(1)}$unit',
                style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}