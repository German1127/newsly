/// Helper and utility functions.
import 'package:intl/intl.dart';

/// Formats an ISO 8601 date string from the API into a readable format.
/// Example: "2023-01-01T12:00:00Z" -> "01/Jan/2023 12:00"
String formatArticleDate(String? dateString) {
  if (dateString == null) {
    return 'Fecha desconocida';
  }
  try {
    final dateTime = DateTime.parse(dateString);
    // Using 'es_ES' locale for Spanish month abbreviations.
    return DateFormat('dd/MMM/yyyy HH:mm', 'es_ES').format(dateTime);
  } catch (e) {
    // In case the date format is incorrect.
    return 'Fecha inválida';
  }
}