import 'dart:math';

import 'package:flutter/material.dart';

import '../../comun.dart';
import 'pelicula.dart';
import 'servicio_peliculas.dart';

class PantallaPeliculas extends StatefulWidget {
  const PantallaPeliculas({super.key});
  @override
  State<PantallaPeliculas> createState() => _PantallaPeliculasState();
}

class _PantallaPeliculasState extends State<PantallaPeliculas> {
  final _servicio = ServicioPeliculas();
  Animo _animo = animos.first;
  late Future<List<Pelicula>> _futuro;
  List<Pelicula> _peliculas = [];

  @override
  void initState() {
    super.initState();
    _cargar();
  }

  void _cargar() {
    _peliculas = [];
    _futuro = _servicio.obtener(_animo).then((lista) {
      _peliculas = lista;
      return lista;
    });
  }

  void _alAzar() {
    if (_peliculas.isEmpty) return;
    final p = _peliculas[Random().nextInt(_peliculas.length)];
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('🎲 Tu película para el fin de semana'),
        content: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            if (p.urlPoster != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(p.urlPoster!, height: 260),
              ),
            const SizedBox(height: 12),
            Text(p.titulo,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('⭐ ${p.calificacion.toStringAsFixed(1)}   ${p.anio}'),
            const SizedBox(height: 8),
            Text(p.resumen.isEmpty ? 'Sin descripción en español.' : p.resumen),
          ]),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cerrar')),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              _alAzar();
            },
            child: const Text('Otra'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recomendador de Películas')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _alAzar,
        icon: const Icon(Icons.casino),
        label: const Text('Película al azar'),
      ),
      body: Column(children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
          child: Text('¿Cómo te sientes hoy?', style: TextStyle(fontSize: 16)),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            spacing: 6,
            runSpacing: 6,
            alignment: WrapAlignment.center,
            children: [
              for (final a in animos)
                ChoiceChip(
                  label: Text(a.etiqueta),
                  selected: a == _animo,
                  onSelected: (_) => setState(() {
                    _animo = a;
                    _cargar();
                  }),
                ),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder<List<Pelicula>>(
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
                      FilledButton(
                        onPressed: () => setState(_cargar),
                        child: const Text('Reintentar'),
                      ),
                    ]),
                  ),
                );
              }
              final lista = snap.data!;
              if (lista.isEmpty) return const Center(child: Text('No se encontraron películas.'));
              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 88),
                itemCount: lista.length,
                itemBuilder: (_, i) => _TarjetaPelicula(pelicula: lista[i]),
              );
            },
          ),
        ),
      ]),
    );
  }
}

class _TarjetaPelicula extends StatelessWidget {
  final Pelicula pelicula;
  const _TarjetaPelicula({required this.pelicula});

  @override
  Widget build(BuildContext context) {
    final p = pelicula;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          width: 100,
          height: 150,
          child: p.urlPoster == null
              ? const ColoredBox(color: Colors.black12, child: Icon(Icons.movie, size: 40))
              : Image.network(
                  p.urlPoster!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 40),
                ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(p.titulo, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text('⭐ ${p.calificacion.toStringAsFixed(1)}   ${p.anio}'),
              const SizedBox(height: 6),
              Text(
                p.resumen.isEmpty ? 'Sin descripción en español.' : p.resumen,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}
