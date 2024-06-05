import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'dart:async';

class DatabaseHelper{
  static final DatabaseHelper instance = DatabaseHelper._internal();
  factory DatabaseHelper() => instance;
  static Database? db;


  Future<Database> get database async {
    db ??= await setDb();
    return db!;
  }
  DatabaseHelper._internal();

  setDb() async{

    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}products.db';
    var dB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return dB;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE products(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        price REAL,
        description TEXT
      )
    ''');
  }
}