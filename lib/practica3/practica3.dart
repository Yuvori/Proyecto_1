import 'package:flutter/material.dart';
import 'contador_juego.dart';

class Practica3 extends StatelessWidget {
  const Practica3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contador con Temporizador")),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/A1.png'), // Asegúrate de que la ruta de la imagen sea correcta
            fit: BoxFit.cover, // Hace que la imagen ocupe toda la pantalla
          ),
        ),
        child: Center(
          child: ContadorJuego(), // El widget ContadorJuego se mantendrá encima de la imagen
        ),
      ),
    );
  }
}
