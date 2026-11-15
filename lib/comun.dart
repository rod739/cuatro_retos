import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

/// Convierte cualquier error en un mensaje entendible para el usuario.
String mensajeDeError(Object e) {
  if (e is SocketException || e is http.ClientException) {
    return 'No hay conexión a internet. Revisa tu Wi-Fi o datos.';
  }
  if (e is TimeoutException) return 'La consulta tardó demasiado. Intenta de nuevo.';
  return e.toString().replaceFirst('Exception: ', '');
}

/// 1234567.891 → "1,234,567.89" (con los decimales que pidas).
String conComas(double valor, int decimales) {
  final partes = valor.toStringAsFixed(decimales).split('.');
  final entero = partes[0].replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => ',');
  return partes.length > 1 ? '$entero.${partes[1]}' : entero;
}
