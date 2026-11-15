class Clima {
  final String ciudad;
  final double temperatura;
  final double sensacion;
  final int humedad;
  final String descripcion;
  final String icono;
  final double vientoMs;

  const Clima({
    required this.ciudad,
    required this.temperatura,
    required this.sensacion,
    required this.humedad,
    required this.descripcion,
    required this.icono,
    required this.vientoMs,
  });

  factory Clima.fromJson(Map<String, dynamic> json) {
    final main = json['main'] as Map<String, dynamic>;
    final weather = (json['weather'] as List<dynamic>).first as Map<String, dynamic>;
    final wind = json['wind'] as Map<String, dynamic>;
    return Clima(
      ciudad: json['name'] as String,
      temperatura: (main['temp'] as num).toDouble(),
      sensacion: (main['feels_like'] as num).toDouble(),
      humedad: (main['humidity'] as num).toInt(),
      descripcion: weather['description'] as String,
      icono: weather['icon'] as String,
      vientoMs: ((wind['speed'] ?? 0) as num).toDouble(),
    );
  }

  String get urlIcono => 'https://openweathermap.org/img/wn/$icono@4x.png';

  /// "nubes dispersas" → "Nubes dispersas"
  String get descripcionBonita =>
      descripcion.isEmpty ? '' : descripcion[0].toUpperCase() + descripcion.substring(1);

  /// La API da el viento en m/s; lo mostramos en km/h.
  double get vientoKmh => vientoMs * 3.6;
}
