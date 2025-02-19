import 'package:flutter/material.dart';

/// `MyPixel` es un widget personalizado que representa un "píxel" o celda en un grid.
/// Este widget es altamente personalizable, permitiendo definir colores internos y externos,
/// así como un widget hijo que se muestra en el centro.
class MyPixel extends StatelessWidget {
  /// Color interno del píxel.
  final innerColor;

  /// Color externo del píxel.
  final outerColor;

  /// Widget hijo que se muestra en el centro del píxel (opcional).
  final child;

  /// Constructor de `MyPixel`.
  ///
  /// [key]: La clave que identifica este widget en el árbol de widgets.
  /// [innerColor]: El color interno del píxel.
  /// [outerColor]: El color externo del píxel.
  /// [child]: El widget hijo que se mostrará en el centro del píxel.
  const MyPixel({super.key, this.innerColor, this.child, this.outerColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Añade un padding alrededor del píxel.
      padding: const EdgeInsets.all(2.0),
      child: ClipRRect(
        // Recorta los bordes del contenedor externo con un radio de 6.
        borderRadius: BorderRadius.circular(6),
        child: Container(
          // Añade un padding interno al contenedor externo.
          padding: EdgeInsets.all(5),
          // Define el color del contenedor externo.
          color: outerColor,
          child: ClipRRect(
            // Recorta los bordes del contenedor interno con un radio de 10.
            borderRadius: BorderRadius.circular(10),
            child: Container(
              // Define el color del contenedor interno.
              color: innerColor,
              // Centra el widget hijo dentro del contenedor interno.
              child: Center(
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
