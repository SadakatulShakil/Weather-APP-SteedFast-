class Weather {
  final double temperature;
  final String description;
  final double windSpeed;
  final int humidity;
  final double pressure;
  final double visibility;
  final String iconCode;

  Weather({
    required this.temperature,
    required this.description,
    required this.windSpeed,
    required this.humidity,
    required this.pressure,
    required this.visibility,
    required this.iconCode,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      windSpeed: json['wind']['speed'].toDouble(),
      humidity: json['main']['humidity'],
      pressure: json['main']['pressure'].toDouble(),
      visibility: json['visibility'].toDouble(),
      iconCode: json['weather'][0]['icon'],
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