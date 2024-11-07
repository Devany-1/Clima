import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  static final _storage = FlutterSecureStorage();

  // Guarda la API Key de manera segura
  static Future<void> storeApiKey(String apiKey) async {
    await _storage.write(key: 'apiKey', value: apiKey);
  }

  // Lee la API Key del almacenamiento seguro
  static Future<String?> getApiKey() async {
    return await _storage.read(key: 'apiKey');
  }

  // Obtiene el clima de una ciudad específica
  static Future<Map<String, dynamic>> fetchWeather(String city) async {
    final apiKey = await getApiKey();
    if (apiKey == null) {
      throw Exception('API Key no encontrada');
    }

    // Construye la URL de la API
    final url = '$_baseUrl?q=${Uri.encodeComponent(city)}&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Error en la respuesta: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error al obtener el clima: $error');
    }
  }
}
