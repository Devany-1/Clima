import 'package:flutter/material.dart';
import '../services/weather_service.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String city = '';
  Map<String, dynamic>? weatherData;

  Future<void> getWeather() async {
    try {
      final data = await WeatherService.fetchWeather(city);
      setState(() {
        weatherData = data;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Consulta del Clima')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Ingresa una ciudad'),
              onChanged: (value) => city = value,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: getWeather,
              child: Text('Consultar Clima'),
            ),
            if (weatherData != null) ...[
              SizedBox(height: 20),
              Text('Clima en $city:', style: TextStyle(fontSize: 20)),
              Text('Temperatura: ${weatherData!['main']['temp']} °C'),
              Text('Condiciones: ${weatherData!['weather'][0]['description']}'),
            ],
          ],
        ),
      ),
    );
  }
}
