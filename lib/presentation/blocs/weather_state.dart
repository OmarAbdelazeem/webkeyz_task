part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather currentWeather;
  final List<Weather> fiveDayForecast;

  WeatherLoaded(this.currentWeather, this.fiveDayForecast);

  @override
  List<Object> get props => [currentWeather, fiveDayForecast];
}

class WeatherError extends WeatherState {
  final String message;

  WeatherError(this.message);

  @override
  List<Object> get props => [message];
}