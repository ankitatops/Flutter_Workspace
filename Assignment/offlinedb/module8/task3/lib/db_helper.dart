import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, "notes.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE notes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            content TEXT
          )
        ''');
      },
    );
  }

  // INSERT
  Future<int> insertNote(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('notes', row);
  }

  // READ
  Future<List<Map<String, dynamic>>> getNotes() async {
    Database db = await database;
    return await db.query('notes', orderBy: 'id DESC');
  }

  // UPDATE
  Future<int> updateNote(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.update(
      'notes',
      row,
      where: 'id = ?',
      whereArgs: [row['id']],
    );
  }

  // DELETE
  Future<int> deleteNote(int id) async {
    Database db = await database;
    return await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
