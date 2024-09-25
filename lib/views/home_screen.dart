import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controllers/weather_controller.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/views/widgets/current_weather_widget.dart';
import 'package:weather_app/views/widgets/forecast_widget.dart';

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
                child: Column(
                  children: [
                    CurrentWeatherWidget(weather: weatherController.currentWeather!),
                    const SizedBox(height: 20,),
                    ForecastWidget(forecast: weatherController.forecast),
                  ],
                ),
              );
            }
          },
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Provider.of<WeatherController>(context, listen: false).toggleTemperatureUnit();
        },
      ),
    );
  }
}