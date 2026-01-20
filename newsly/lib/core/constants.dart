import 'package:flutter/material.dart';

/// API Key.
/// IMPORTANT: This is loaded from the .env file.
const String kApiKey = ''; 

/// Base URL for the News API.
const String kBaseUrl = 'https://newsapi.org/v2';

/// Endpoint for top headlines.
const String kTopHeadlinesPath = '/top-headlines';

/// Country code for headlines (e.g., 'us', 'ar', 'es').
const String kCountryCode = 'us';

/// Main Colors
const Color kPrimaryColor = Color(0xFF0F172A); // Dark Blue (Slate 900)
const Color kAccentColor = Color(0xFFE11D48); // Rose Red (Rose 600)
const Color kBackgroundColor = Color(0xFFF8FAFC); // Off-white (Slate 50)

/// Strings and Texts
const String kAppTitle = 'Noticias Globales';
const String kLoadingMessage = 'Cargando las últimas noticias...';
const String kErrorMessage = 'Ocurrió un error al cargar las noticias.';