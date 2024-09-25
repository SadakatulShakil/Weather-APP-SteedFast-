import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/location_service.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherController extends ChangeNotifier{
  final WeatherService _weatherService = WeatherService();
  final LocationService _locationService = LocationService();

  Weather? _currentWeather;
  List<Forecast> _forecast = [];
  bool _isLoading = false;
  String _error = '';
  bool _isCelsius = true;

  Weather? get  currentWeather => _currentWeather;
  List<Forecast> get forecast => _forecast;
  bool get isLoading => _isLoading;
  String get error => _error;
  bool get isCelsius => _isCelsius;

  Future<void> fetchWeatherData() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try{
      final position = await _locationService.getCurrentLocation();
      final weatherData = await _weatherService.getWeather(position.latitude, position.longitude);
      final foreCastData = await _weatherService.getForeCast(position.latitude, position.longitude);

      _currentWeather = weatherData;
      _forecast = foreCastData;

    }catch(e){
      _error = 'Failed to fetch weather dat: ${e.toString()}';

    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleTemperatureUnit(){
    _isCelsius = !_isCelsius;
    notifyListeners();
  }

  double convertTemperature(double temperature){
    if(_isCelsius){
      return temperature;
    }else{
      return(temperature * 9 / 5)+32;
    }
  }
}

