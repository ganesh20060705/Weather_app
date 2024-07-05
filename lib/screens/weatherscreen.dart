import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/provider/provider.dart';

class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve the weather provider from the context
    final weatherProvider = Provider.of<WeatherProvider>(context);
    // Get the current weather data from the provider
    final weather = weatherProvider.weather;

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Data'),
        actions: [
          // Refresh button to re-fetch the weather data
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              if (weather != null) {
                weatherProvider.fetchWeather(weather.cityName);
              }
            },
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image for the weather screen
          Image.asset(
            'lib/assets/bg2.jpg', 
            fit: BoxFit.cover,
          ),
          // Backdrop filter with blur effect
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: buildWeatherContent(weather),
          ),
        ],
      ),
    );
  }

  // Method to return the appropriate widget based on the weather data
  Widget buildWeatherContent(weather) {
    if (weather != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Display city name
            Text(
              weather.cityName,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 10),
            // Display temperature
            Text(
              '${weather.temperature}°C',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            SizedBox(height: 10),
            // Display weather condition
            Text(
              weather.condition,
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            SizedBox(height: 10),
            // Display weather icon
            Image.network(
              'http://openweathermap.org/img/wn/${weather.icon}@2x.png',
              scale: 0.5,
            ),
            SizedBox(height: 10),
            // Display humidity
            Text(
              'Humidity: ${weather.humidity}%',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            SizedBox(height: 10),
            // Display wind speed
            Text(
              'Wind Speed: ${weather.windSpeed} m/s',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: Text(
          'No weather data available', 
          style: TextStyle(color: Colors.white),
        ),
      );
    }
  }
}
