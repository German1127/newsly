import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app.dart';
import 'locator.dart';

/// Main entry point of the application.
Future<void> main() async {
  // Ensure Flutter is initialized before running the app.
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set up the service locator for dependency injection.
  setupLocator();
  
  await dotenv.load(fileName: ".env");
  // Run the main application widget.
  runApp(const NewsApp());
}