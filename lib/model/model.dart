class Weather {
  // Define properties for the Weather class
  final String cityName;
  final double temperature;
  final String condition;
  final String icon;
  final int humidity;
  final double windSpeed;

  // Constructor to initialize the properties
  Weather({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
  });

  // Factory constructor to create a Weather instance from JSON data
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      // Extract city name from the JSON
      cityName: json['name'],
      // Extract temperature from the JSON
      temperature: json['main']['temp'],
      // Extract weather condition description from the JSON,,0 representthe 1st index of the list
      condition: json['weather'][0]['description'],
      // Extract weather icon from the JSON,0 representthe 1st index of the list
      icon: json['weather'][0]['icon'],
      // Extract humidity from the JSON
      humidity: json['main']['humidity'],
      // Extract wind speed from the JSON
      windSpeed: json['wind']['speed'],
    );
  }
}
