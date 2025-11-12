import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static const _databaseName = "product_db.db";
  static const _databaseVersion = 1;
  static const table = 'products';

  static const columnId = '_id';
  static const columnImage = 'image';
  static const columnCompany = 'company';
  static const columnModel = 'model';
  static const columnPrice = 'price';
  static const columnDiscount = 'discount';
  static const columnFinalPrice = 'finalPrice';

  DbHelper._privateConstructor();
  static final DbHelper instance = DbHelper._privateConstructor();
  static Database? _database;

  Future<Database> get database async =>
      _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnImage TEXT,
        $columnCompany TEXT NOT NULL,
        $columnModel TEXT NOT NULL,
        $columnPrice REAL NOT NULL,
        $columnDiscount REAL NOT NULL,
        $columnFinalPrice REAL NOT NULL
      )
    ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
