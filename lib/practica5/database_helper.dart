import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper5 {
  static final DatabaseHelper5 _instance = DatabaseHelper5._internal();
  factory DatabaseHelper5() => _instance;
  DatabaseHelper5._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    // **Inicializar databaseFactory en Windows**
    if (Platform.isWindows || Platform.isLinux) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    String path = "C:\\fluter\\menu1\\menu\\users_database.db"; // Ruta fija

    return await databaseFactory.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE users (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT NOT NULL,
              email TEXT NOT NULL
            )
          ''');
        },
      ),
    );
  }

  // **Métodos CRUD**
  Future<int> insertUser(String name, String email) async {
    final db = await database;
    return await db.insert('users', {'name': name, 'email': email});
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;
    return await db.query('users');
  }

  Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }
}
