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

  String _getWeatherIcon(String weatherMode){
    if(weatherMode == 'Rain') return 'assets/images/rain.png';
    if(weatherMode == 'Thunderstorm') return 'assets/images/thunder.png';
    if(weatherMode == 'Clouds') return 'assets/images/prety_cloudy.png';
    if(weatherMode == 'Snow') return 'assets/images/winter.png';
    return 'assets/images/clear_sky.png';

  }
  @override
  Widget build(BuildContext context){
    final weatherController = Provider.of<WeatherController>(context);
    final temperature = weatherController.convertTemperature(weather.temperature);
    final unit = weatherController.isCelsius ? '°C' : '°F';
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(_getWeatherIcon(weather.main), width: 80, height: 80, fit: BoxFit.cover,),
            SizedBox(width: 12,),
            Text(
              '${temperature.round()}°',
              style: const TextStyle(fontSize: 72, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(width: 15,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.air_outlined, color: Colors.white70, size: 20,),
                    SizedBox(width: 5,),
                    Text('${weather.windSpeed} m/s', style: TextStyle(color: Colors.white70),),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.water_drop, color: Colors.white70, size: 20,),
                    SizedBox(width: 5,),
                    Text('${weather.windSpeed} g/m3', style: TextStyle(color: Colors.white70),),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.compress, color: Colors.white70, size: 20,),
                    SizedBox(width: 5,),
                    Text('${weather.windSpeed} hPa', style: TextStyle(color: Colors.white70),),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.visibility, color: Colors.white70, size: 20,),
                    SizedBox(width: 5,),
                    Text('${weather.windSpeed} m', style: TextStyle(color: Colors.white70),),
                  ],
                )
              ],
            )
          ],
        ),
        SizedBox(height: 20,),
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