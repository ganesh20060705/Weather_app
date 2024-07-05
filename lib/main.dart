import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/provider/provider.dart'; // Import your WeatherProvider
import 'package:weather/screens/homescreen.dart'; // Import your HomeScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(), // Provide an instance of WeatherProvider
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(), // Set HomeScreen as the initial screen
      ),
    );
  }
}
