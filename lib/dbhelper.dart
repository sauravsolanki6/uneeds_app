import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'app_data.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Data (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        value TEXT
      )
    ''');
  }

  Future<int> insertValue(String value) async {
    Database db = await database;
    return await db.insert('Data', {'value': value});
  }

  Future<int> updateValue(int id, String newValue) async {
    Database db = await database;
    return await db.update(
      'Data',
      {'value': newValue},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Method to get a specific value by ID
  Future<String?> getValueById(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'Data',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return result.first['value'];
    } else {
      return null;
    }
  }
}
