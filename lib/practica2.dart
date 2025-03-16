import 'package:flutter/material.dart';

class Practica2 extends StatefulWidget {
  const Practica2({Key? key}) : super(key: key);

  @override
  Practica2State createState() => Practica2State();
}

class Practica2State extends State<Practica2> {
  int _contador = 0;

  void _incrementarContador() {
    setState(() {
      _contador++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contador de Clicks')),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/A1.png'), // Asegúrate de que la ruta de la imagen sea correcta
            fit: BoxFit.cover, // Hace que la imagen ocupe toda la pantalla
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Has presionado el botón:',
                style: TextStyle(fontSize: 20, color: Colors.white), // Color blanco para que se vea sobre el fondo
              ),
              Text(
                '$_contador veces',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue), // Texto azul para resaltarlo
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _incrementarContador,
                child: Text('Haz clic aquí'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
