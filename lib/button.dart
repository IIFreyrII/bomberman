import 'package:flutter/material.dart';

/// `MyButton` es un widget personalizado que representa un botón con propiedades personalizables.
/// Este botón puede tener un color de fondo, un widget hijo (como un icono o texto), y una función
/// que se ejecuta cuando se presiona el botón.

class MyButton extends StatelessWidget {

  /// El color de fondo del botón.
  final color;

  /// El widget hijo que se mostrará dentro del botón, como un icono o texto.
  final child;

  /// La función que se ejecutará cuando el botón sea presionado.
  final function;

  /// Constructor de `MyButton`.
  ///
  /// [key]: La clave que identifica este widget en el árbol de widgets.
  /// [color]: El color de fondo del botón.
  /// [child]: El widget hijo que se mostrará dentro del botón.
  /// [function]: La función que se ejecutará cuando el botón sea presionado.
  const MyButton({super.key, this.color, this.child, this.function});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Añade un padding alrededor del botón.
      padding: const EdgeInsets.all(1.0),
      child: GestureDetector(
        // Detecta el gesto de tap (toque) en el botón.
        onTap: function,
        child: ClipRRect(
          // Recorta los bordes del contenedor con un radio de 8.
          borderRadius: BorderRadius.circular(8),
          child: Container(
            // Define el color de fondo del contenedor.
            color: color,
            // Define la altura del contenedor.
            height: 70,
            // Define el ancho del contenedor.
            width: 70,
            // Centra el widget hijo dentro del contenedor.
            child: Center(child: child,),
          ),
        ),
      ),
    );
  }
}