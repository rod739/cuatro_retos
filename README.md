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


## Capturas

## Menú principal


## Reto 1 · Recomendador de Películas
<img width="728" height="1600" alt="WhatsApp Image 2026-11-15 at 4 47 06 PM (1)" src="https://github.com/user-attachments/assets/cedd82c3-2642-47c1-b914-ab684444c60e" />

<img width="728" height="1600" alt="WhatsApp Image 2026-11-15 at 4 47 07 PM" src="https://github.com/user-attachments/assets/25570ff5-92ab-4e87-85da-618d52cea02e" />

## Reto 2 · Memes de Gatos con Filtros
<img width="728" height="1600" alt="WhatsApp Image 2026-11-15 at 4 47 09 PM" src="https://github.com/user-attachments/assets/caa2b981-0bc6-45cc-b57c-3b9822375d59" />

## con texto
<img width="728" height="1600" alt="WhatsApp Image 2026-11-15 at 4 47 09 PM (1)" src="https://github.com/user-attachments/assets/0d0c6f5f-7d95-4550-b5ba-8844dcbad243" />

## con filtro
<img width="728" height="1600" alt="WhatsApp Image 2026-11-15 at 4 47 09 PM (2)" src="https://github.com/user-attachments/assets/26148678-cb07-49a7-9b76-0857cdb98778" />

## Reto 3 · Clima Minimalista
<img width="728" height="1600" alt="WhatsApp Image 2026-11-15 at 4 47 10 PM" src="https://github.com/user-attachments/assets/c04ad8ed-9cd0-4420-a277-e191184dd0b1" />

## otra ciudad
<img width="728" height="1600" alt="WhatsApp Image 2026-11-15 at 4 47 11 PM" src="https://github.com/user-attachments/assets/40d4a620-c6dd-441f-96a5-8d90a2c8967f" />

## ubicación actual
<img width="728" height="1600" alt="WhatsApp Image 2026-11-15 at 4 47 11 PM (1)" src="https://github.com/user-attachments/assets/66e48875-7f35-472d-9de7-7c1fbe1a63eb" />

## Ciudad no encontrada
<img width="1080" height="2372" alt="WhatsApp Image 2026-11-15 at 4 47 12 PM" src="https://github.com/user-attachments/assets/894d3385-d6ec-4611-97ab-b7ecc30e967d" />

## Reto 4 · Convertidor de Criptomonedas
<img width="728" height="1600" alt="WhatsApp Image 2026-11-15 at 4 47 12 PM (1)" src="https://github.com/user-attachments/assets/95fb756a-2e89-4595-a680-0c98d69f2836" />

## con otra cantidad
<img width="728" height="1600" alt="WhatsApp Image 2026-11-15 at 4 47 12 PM (2)" src="https://github.com/user-attachments/assets/9b2aa055-02a6-4759-ac5d-a67848838433" />

## sin cantidad
<img width="728" height="1600" alt="WhatsApp Image 2026-11-15 at 4 47 13 PM" src="https://github.com/user-attachments/assets/0eb65382-3dea-4dd9-8fdb-4d2b5cb98692" />
