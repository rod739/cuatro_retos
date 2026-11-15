import 'dart:convert';

import 'package:http/http.dart' as http;

/// Criptomonedas del reto: (id en CoinGecko, nombre, símbolo).
const monedas = <(String, String, String)>[
  ('bitcoin', 'Bitcoin', 'BTC'),
  ('ethereum', 'Ethereum', 'ETH'),
  ('solana', 'Solana', 'SOL'),
];

/// Consulta precios en la API pública de CoinGecko (sin autenticación).
class ServicioCripto {
  /// Devuelve {'bitcoin': 97000.0, 'ethereum': 3500.0, 'solana': 180.0}
  Future<Map<String, double>> obtenerPrecios() async {
    final uri = Uri.https('api.coingecko.com', '/api/v3/simple/price', {
      'ids': monedas.map((m) => m.$1).join(','),
      'vs_currencies': 'usd',
    });
    final respuesta = await http.get(uri).timeout(const Duration(seconds: 15));
    if (respuesta.statusCode == 429) {
      throw Exception('CoinGecko recibió demasiadas consultas. '
          'Espera un minuto y vuelve a intentar.');
    }
    if (respuesta.statusCode != 200) {
      throw Exception('CoinGecko respondió con error ${respuesta.statusCode}');
    }
    final json = jsonDecode(respuesta.body) as Map<String, dynamic>;
    return {
      for (final m in monedas)
        m.$1: ((json[m.$1] as Map<String, dynamic>)['usd'] as num).toDouble(),
    };
  }
}
