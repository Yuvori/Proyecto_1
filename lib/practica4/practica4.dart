import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

class Practica4 extends StatefulWidget {
  const Practica4({Key? key}) : super(key: key);

  @override
  Practica4State createState() => Practica4State();
}

class Practica4State extends State<Practica4> {
  int _clicks = 0;
  int _timeLeft = 10;
  bool _gameActive = false;
  final TextEditingController _nicknameController = TextEditingController();
  List<String> _scores = [];

  /// **Ruta fija donde se guardará el archivo TXT**
  final String _filePath = "C:\\fluter\\menu1\\menu\\scores.txt";

  /// **Guarda el puntaje en el archivo TXT**
  Future<void> _saveScore() async {
    try {
      final file = File(_filePath);
      if (!file.existsSync()) {
        file.createSync(recursive: true);
      }

      await file.writeAsString(
        '${_nicknameController.text}:$_clicks\n',
        mode: FileMode.append,
      );

      await _loadScores();
    } catch (e) {
      debugPrint("Error guardando puntaje: $e");
    }
  }

  /// **Carga los puntajes desde el archivo TXT y muestra los mejores 10**
  Future<void> _loadScores() async {
    try {
      final file = File(_filePath);
      if (!file.existsSync()) return;

      final contents = await file.readAsLines();
      List<String> sortedScores = contents
        .where((line) => line.contains(':'))
        .toList();

      sortedScores.sort((a, b) {
        int scoreA = int.tryParse(a.split(':')[1]) ?? 0;
        int scoreB = int.tryParse(b.split(':')[1]) ?? 0;
        return scoreB.compareTo(scoreA);
      });

      setState(() => _scores = sortedScores.take(10).toList());
    } catch (e) {
      debugPrint("Error cargando puntajes: $e");
    }
  }

  /// **Inicia el juego con una cuenta regresiva**
  void _startGame() {
    if (_nicknameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor ingrese un alias antes de empezar.'))
      );
      return;
    }

    setState(() {
      _gameActive = true;
      _clicks = 0;
      _timeLeft = 10;
    });

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() => _timeLeft--);
      } else {
        timer.cancel();
        _saveScore();
        setState(() {
          _gameActive = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadScores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Juego de Clicks con TXT')),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/A1.png'), // Ruta de la imagen en los assets
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // **Campo de texto para ingresar el nombre**
              TextField(
                controller: _nicknameController,
                decoration: const InputDecoration(
                  labelText: 'Alias',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // **Botón para iniciar el juego**
              ElevatedButton(
                onPressed: _gameActive ? null : _startGame,
                child: const Text('Iniciar Juego'),
              ),
              const SizedBox(height: 20),

              // **Texto que muestra el tiempo restante**
              Text('Tiempo restante: $_timeLeft segundos', style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 20),

              // **Botón para contar los clicks**
              ElevatedButton(
                onPressed: _gameActive ? () => setState(() => _clicks++) : null,
                child: Text('Clicks: $_clicks', style: const TextStyle(fontSize: 24)),
              ),
              const SizedBox(height: 30),

              // **Lista de los 10 mejores puntajes**
              const Text('Mejores Puntajes:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Expanded(
                child: _scores.isEmpty
                    ? const Center(child: Text("No hay puntajes guardados"))
                    : ListView.builder(
                        itemCount: _scores.length,
                        itemBuilder: (context, index) {
                          final parts = _scores[index].split(':');
                          return ListTile(
                            title: Text(parts[0], style: TextStyle(fontSize: 18)),
                            trailing: Text(parts[1], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
