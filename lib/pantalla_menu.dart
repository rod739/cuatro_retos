import 'package:flutter/material.dart';

import 'retos/clima/pantalla_clima.dart';
import 'retos/cripto/pantalla_cripto.dart';
import 'retos/gatos/pantalla_gatos.dart';
import 'retos/peliculas/pantalla_peliculas.dart';

class PantallaMenu extends StatelessWidget {
  const PantallaMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Los Cuatro Retos')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: const [
          _TarjetaReto(
            emoji: '🚀',
            titulo: 'Reto 1 · Recomendador de Películas',
            subtitulo: 'Películas según tu estado de ánimo (TMDB)',
            destino: PantallaPeliculas(),
          ),
          _TarjetaReto(
            emoji: '🐱',
            titulo: 'Reto 2 · Memes de Gatos con Filtros',
            subtitulo: 'Escribe una frase sobre un gato (Cataas)',
            destino: PantallaGatos(),
          ),
          _TarjetaReto(
            emoji: '🌦️',
            titulo: 'Reto 3 · Clima Minimalista',
            subtitulo: 'El clima actual de tu ciudad (OpenWeatherMap)',
            destino: PantallaClima(),
          ),
          _TarjetaReto(
            emoji: '🪙',
            titulo: 'Reto 4 · Convertidor de Criptomonedas',
            subtitulo: 'Bitcoin, Ethereum y Solana en USD (CoinGecko)',
            destino: PantallaCripto(),
          ),
        ],
      ),
    );
  }
}

class _TarjetaReto extends StatelessWidget {
  final String emoji;
  final String titulo;
  final String subtitulo;
  final Widget destino;

  const _TarjetaReto({
    required this.emoji,
    required this.titulo,
    required this.subtitulo,
    required this.destino,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Text(emoji, style: const TextStyle(fontSize: 36)),
        title: Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitulo),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute<void>(builder: (_) => destino),
        ),
      ),
    );
  }
}
