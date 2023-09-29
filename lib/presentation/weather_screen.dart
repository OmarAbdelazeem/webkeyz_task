import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast_app/presentation/blocs/weather_bloc.dart';
import 'package:weather_forecast_app/presentation/widgets/weather_display.dart';

class WeatherScreen extends StatefulWidget {
  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);

    final weatherVal = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Forecast App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter location (e.g., "Cairo")',
                  border: OutlineInputBorder(),
                ),
                onFieldSubmitted: (value) {
                  weatherBloc.add(GetWeather(value));
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  weatherBloc.add(GetWeather(weatherVal.text));
                  weatherVal.clear();
                },
                child: Text('Get Weather'),
              ),
              SizedBox(height: 20),
              BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherLoading) {
                    return CircularProgressIndicator();
                  } else if (state is WeatherLoaded) {
                    return WeatherDisplay(
                      currentWeather: state.currentWeather,
                      fiveDayForecast: state.fiveDayForecast,
                    );
                  } else if (state is WeatherError) {
                    return Text('Error: ${state.message}');
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
