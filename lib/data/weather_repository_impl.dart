import 'package:weather_forecast_app/core/models/weather.dart';
import 'package:weather_forecast_app/core/repository/weather_repository.dart';
import 'package:weather_forecast_app/data/weather_data_provider.dart';


class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherDataProvider weatherDataProvider;

  WeatherRepositoryImpl({required this.weatherDataProvider});

  @override
  Future<Weather> getCurrentWeather(String location) {
    return weatherDataProvider.getCurrentWeather(location);
  }

  @override
  Future<List<Weather>> getFiveDayForecast(String location) {
    return weatherDataProvider.getFiveDayForecast(location);
  }

  @override
  Future<Weather> getCurrentWeatherByLocation(
      double latitude, double longitude) {
    return weatherDataProvider.getCurrentWeatherByLocation(latitude, longitude);
  }

  @override
  Future<List<Weather>> getFiveDayForecastByLocation(
      double latitude, double longitude) {
    return weatherDataProvider.getFiveDayForecastByLocation(
        latitude, longitude);
  }
}