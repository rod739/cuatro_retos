/// Filtros que ofrece la API de Cataas (null = sin filtro).
const filtrosGato = <String?, String>{
  null: 'Sin filtro',
  'mono': 'Blanco y negro',
  'negate': 'Negativo',
  'blur': 'Desenfocado',
};

/// Construye la URL dinámica de Cataas.
///  - Sin texto:  https://cataas.com/cat?...
///  - Con texto:  https://cataas.com/cat/says/<texto>?fontSize=..&fontColor=..
/// [semilla] cambia en cada gato nuevo para que la app no reutilice la imagen guardada.
String urlGato({required String texto, String? filtro, required int semilla}) {
  final frase = texto.trim();
  final ruta = frase.isEmpty ? '/cat' : '/cat/says/${Uri.encodeComponent(frase)}';
  final parametros = <String, String>{
    if (frase.isNotEmpty) 'fontSize': '40',
    if (frase.isNotEmpty) 'fontColor': 'white',
    if (filtro != null) 'filter': filtro,
    'semilla': '$semilla',
  };
  final consulta = parametros.entries
      .map((e) => '${e.key}=${Uri.encodeQueryComponent(e.value)}')
      .join('&');
  return 'https://cataas.com$ruta?$consulta';
}
