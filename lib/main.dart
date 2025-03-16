import 'package:flutter/material.dart';
import 'practica1.dart';
import 'practica2.dart';
import 'practica3/practica3.dart';
import 'practica4/practica4.dart';
import 'practica5/practica5.dart';
import 'practica6/practica6.dart';

void main() {
  runApp(MenuApp());
}

class MenuApp extends StatelessWidget {
  const MenuApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menú de Prácticas',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.purple,
          elevation: 8.0,
          titleTextStyle: TextStyle(
            color: Colors.cyanAccent,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pinkAccent,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(fontSize: 18),
          ),
        ),
      ),
      home: const MenuPrincipal(),
    );
  }
}

class MenuPrincipal extends StatelessWidget {
  const MenuPrincipal({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> practicas = const [
    {'titulo': 'Práctica 1: Hola Mundo', 'widget': Practica1()},
    {'titulo': 'Práctica 2: Contador de Clicks', 'widget': Practica2()},
    {'titulo': 'Práctica 3: Contador con Temporizador', 'widget': Practica3()},
    {'titulo': 'Práctica 4: Historial en TXT', 'widget': Practica4()},
    {'titulo': 'Práctica 5: SQLite Usuarios', 'widget': Practica5()},
    {'titulo': 'Práctica 6: SQLite Historial', 'widget': Practica6()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú Principal'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/A1.png'), // Usar la imagen
            fit: BoxFit.cover, // Ajusta la imagen para que cubra todo el fondo
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: practicas.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => practicas[index]['widget'],
                        ),
                      ),
                      child: Text(practicas[index]['titulo']),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
