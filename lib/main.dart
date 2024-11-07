import 'package:flutter/material.dart';
import 'screens/weather_screen.dart';
import 'services/weather_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await saveApiKey(); // Guardar la API Key
  runApp(MyApp());
}

// Almacena la API Key una sola vez
Future<void> saveApiKey() async {
  // Reemplaza 'TU_API_KEY' con tu clave de OpenWeatherMap
  const apiKey = 'a39ccb03f98e098f80b1c657efb1150f';
  final existingKey = await WeatherService.getApiKey();

  if (existingKey == null) {
    await WeatherService.storeApiKey(apiKey);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Consulta del Clima',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: WeatherScreen(),
    );
  }
}
