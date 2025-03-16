import 'package:flutter/material.dart';

class Practica1 extends StatelessWidget {
  const Practica1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hola Mundo")),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/A1.png'), // Asegúrate de que la ruta de la imagen sea correcta
            fit: BoxFit.cover, // Hace que la imagen ocupe toda la pantalla
          ),
        ),
        child: Center(
          child: Text(
            "¡Hola Mundo Cruel!",
            style: TextStyle(fontSize: 24, color: Colors.white), // Color blanco para que se vea sobre el fondo
          ),
        ),
      ),
    );
  }
}

