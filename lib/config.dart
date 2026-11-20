/// Pega aquí tus API keys gratuitas (sin espacios, dentro de las comillas).
///
/// TMDB:            https://www.themoviedb.org  → Ajustes → API → "Clave de la API" (v3)
/// OpenWeatherMap:  https://openweathermap.org  → My API keys
const tmdbApiKey = 'a95afdac22b85d071f533a1b3701af73';
const openWeatherApiKey = 'fe1a5482afcc30a292c40fe076ebbd8c';

bool faltaLlave(String llave) => llave.startsWith('PEGA_AQUI') || llave.trim().isEmpty;
