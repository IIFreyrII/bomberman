import 'dart:async';

import 'package:flutter/material.dart';
import 'button.dart';
import 'pixel.dart';

/// `HomePage` es un widget que representa la pantalla principal del juego.
/// Este juego consiste en un jugador que puede moverse en un grid y colocar bombas
/// que explotan después de un tiempo, eliminando cajas en el área circundante.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

/// Estado asociado a `HomePage`.
/// Gestiona la lógica del juego, como el movimiento del jugador, la colocación de bombas
/// y la explosión de las mismas.
class _HomePageState extends State<HomePage> {
  /// Número total de cuadrados en el grid.
  int numberOfSquares = 130;

  /// Posición actual del jugador en el grid.
  int playerPosition = 0;

  /// Posición de la bomba en el grid. Si no hay bomba, su valor es -1.
  int bombPosition = -1;

  /// Lista de posiciones que representan barreras en el grid.
  List<int> barriers = [
    11,
    13,
    15,
    17,
    18,
    31,
    33,
    35,
    37,
    38,
    51,
    53,
    55,
    57,
    58,
    71,
    73,
    75,
    77,
    78,
    91,
    93,
    95,
    97,
    98,
    111,
    113,
    115,
    117,
    118
  ];

  /// Lista de posiciones que representan cajas en el grid.
  List<int> boxes = [
    12,
    14,
    16,
    28,
    21,
    41,
    61,
    81,
    101,
    112,
    114,
    116,
    119,
    127,
    123,
    103,
    83,
    63,
    63,
    65,
    67,
    47,
    39,
    19,
    1,
    30,
    50,
    70,
    121,
    100,
    96,
    79,
    99,
    107,
    7,
    3
  ];

  /// Mueve al jugador hacia arriba en el grid.
  void moveUp() {
    setState(() {
      if (playerPosition - 10 >= 0 &&
          !barriers.contains(playerPosition - 10) &&
          !boxes.contains(playerPosition - 10)) {
        playerPosition -= 10;
      }
    });
  }

  /// Mueve al jugador hacia la izquierda en el grid.
  void moveLeft() {
    setState(() {
      if (!(playerPosition % 10 == 0) &&
          !barriers.contains(playerPosition - 1) &&
          !boxes.contains(playerPosition - 1)) {
        playerPosition -= 1;
      }
    });
  }

  /// Mueve al jugador hacia la derecha en el grid.
  void moveRight() {
    setState(() {
      if (!(playerPosition % 10 == 9) &&
          !barriers.contains(playerPosition + 1) &&
          !boxes.contains(playerPosition + 1)) {
        playerPosition += 1;
      }
    });
  }

  /// Mueve al jugador hacia abajo en el grid.
  void moveDown() {
    setState(() {
      if (playerPosition + 10 < numberOfSquares &&
          !barriers.contains(playerPosition + 10) &&
          !boxes.contains(playerPosition + 10)) {
        playerPosition += 10;
      }
    });
  }

  /// Lista de posiciones que representan el fuego de la explosión de la bomba.
  List<int> fire = [-1];

  /// Coloca una bomba en la posición actual del jugador.
  void placeBomb() {
    setState(() {
      bombPosition = playerPosition;
      fire.clear();
      Timer(Duration(milliseconds: 1000), () {
        setState(() {
          fire.add(bombPosition);
          fire.add(bombPosition - 1);
          fire.add(bombPosition + 1);
          fire.add(bombPosition - 10);
          fire.add(bombPosition + 10);
        });
        clearFire();
      });
    });
  }

  /// Limpia el fuego de la explosión después de un tiempo.
  void clearFire() {
    setState(() {
      Timer(Duration(milliseconds: 500), () {
        setState(() {
          for (int i = 0; i < fire.length; i++) {
            if (boxes.contains(fire[i])) {
              boxes.remove(fire[i]);
            }
          }
          fire.clear();
          bombPosition = -1;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          // Grid principal del juego.
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: numberOfSquares,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 10),
                  itemBuilder: (BuildContext context, int index) {
                    if (fire.contains(index)) {
                      return MyPixel(
                        innerColor: Colors.red,
                        outerColor: Colors.red[900],
                      );
                    } else if (bombPosition == index) {
                      return MyPixel(
                        innerColor: Colors.green,
                        outerColor: Colors.green[800],
                        child: Image.asset('lib/images/pokeball.png'),
                      );
                    } else if (playerPosition == index) {
                      return MyPixel(
                        innerColor: Colors.green,
                        outerColor: Colors.green[800],
                        child: Image.asset('lib/images/bomberman.png'),
                      );
                    } else if (barriers.contains(index)) {
                      return MyPixel(
                        innerColor: Colors.black,
                        outerColor: Colors.black,
                      );
                    } else if (boxes.contains(index)) {
                      return MyPixel(
                        innerColor: Colors.brown,
                        outerColor: Colors.brown[800],
                      );
                    } else {
                      return MyPixel(
                        innerColor: Colors.green,
                        outerColor: Colors.green[800],
                      );
                    }
                  }),
            ),
          ),
          // Controles del juego.
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyButton(),
                      MyButton(
                        function: moveUp,
                        color: Colors.grey,
                        child: Icon(
                          Icons.arrow_drop_up,
                          size: 70,
                        ),
                      ),
                      MyButton(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyButton(
                        function: moveLeft,
                        color: Colors.grey,
                        child: Icon(
                          Icons.arrow_left,
                          size: 70,
                        ),
                      ),
                      MyButton(
                        function: placeBomb,
                        color: Colors.grey[900],
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(
                            'lib/images/pokeball.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      MyButton(
                        function: moveRight,
                        color: Colors.grey,
                        child: Icon(
                          Icons.arrow_right,
                          size: 70,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyButton(),
                      MyButton(
                        function: moveDown,
                        color: Colors.grey,
                        child: Icon(
                          Icons.arrow_drop_down,
                          size: 70,
                        ),
                      ),
                      MyButton(),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}