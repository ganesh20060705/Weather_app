import "dart:convert";
import 'package:http/http.dart' as http;

class WeatherService {
  // API key for OpenWeatherMap API
  static const String apiKey = "287f18946f9b2917403c4a9ded22d110";
  // Base URL for OpenWeatherMap API
  static const String apiUrl = "https://api.openweathermap.org/data/2.5/weather";

  // Method to fetch weather data for a given city
  Future<Map<String, dynamic>> fetchWeather(String city) async {
    // Construct the URL with the city name and API key
    final response = await http.get(Uri.parse('$apiUrl?q=$city&appid=$apiKey&units=metric'));

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Decode the JSON response and return it as a map
      return json.decode(response.body);
    } else {
      
      throw Exception('Failed to load weather data');
    }
  }
}
