import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/weather_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if(_database != null) return _database!;
    _database = await _initDB('weather.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version)async{
    await db.execute('''
    CREATE TABLE weather (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      temperature REAL,
      main TEXT,
      description TEXT,
      windSpeed REAL,
      tempMin REAL,
      tempMax REAL,
      humidity INTEGER,
      pressure REAL,
      visibility REAL,
      iconCode TEXT,
      sunrise INTEGER,
      sunset INTEGER,
      uvIndex INTEGER
    )
    ''');

    await db.execute('''
    CREATE TABLE forecast (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date INTEGER,
      temperature REAL,
      iconCode TEXT,
      main TEXT
      )
    ''');
  }

  Future<int> insertWeather(Weather weather) async{
    final db = await database;
    return await db.insert('weather', {
      'temperature': weather.temperature,
      'main': weather.main,
      'description': weather.description,
      'windSpeed': weather.windSpeed,
      'tempMin': weather.tempMin,
      'tempMax': weather.tempMax,
      'humidity': weather.humidity,
      'pressure': weather.pressure,
      'visibility': weather.visibility,
      'iconCode': weather.iconCode,
      'sunrise': weather.sunrise,
      'sunset': weather.sunset,
      'uvIndex': weather.uvIndex,
    });
  }

  Future<int> insertForecast(Forecast forecast) async{
    final db = await database;
    return await db.insert('forecast', {
      'date': forecast.date.microsecondsSinceEpoch,
      'temperature': forecast.temperature,
      'iconCode': forecast.iconCode,
      'main': forecast.main,
    });
  }

  Future<Weather?> getLatestWeather() async{
    final db = await database;
    final maps = await db.query('weather', orderBy: 'id DESC', limit: 1);
    if(maps.isNotEmpty){
      return Weather(
          temperature: maps[0]['temperature'] as double,
          main: maps[0]['main'] as String,
          description: maps[0]['description'] as String,
          windSpeed: maps[0]['windSpeed'] as double,
          tempMin: maps[0]['tempMin'] as double,
          tempMax: maps[0]['tempMax'] as double,
          humidity: maps[0]['humidity'] as int,
          pressure: maps[0]['pressure'] as double,
          visibility: maps[0]['visibility'] as double,
          iconCode: maps[0]['iconCode'] as String,
          sunrise: maps[0]['sunrise'] as int,
          sunset: maps[0]['sunset'] as int,
          uvIndex: maps[0]['uvIndex'] as int,
      );
    }
    return null;
  }

  Future<List<Forecast>> getForecasts() async{
    final db = await database;
    final maps = await db.query('forecast', orderBy: 'date ASC');

    return List.generate(maps.length, (i){
      return Forecast(
          date: DateTime.fromMicrosecondsSinceEpoch(maps[i]['date'] as int),
          temperature: maps[i]['temperature'] as double,
          iconCode: maps[i]['iconCode'] as String,
          main: maps[i]['iconCode'] as String,
      );
    });
  }

  Future<void> deleteAllWeather() async{
    final db = await database;
    await db.delete('weather');
  }

  Future<void> deleteAllForecasts() async{
    final db = await database;
    await db.delete('forecast');
  }
}