import 'package:flutter/material.dart';

import '../../comun.dart';
import 'servicio_cripto.dart';

class PantallaCripto extends StatefulWidget {
  const PantallaCripto({super.key});
  @override
  State<PantallaCripto> createState() => _PantallaCriptoState();
}

class _PantallaCriptoState extends State<PantallaCripto> {
  final _servicio = ServicioCripto();
  final _monto = TextEditingController(text: '100');
  late Future<Map<String, double>> _futuro;

  @override
  void initState() {
    super.initState();
    _futuro = _servicio.obtenerPrecios();
  }

  @override
  void dispose() {
    _monto.dispose();
    super.dispose();
  }

  void _actualizar() => setState(() => _futuro = _servicio.obtenerPrecios());

  /// El monto que escribió el usuario, o null si no es un número válido.
  double? get _montoUsd {
    final valor = double.tryParse(_monto.text.replaceAll(',', '').trim());
    return (valor == null || valor < 0) ? null : valor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Convertidor de Cripto'),
        actions: [
          IconButton(
            tooltip: 'Actualizar precios',
            icon: const Icon(Icons.refresh),
            onPressed: _actualizar,
          ),
        ],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _monto,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) => setState(() {}), // recalcula al instante
            decoration: InputDecoration(
              labelText: 'Monto en dólares (USD)',
              prefixText: '\$ ',
              border: const OutlineInputBorder(),
              errorText: _montoUsd == null ? 'Escribe un monto válido' : null,
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder<Map<String, double>>(
            future: _futuro,
            builder: (context, snap) {
              if (snap.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snap.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Text(mensajeDeError(snap.error!), textAlign: TextAlign.center),
                      const SizedBox(height: 12),
                      FilledButton(onPressed: _actualizar, child: const Text('Reintentar')),
                    ]),
                  ),
                );
              }
              final precios = snap.data!;
              final monto = _montoUsd;
              return ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  children: [
                    for (final (id, nombre, simbolo) in monedas)
                      Card(
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: CircleAvatar(child: Text(simbolo, style: const TextStyle(fontSize: 11))),
                          title: Text(nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
                          isThreeLine: true,
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('1 $simbolo = \$${conComas(precios[id]!, 2)} USD'),
                              const SizedBox(height: 4),
                              Text(
                                monto == null
                                    ? 'Escribe un monto para calcular'
                                    : 'Con \$${conComas(monto, 2)} compras: '
                                        '${(monto / precios[id]!).toStringAsFixed(8)} $simbolo',
                                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
              );
            },
          ),
        ),
      ]),
    );
  }
}
