import 'dart:convert';
import 'package:http/http.dart' as http;


import '../models/weather_model.dart';
class WeatherService{

  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String _apiKey = '4d199c53c9a221f93f6f20d2b85d04c4';

  Future<Weather> getWeather(double lat, double lan) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lan&units=metric&appid=4d199c53c9a221f93f6f20d2b85d04c4'));

    print("code: "+ response.statusCode.toString());
    if(response.statusCode == 200){
      print("weather get");
      return Weather.fromJson(json.decode(response.body));
    }else{
      print("weather not get");
      throw Exception('Failed to load weather data');
    }
  }

  Future<List<Forecast>> getForeCast(double lat, double lan) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lan&units=metric&appid=4d199c53c9a221f93f6f20d2b85d04c4'));

    if(response.statusCode == 200){
      final data = json.decode(response.body);
      final List<dynamic> list = data['list'];
      return list
          .where((item) => item['dt_txt'].toString().contains('12:00:00'))
          .take(3)
          .map((item) => Forecast.fromJson(item))
          .toList();
    }else{
      throw Exception('Failed to load forecast data');
    }
  }
}

