import 'package:flutter/material.dart';
import 'package:weather_forecast_app/core/models/weather.dart';

class WeatherDisplay extends StatelessWidget {
  final Weather currentWeather;
  final List<Weather> fiveDayForecast;

  const WeatherDisplay({
    required this.currentWeather,
    required this.fiveDayForecast,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          Text(
          'Current City: ${currentWeather.city}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          'Current Temperature: ${currentWeather.temperature}°C',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text('Weather Description: ${currentWeather.weatherDescription}'),
        // Display other weather information as needed
        // Iterate through fiveDayForecast to display the 5-day forecast
        SizedBox(height: 20),
        Text(
          '5-Day Forecast:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Column(
          children: fiveDayForecast
              .map(
                (forecast) => SizedBox(
                  width: 230,
                  child: Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Temperature: ${forecast.temperature}°C',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('Description: ${forecast.weatherDescription}'),
                          // Display other forecast information as needed
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
