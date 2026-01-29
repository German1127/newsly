import 'package:intl/intl.dart';

String formatArticleDate(String? dateString) {
  if (dateString == null) {
    return 'Fecha desconocida';
  }
  try {
    final dateTime = DateTime.parse(dateString);
    return DateFormat('dd/MMM/yyyy HH:mm', 'es_ES').format(dateTime);
  } catch (e) {
    return 'Fecha inválida';
  }
}