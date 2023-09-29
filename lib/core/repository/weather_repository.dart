import 'package:weather_forecast_app/core/models/weather.dart';

abstract class WeatherRepository {
  Future<Weather> getCurrentWeather(String location);

  Future<List<Weather>> getFiveDayForecast(String location);
  Future<Weather> getCurrentWeatherByLocation(
      double latitude, double longitude);
  Future<List<Weather>> getFiveDayForecastByLocation(
      double latitude, double longitude);
}
