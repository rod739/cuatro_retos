import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../comun.dart';
import 'clima.dart';
import 'servicio_clima.dart';

class PantallaClima extends StatefulWidget {
  const PantallaClima({super.key});
  @override
  State<PantallaClima> createState() => _PantallaClimaState();
}

class _PantallaClimaState extends State<PantallaClima> {
  final _servicio = ServicioClima();
  final _ciudad = TextEditingController(text: 'Dolores Hidalgo');
  bool _cargando = false;
  Clima? _clima;
  String? _error;

  @override
  void initState() {
    super.initState();
    _buscarCiudad();
  }

  @override
  void dispose() {
    _ciudad.dispose();
    super.dispose();
  }

  Future<void> _ejecutar(Future<Clima> Function() consulta) async {
    FocusManager.instance.primaryFocus?.unfocus(); // cierra el teclado
    setState(() {
      _cargando = true;
      _error = null;
    });
    try {
      final clima = await consulta();
      if (!mounted) return;
      setState(() {
        _clima = clima;
        _cargando = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = mensajeDeError(e);
        _cargando = false;
      });
    }
  }

  void _buscarCiudad() {
    final texto = _ciudad.text.trim();
    if (texto.isEmpty) return;
    _ejecutar(() => _servicio.porCiudad(texto));
  }

  /// "Plus" del reto: detectar la ubicación con geolocator.
  void _usarUbicacion() {
    _ejecutar(() async {
      if (!await Geolocator.isLocationServiceEnabled()) {
        throw Exception('Activa la ubicación (GPS) de tu celular.');
      }
      var permiso = await Geolocator.checkPermission();
      if (permiso == LocationPermission.denied) {
        permiso = await Geolocator.requestPermission();
      }
      if (permiso == LocationPermission.denied || permiso == LocationPermission.deniedForever) {
        throw Exception('Necesito el permiso de ubicación para detectar tu ciudad.');
      }
      final posicion = await Geolocator.getCurrentPosition();
      return _servicio.porCoordenadas(posicion.latitude, posicion.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clima Minimalista')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        TextField(
          controller: _ciudad,
          textInputAction: TextInputAction.search,
          onSubmitted: (_) => _buscarCiudad(),
          decoration: InputDecoration(
            labelText: 'Ciudad',
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(icon: const Icon(Icons.search), onPressed: _buscarCiudad),
          ),
        ),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: _cargando ? null : _usarUbicacion,
          icon: const Icon(Icons.my_location),
          label: const Text('Usar mi ubicación'),
        ),
        const SizedBox(height: 32),
        _contenido(context),
      ]),
    );
  }

  Widget _contenido(BuildContext context) {
    if (_cargando) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Text(_error!, textAlign: TextAlign.center, style: const TextStyle(color: Colors.red));
    }
    final c = _clima;
    if (c == null) return const SizedBox.shrink();
    return Column(children: [
      Text(c.ciudad, style: Theme.of(context).textTheme.headlineMedium),
      Image.network(c.urlIcono,
          width: 140, height: 140, errorBuilder: (_, __, ___) => const SizedBox(height: 140)),
      Text('${c.temperatura.round()}°C',
          style: const TextStyle(fontSize: 72, fontWeight: FontWeight.w300)),
      Text(c.descripcionBonita, style: const TextStyle(fontSize: 20)),
      const SizedBox(height: 24),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        _Dato(icono: Icons.thermostat, valor: '${c.sensacion.round()}°C', etiqueta: 'Sensación'),
        _Dato(icono: Icons.water_drop, valor: '${c.humedad}%', etiqueta: 'Humedad'),
        _Dato(icono: Icons.air, valor: '${c.vientoKmh.round()} km/h', etiqueta: 'Viento'),
      ]),
    ]);
  }
}

class _Dato extends StatelessWidget {
  final IconData icono;
  final String valor;
  final String etiqueta;
  const _Dato({required this.icono, required this.valor, required this.etiqueta});

  @override
  Widget build(BuildContext context) => Column(children: [
        Icon(icono),
        const SizedBox(height: 4),
        Text(valor, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(etiqueta),
      ]);
}
