import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controllers/weather_controller.dart';
import 'package:weather_app/views/widgets/SunriseSunsetWidget.dart';
import 'package:weather_app/views/widgets/UVIndexWidget.dart';
import 'package:weather_app/views/widgets/current_weather_widget.dart';
import 'package:weather_app/views/widgets/forecast_widget.dart';
import 'package:weather_app/views/widgets/location_widget.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen ({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.microtask(() => Provider.of<WeatherController>(context, listen: false).fetchWeatherData());
    Future.microtask(() => Provider.of<WeatherController>(context, listen: false).fetchCityData());

  }
  Future<void> _refreshWeatherData() async {
    await Provider.of<WeatherController>(context, listen: false).fetchWeatherData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshWeatherData,
        child: Consumer<WeatherController>(
          builder: (context, weatherController, child) {
            if(weatherController.isLoading){
              return const Center(child: CircularProgressIndicator());
            }else if(weatherController.error.isNotEmpty){
              return Center(child: Text(weatherController.error));
            }else if(weatherController.currentWeather == null){
              return const Center(child: Text('No weather data available'));
            }else{
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.blue[300]!, Colors.blue[700]!]
                    )
                  ),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LocationWidget(cityName: weatherController.cityName),
                        const SizedBox(height: 15,),
                        CurrentWeatherWidget(
                          weather: weatherController.currentWeather!
                        ),
                        const SizedBox(height: 20,),
                        // HourlyForcastWidget(
                        //   hourlyFirecasts: weatherController.hourlyForecasts,
                        // )
                        Text(
                          '3-Day Forecast',
                            style: TextStyle(color: Colors.white70, fontSize: 25),
                        ),
                        ForecastWidget(forecast: weatherController.forecast),
                        const SizedBox(height: 20,),
                        SunriseSunsetWidget(
                          sunrise: weatherController.currentWeather!.sunrise,
                          sunset: weatherController.currentWeather!.sunset,
                        ),
                        const SizedBox(height: 20,),
                        UVIndexWidget(
                          uvIndex: weatherController.currentWeather!.uvIndex),
                      ],
                    ),
                  ),
                )
              );
            }
          },
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Provider.of<WeatherController>(context, listen: false).toggleTemperatureUnit();
        },
          child: const Icon(Icons.swap_horiz)
      ),
    );
  }
}