import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controllers/weather_controller.dart';
import 'package:intl/intl.dart';
import '../../models/weather_model.dart';

class ForecastWidget extends StatelessWidget{
  final List<HourlyForecast> forecast;

  const ForecastWidget({Key? key, required this.forecast}) : super(key: key);

  @override
  Widget build(BuildContext context){
    final weatherController = Provider.of<WeatherController>(context);
    final unit = weatherController.isCelsius ? '°C' : '°F';
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
          itemCount: forecast.length,
          itemBuilder: (context, index){
          HourlyForecast hourly = forecast[index];
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Text('${hourly.time.hour}:00',
                  style: TextStyle(color: Colors.white)
                  ),
                  Image.network(
                    'https://openweathermap.org/imag/wn/${hourly.iconCode}@2x.png',
                    width: 30,
                    height: 30,
                  ),
                  Text('${weatherController.convertTemperature(hourly.temperature).round()}$unit',
                      style: TextStyle(color: Colors.white)
                  ),
                ],
              ),
          );
          }
      )
    );
  }
  
}