import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weather_forecast_app/core/models/weather.dart';

class WeatherDataProvider {
  final String apiKey =
      '';

  Future<Weather> getCurrentWeather(String location) async {
    final url =
        'http://api.openweathermap.org/data/2.5/weather?q=$location&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final parsedJson = json.decode(response.body);
      return Weather(
          temperature: parsedJson['main']['temp'],
          weatherDescription: parsedJson['weather'][0]['description'],
          humidity: parsedJson['main']['humidity'],
          windSpeed: parsedJson['wind']['speed'],
          city: parsedJson["name"]);
    } else {
      throw Exception('Failed to load current weather');
    }
  }

  Future<List<Weather>> getFiveDayForecast(String location) async {
    final url =
        'http://api.openweathermap.org/data/2.5/forecast?q=$location&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final parsedJson = json.decode(response.body);
      final List<dynamic> list = parsedJson['list'];
      return list
          .map((json) => Weather(
              temperature: json['main']['temp'],
              weatherDescription: json['weather'][0]['description'],
              humidity: json['main']['humidity'],
              windSpeed: json['wind']['speed'],
              city: ""))
          .toList();
    } else {
      throw Exception('Failed to load 5-day forecast');
    }
  }

  Future<Weather> getCurrentWeatherByLocation(
      double latitude, double longitude) async {
    final url =
        'http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final parsedJson = json.decode(response.body);
      return Weather(
          temperature: parsedJson['main']['temp'],
          weatherDescription: parsedJson['weather'][0]['description'],
          humidity: parsedJson['main']['humidity'],
          windSpeed: parsedJson['wind']['speed'],
          city: parsedJson['name']);
    } else {
      throw Exception('Failed to load current weather');
    }
  }

  Future<List<Weather>> getFiveDayForecastByLocation(
      double latitude, double longitude) async {
    final url =
        'http://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final parsedJson = json.decode(response.body);
      final List<dynamic> list = parsedJson['list'];
      return list
          .map((json) => Weather(
              temperature: json['main']['temp'],
              weatherDescription: json['weather'][0]['description'],
              humidity: json['main']['humidity'],
              windSpeed: json['wind']['speed'],
              city: ""))
          .toList();
    } else {
      throw Exception('Failed to load 5-day forecast');
    }
  }
}
