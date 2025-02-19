import 'package:flutter/material.dart';
import 'homepage.dart';

/// Punto de entrada de la aplicación.
/// Inicializa y ejecuta la aplicación Flutter.
void main() {
  // Ejecuta la aplicación con el widget `MainApp` como raíz.
  runApp(const MainApp());
}

/// `MainApp` es el widget raíz de la aplicación.
/// Configura el `MaterialApp` y define `HomePage` como la pantalla principal.
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Oculta la etiqueta de "Debug" en la esquina superior derecha.
      debugShowCheckedModeBanner: false,
      // Define `HomePage` como la pantalla principal de la aplicación.
      home: HomePage(),
    );
  }
}
