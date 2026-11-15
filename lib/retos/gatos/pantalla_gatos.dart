import 'package:flutter/material.dart';

import 'url_gatos.dart';

class PantallaGatos extends StatefulWidget {
  const PantallaGatos({super.key});
  @override
  State<PantallaGatos> createState() => _PantallaGatosState();
}

class _PantallaGatosState extends State<PantallaGatos> {
  final _frase = TextEditingController();
  String _textoAplicado = '';
  String? _filtro;
  int _semilla = DateTime.now().millisecondsSinceEpoch;

  String get _url => urlGato(texto: _textoAplicado, filtro: _filtro, semilla: _semilla);

  void _nuevoGato() {
    FocusManager.instance.primaryFocus?.unfocus(); // cierra el teclado
    setState(() {
      _textoAplicado = _frase.text;
      _semilla = DateTime.now().millisecondsSinceEpoch;
    });
  }

  @override
  void dispose() {
    _frase.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Memes de Gatos')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        TextField(
          controller: _frase,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _nuevoGato(),
          decoration: const InputDecoration(
            labelText: 'Escribe tu frase',
            hintText: 'Ej. Cuando es lunes',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String?>(
          value: _filtro,
          decoration: const InputDecoration(labelText: 'Filtro', border: OutlineInputBorder()),
          items: [
            for (final f in filtrosGato.entries)
              DropdownMenuItem<String?>(value: f.key, child: Text(f.value)),
          ],
          onChanged: (f) => setState(() => _filtro = f),
        ),
        const SizedBox(height: 12),
        FilledButton.icon(
          onPressed: _nuevoGato,
          icon: const Icon(Icons.pets),
          label: const Text('Generar meme'),
        ),
        const SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            _url,
            key: ValueKey(_url),
            fit: BoxFit.contain,
            loadingBuilder: (_, hijo, progreso) => progreso == null
                ? hijo
                : const SizedBox(height: 300, child: Center(child: CircularProgressIndicator())),
            errorBuilder: (_, __, ___) => const SizedBox(
              height: 200,
              child: Center(child: Text('No se pudo cargar el gato. Revisa tu internet.')),
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Text('URL que se envió a la API:', style: TextStyle(fontWeight: FontWeight.bold)),
        SelectableText(_url, style: const TextStyle(fontSize: 12)),
      ]),
    );
  }
}
