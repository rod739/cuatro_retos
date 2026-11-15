import 'package:flutter/material.dart';

import 'pantalla_menu.dart';

void main() {
  runApp(MaterialApp(
    title: 'Los Cuatro Retos',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
    home: const PantallaMenu(),
  ));
}
