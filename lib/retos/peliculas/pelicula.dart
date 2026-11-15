class Pelicula {
  final String titulo;
  final String resumen;
  final String? poster;
  final double calificacion;
  final String fecha;

  const Pelicula({
    required this.titulo,
    required this.resumen,
    required this.poster,
    required this.calificacion,
    required this.fecha,
  });

  factory Pelicula.fromJson(Map<String, dynamic> json) => Pelicula(
        titulo: (json['title'] ?? 'Sin título') as String,
        resumen: (json['overview'] ?? '') as String,
        poster: json['poster_path'] as String?,
        calificacion: ((json['vote_average'] ?? 0) as num).toDouble(),
        fecha: (json['release_date'] ?? '') as String,
      );

  String? get urlPoster => poster == null ? null : 'https://image.tmdb.org/t/p/w342$poster';

  String get anio => fecha.length >= 4 ? fecha.substring(0, 4) : '';
}

/// Estado de ánimo → género de TMDB. Si generoId es null, se piden las tendencias.
class Animo {
  final String etiqueta;
  final int? generoId;
  const Animo(this.etiqueta, this.generoId);
}

const animos = <Animo>[
  Animo('🔥 Tendencias', null),
  Animo('😄 Feliz', 35), // Comedia
  Animo('😢 Triste', 18), // Drama
  Animo('😍 Romántico', 10749), // Romance
  Animo('😱 Con miedo', 27), // Terror
  Animo('🤩 Aventurero', 12), // Aventura
  Animo('💥 Con adrenalina', 28), // Acción
];
