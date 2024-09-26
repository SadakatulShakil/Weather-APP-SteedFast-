import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:weather_app/helper/database_helper.dart';


import '../models/weather_model.dart';
class WeatherService{

  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String _apiKey = '4d199c53c9a221f93f6f20d2b85d04c4';

  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<Weather> getWeather(double lat, double lan) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if(connectivityResult == ConnectivityResult.none){
      final cachedWeather = await _databaseHelper.getLatestWeather();
      if(cachedWeather != null){
        return cachedWeather;
      }else{
        throw Exception('No cached weather data available');
      }
    }else{
      final response = await http.get(Uri.parse(
          '$_baseUrl/weather?lat=$lat&lon=$lan&units=metric&exclude=minutely,alerts&appid=$_apiKey'));

      print("code: "+ response.statusCode.toString());
      if(response.statusCode == 200){
        final weather = Weather.fromJson(json.decode(response.body));

        await _databaseHelper.deleteAllWeather();
        await _databaseHelper.insertWeather(weather);
        return weather;
      }else{
        print("weather not get");
        throw Exception('Failed to load weather data');
      }
    }
  }

  Future<List<Forecast>> getForeCast(double lat, double lan) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if(connectivityResult == ConnectivityResult.none){
      return await _databaseHelper.getForecasts();
    }else{
      final response = await http.get(Uri.parse(
          '$_baseUrl/forecast?lat=$lat&lon=$lan&units=metric&appid=$_apiKey'));

      if(response.statusCode == 200){
        final data = json.decode(response.body);
        final List<dynamic> list = data['list'];
        final forecasts =  list
            .where((item) => item['dt_txt'].toString().contains('12:00:00'))
            .take(3)
            .map((item) => Forecast.fromJson(item))
            .toList();

        await _databaseHelper.deleteAllForecasts();
        for (var forecast in forecasts){
          await _databaseHelper.insertForecast(forecast);
        }
        return forecasts;
      }else{
        throw Exception('Failed to load forecast data');
      }
    }
  }
}

