import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/provider/provider.dart';
import 'package:weather/screens/weatherscreen.dart';

class HomeScreen extends StatelessWidget {
  // Controller to handle the input from the text field
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weather App',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image for the app
          Image.asset(
            'lib/assets/bg1.jpeg',
            fit: BoxFit.cover,
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 100.0, left: 20, right: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // TextField to enter the city name
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          labelText: 'City name',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 1, 9, 23)),
                          hintText: 'Enter city name',
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Button to search for the weather
                    ElevatedButton(
                      onPressed: () {
                        final city = _controller.text;
                        if (city.isNotEmpty) {
                          // Fetch the weather for the entered city
                          Provider.of<WeatherProvider>(context, listen: false)
                              .fetchWeather(city);
                        }
                      },
                      child: Text(
                        'Search',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.purple),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 30.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Displaying the weather details or loading/error messages
                    Consumer<WeatherProvider>(
                      builder: (context, weatherProvider, child) {
                        if (weatherProvider.isLoading) {
                          // Show a loading spinner while fetching data
                          return CircularProgressIndicator();
                        } else if (weatherProvider.weather != null) {
                          // Show button to view weather details if data is available
                          return ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WeatherScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'View Weather Details',
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                        } else if (weatherProvider.errorMessage.isNotEmpty) {
                          // Show error message if there's an error
                          return Text(
                            weatherProvider.errorMessage,
                            style: TextStyle(color: Colors.red),
                          );
                        } else {
                          // Show nothing if no data or error
                          return Container();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
