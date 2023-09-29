import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_forecast_app/core/models/weather.dart';
import 'package:weather_forecast_app/core/repository/weather_repository.dart';
import 'package:geolocator/geolocator.dart';
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({required this.weatherRepository}) : super(WeatherInitial()) {
    on<GetWeather>(_onGetWeatherTapped);
  }

  FutureOr<void> _onGetWeatherTapped(
      GetWeather event, Emitter<WeatherState> emit) async {
    try {
      emit(WeatherLoading());
      Weather currentWeather;
      List<Weather> fiveDayForecast;
      if (event.location.isEmpty) {
        final position = await _determinePosition();
        currentWeather = await weatherRepository.getCurrentWeatherByLocation(
            position.latitude, position.longitude);
        fiveDayForecast = await weatherRepository.getFiveDayForecastByLocation(
            position.latitude, position.longitude);
      } else {
        currentWeather =
            await weatherRepository.getCurrentWeather(event.location);
        fiveDayForecast =
            await weatherRepository.getFiveDayForecast(event.location);
      }

      emit(WeatherLoaded(currentWeather, fiveDayForecast));
    } catch (e) {
      emit(WeatherError('Failed to fetch weather data'));
    }
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}

