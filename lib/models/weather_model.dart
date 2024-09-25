class Weather {
  final double temperature;
  final String description;
  final double windSpeed;
  final double tempMin;
  final double tempMax;
  final int humidity;
  final double pressure;
  final double visibility;
  final String iconCode;
  final int sunrise;
  final int sunset;
  final int uvIndex;

  Weather({
    required this.temperature,
    required this.description,
    required this.windSpeed,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
    required this.pressure,
    required this.visibility,
    required this.iconCode,
    required this.sunrise,
    required this.sunset,
    required this.uvIndex,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      windSpeed: json['wind']['speed'].toDouble(),
      tempMin: json['main']['temp_min'].toDouble(),
      tempMax: json['main']['temp_max'].toDouble(),
      humidity: json['main']['humidity'],
      pressure: json['main']['pressure'].toDouble(),
      visibility: json['visibility'].toDouble(),
      iconCode: json['weather'][0]['icon'],
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      uvIndex: json['sys']['type'],
    );
  }
}

class Forecast {
  final DateTime date;
  final double temperature;
  final String iconCode;

  Forecast({
    required this.date,
    required this.temperature,
    required this.iconCode,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      temperature: json['main']['temp'].toDouble(),
      iconCode: json['weather'][0]['icon'],
    );
  }
}