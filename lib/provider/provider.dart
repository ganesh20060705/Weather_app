import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/model/model.dart';
import 'package:weather/services/service.dart';

// WeatherProvider class to manage weather data and state
class WeatherProvider with ChangeNotifier {
  // Private variables to hold weather data, loading state, and error message
  Weather? _weather;
  bool _isLoading = false;
  String _errorMessage = '';

  // Public getters to access private variables
  Weather? get weather => _weather;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Method to fetch weather data for a given city
  Future<void> fetchWeather(String city) async {
    // Set loading state to true and notify listeners
    _isLoading = true;
    notifyListeners();

    try {
      // Fetch weather data from the WeatherService
      final weatherData = await WeatherService().fetchWeather(city);
      // Convert the fetched JSON data into a Weather object and assign it to the _weather variable
      _weather = Weather.fromJson(weatherData);
      // Save the last searched city to SharedPreferences
      _saveLastSearchedCity(city);
      // Clear any previous error messages
      _errorMessage = '';
    } catch (error) {
      // Handle any errors by setting _weather to null and updating the error message
      _weather = null;
      _errorMessage = 'Could not fetch weather data';
    } finally {
      // Set loading state to false and notify listeners
      _isLoading = false;
      notifyListeners();
    }
  }

  // Method to save the last searched city to SharedPreferences
  Future<void> _saveLastSearchedCity(String city) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastSearchedCity', city);
  }

  // Method to load the last searched city from SharedPreferences and fetch its weather data
  Future<void> loadLastSearchedCity() async {
    final prefs = await SharedPreferences.getInstance();
    final city = prefs.getString('lastSearchedCity');
    if (city != null) {
      await fetchWeather(city);
    }
  }
}
