import 'package:flutter/material.dart';
import 'game_screen.dart';

class Practica6 extends StatelessWidget {
  const Practica6({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Historial en SQLite")),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/A1.png"),  // Ruta de la imagen
            fit: BoxFit.cover,  // Asegura que la imagen cubra todo el fondo
          ),
        ),
        child: Center(child: GameScreen()),
      ),
    );
  }
}
