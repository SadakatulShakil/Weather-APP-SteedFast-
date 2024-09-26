import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/location_service.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:geocoding/geocoding.dart';

class WeatherController extends ChangeNotifier{
  final WeatherService _weatherService = WeatherService();
  final LocationService _locationService = LocationService();

  Weather? _currentWeather;
  List<Forecast> _forecast = [];
  bool _isLoading = false;
  String _error = '';
  String _cityName = '';
  bool _isCelsius = true;
  // List<HourlyForecast> _hourlyForecast = [];
  // List<HourlyForecast> get hourlyForecast => _hourlyForecast;

  Weather? get  currentWeather => _currentWeather;
  List<Forecast> get forecast => _forecast;
  bool get isLoading => _isLoading;
  String get error => _error;
  String get cityName => _cityName;
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
      //_hourlyForecast = weatherData.hourlyForecast;
      _forecast = foreCastData;

    }catch(e){
      _error = 'Failed to fetch weather dat: ${e.toString()}';

    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCityData()async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final position = await _locationService.getCurrentLocation();
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      final nameOfCity = place.locality ?? "Unknown";

      _cityName = nameOfCity;
    } catch (e) {
      _error = 'Failed to get City';
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

