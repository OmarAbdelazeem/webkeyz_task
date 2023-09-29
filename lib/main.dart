import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast_app/presentation/weather_screen.dart';
import 'package:weather_forecast_app/presentation/blocs/weather_bloc.dart';
import 'package:weather_forecast_app/data/weather_data_provider.dart';
import 'package:weather_forecast_app/data/weather_repository_impl.dart';

void main() {
  final weatherDataProvider = WeatherDataProvider();
  final weatherRepository = WeatherRepositoryImpl(weatherDataProvider: weatherDataProvider);
  final weatherBloc = WeatherBloc(weatherRepository: weatherRepository);

  runApp(
    MaterialApp(
      home: BlocProvider(
        create: (context) => weatherBloc,
        child: WeatherScreen(),
      ),
    ),
  );
}