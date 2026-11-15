# Los Cuatro Retos (cuatro_retos)

Una sola app con un menú que lleva a los 4 retos:
1. Recomendador de Películas (TMDB) · necesita API key
2. Memes de Gatos con Filtros (Cataas) · sin API key
3. Clima Minimalista (OpenWeatherMap + geolocator opcional) · necesita API key
4. Convertidor de Criptomonedas (CoinGecko) · sin API key

## Montarlo
1. `flutter create cuatro_retos`
2. Copia ENCIMA `lib/`, `pubspec.yaml` y `analysis_options.yaml`.
3. Borra `test/widget_test.dart`.
4. Permisos en `android/app/src/main/AndroidManifest.xml`, antes de `<application`:
   <uses-permission android:name="android.permission.INTERNET"/>
   <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
   <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
5. Pega tus API keys en `lib/config.dart`.
6. `flutter pub get` y `flutter run`.
