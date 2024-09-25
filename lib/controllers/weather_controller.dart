import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


import '../models/weather_model.dart';
class WeatherController extends ChangeNotifier{

  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String _apiKey = '4d199c53c9a221f93f6f20d2b85d04c4';

  Future<Weather> getWeather(double lat, double lan) async {
    final response = await http.get(Uri.parse(
      '$_baseUrl/weather?lat=$lat&lan=$lan&units=mectric&appid=$_apiKey'));

    if(response.statusCode == 200){
      return Weather.fromJson(json.decode(response.body));
    }else{
      throw Exception('Failed to load weather data');
    }
  }

  Future<List<Forecast>> getForeCast(double lat, double lan) async {
    final response = await http.get(Uri.parse(
        '$_baseUrl/forecast?lat=$lat&lan=$lan&units=mectric&appid=$_apiKey'));

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

