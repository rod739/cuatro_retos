import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../config.dart';
import 'clima.dart';

/// Consulta el clima actual en la API de OpenWeatherMap.
class ServicioClima {
  Future<Clima> porCiudad(String ciudad) => _consultar({'q': ciudad});

  Future<Clima> porCoordenadas(double lat, double lon) =>
      _consultar({'lat': '$lat', 'lon': '$lon'});

  Future<Clima> _consultar(Map<String, String> parametros) async {
    if (faltaLlave(openWeatherApiKey)) {
      throw Exception('Falta tu API key de OpenWeatherMap. Pégala en lib/config.dart');
    }
    final uri = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
      ...parametros,
      'appid': openWeatherApiKey,
      'units': 'metric', // grados Celsius
      'lang': 'es',
    });
    final respuesta = await http.get(uri).timeout(const Duration(seconds: 15));
    if (respuesta.statusCode == 401) {
      throw Exception('API key de OpenWeatherMap inválida o todavía no activa '
          '(una key nueva puede tardar hasta 2 horas en funcionar).');
    }
    if (respuesta.statusCode == 404) {
      throw Exception('No encontré esa ciudad. Revisa cómo la escribiste.');
    }
    if (respuesta.statusCode != 200) {
      throw Exception('OpenWeatherMap respondió con error ${respuesta.statusCode}');
    }
    return Clima.fromJson(jsonDecode(respuesta.body) as Map<String, dynamic>);
  }
}
