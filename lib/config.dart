/// Pega aquí tus API keys gratuitas (sin espacios, dentro de las comillas).
///
/// TMDB:            https://www.themoviedb.org  → Ajustes → API → "Clave de la API" (v3)
/// OpenWeatherMap:  https://openweathermap.org  → My API keys
const tmdbApiKey = 'Se_las_quite';
const openWeatherApiKey = 'Se_las_quite';

bool faltaLlave(String llave) => llave.startsWith('PEGA_AQUI') || llave.trim().isEmpty;
