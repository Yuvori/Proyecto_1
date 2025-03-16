import 'package:flutter/material.dart';
import 'dart:async';
import 'database_helper.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int _clicks = 0;
  int _timeLeft = 10;
  bool _gameActive = false;
  final TextEditingController _nicknameController = TextEditingController();
  List<Map<String, dynamic>> _scores = [];
  final DatabaseHelper6 _dbHelper = DatabaseHelper6(); // INSTANCIA CORRECTA

  void _startGame() {
    if (_nicknameController.text.isEmpty) return;

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
        setState(() => _gameActive = false);
      }
    });
  }

  Future<void> _saveScore() async {
    try {
      await _dbHelper.insertScore(
        _nicknameController.text,
        _clicks,
      );
      await _loadScores();
    } catch (e) {
      debugPrint("Error guardando puntaje: $e");
    }
  }

  Future<void> _loadScores() async {
    try {
      final scores = await _dbHelper.getTopScores();
      setState(() => _scores = scores);
    } catch (e) {
      debugPrint("Error cargando puntajes: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _loadScores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Juego de Clicks')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _nicknameController,
              decoration: const InputDecoration(
                labelText: 'Nickname',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _gameActive ? null : _startGame,
              child: const Text('Iniciar Juego'),
            ),
            const SizedBox(height: 20),
            Text(
              'Tiempo restante: $_timeLeft segundos',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _gameActive ? () => setState(() => _clicks++) : null,
              child: Text(
                'Clicks: $_clicks',
                style: const TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Mejores Puntajes:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _scores.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(_scores[index]['nickname']),
                  trailing: Text(_scores[index]['clicks'].toString()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
