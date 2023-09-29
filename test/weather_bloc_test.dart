import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_forecast_app/core/models/weather.dart';
import 'package:weather_forecast_app/core/repository/weather_repository.dart';
import 'package:weather_forecast_app/presentation/blocs/weather_bloc.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  group('WeatherBloc Integration Test', () {
    late WeatherBloc weatherBloc;
    late WeatherRepository mockRepository;

    setUp(() {
      mockRepository = MockWeatherRepository();
      weatherBloc = WeatherBloc(weatherRepository: mockRepository);
    });

    test('Fetching weather data', () async {
      final mockWeather = Weather(
        temperature: 20.0,
        weatherDescription: 'Clear',
        humidity: 70,
        windSpeed: 10.0,
        city: 'Test City',
      );

      final mockFiveDayForecast = [
        Weather(
          temperature: 25.0,
          weatherDescription: 'Sunny',
          humidity: 60,
          windSpeed: 12.0,
          city: 'Test City',
        ),
        // Add more mock data as needed
      ];

      when(mockRepository.getCurrentWeather(""))
          .thenAnswer((_) => Future.value(mockWeather));
      when(mockRepository.getFiveDayForecast(""))
          .thenAnswer((_) => Future.value(mockFiveDayForecast));

      // Dispatch an event to trigger fetching weather data
      weatherBloc.add(GetWeather('Test Location'));

      await expectLater(
        weatherBloc.stream,
        emitsInOrder([
          WeatherLoading(),
          WeatherLoaded(mockWeather, mockFiveDayForecast),
        ]),
      );
    });
  });
}