import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../config.dart';
import 'pelicula.dart';

/// Trae películas de la API de TMDB (The Movie Database).
class ServicioPeliculas {
  Future<List<Pelicula>> obtener(Animo animo) async {
    if (faltaLlave(tmdbApiKey)) {
      throw Exception('Falta tu API key de TMDB. Pégala en lib/config.dart');
    }
    final uri = animo.generoId == null
        ? Uri.https('api.themoviedb.org', '/3/trending/movie/week', {
            'api_key': tmdbApiKey,
            'language': 'es-MX',
          })
        : Uri.https('api.themoviedb.org', '/3/discover/movie', {
            'api_key': tmdbApiKey,
            'language': 'es-MX',
            'with_genres': '${animo.generoId}',
            'sort_by': 'popularity.desc',
          });

    final respuesta = await http.get(uri).timeout(const Duration(seconds: 15));
    if (respuesta.statusCode == 401) {
      throw Exception('Tu API key de TMDB no es válida. Revisa lib/config.dart');
    }
    if (respuesta.statusCode != 200) {
      throw Exception('TMDB respondió con error ${respuesta.statusCode}');
    }
    final json = jsonDecode(respuesta.body) as Map<String, dynamic>;
    final resultados = json['results'] as List<dynamic>;
    return resultados.map((e) => Pelicula.fromJson(e as Map<String, dynamic>)).toList();
  }
}
