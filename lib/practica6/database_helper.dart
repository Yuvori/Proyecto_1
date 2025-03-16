import 'package:sqflite/sqflite.dart';

class DatabaseHelper6 {
  static final DatabaseHelper6 _instance = DatabaseHelper6._internal();
  factory DatabaseHelper6() => _instance;

  static Database? _database;
  final String tableName = 'scores';

  DatabaseHelper6._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = "C:\\fluter\\menu1\\menu\\clicks_game.db"; // RUTA FIJA PARA PUNTOS
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nickname TEXT,
            clicks INTEGER
          )
        ''');
      },
    );
  }

  Future<int> insertScore(String nickname, int clicks) async {
    final db = await database;
    return await db.insert(
      tableName,
      {'nickname': nickname, 'clicks': clicks},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getTopScores() async {
    final db = await database;
    return db.query(
      tableName,
      orderBy: 'clicks DESC',
      limit: 10,
    );
  }
}
