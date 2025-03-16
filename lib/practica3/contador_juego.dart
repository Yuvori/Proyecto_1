import 'package:flutter/material.dart';
import 'dart:async';

class ContadorJuego extends StatefulWidget {
  const ContadorJuego({super.key});

  @override
  _ContadorJuegoState createState() => _ContadorJuegoState();
}

class _ContadorJuegoState extends State<ContadorJuego> {
  int contador = 0;
  Timer? _timer;
  int segundosRestantes = 10;
  bool isButtonEnabled = false; // Variable para habilitar/deshabilitar el botón de clic

  // Función para iniciar el juego
  void iniciarJuego() {
    setState(() {
      contador = 0;
      segundosRestantes = 10;
      isButtonEnabled = true; // Habilitamos el botón de clic cuando inicia el juego
    });

    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (segundosRestantes == 0) {
        timer.cancel();
        setState(() {
          isButtonEnabled = false; // Deshabilitamos el botón al finalizar el tiempo
        });
      } else {
        setState(() => segundosRestantes--);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$segundosRestantes segundos restantes', style: TextStyle(fontSize: 24)),
        Text('$contador clics', style: TextStyle(fontSize: 24)),
        ElevatedButton(
          onPressed: isButtonEnabled
              ? () => setState(() => contador++) // Solo permite incrementar si el botón está habilitado
              : null, // Si no está habilitado, el botón no hace nada
          child: Text('Clic'),
        ),
        ElevatedButton(
          onPressed: iniciarJuego,
          child: Text('Iniciar Juego'),
        ),
      ],
    );
  }
}
