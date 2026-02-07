import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelperPrac {
  static final DatabaseHelperPrac instance = DatabaseHelperPrac._internal();
  static Database? _database;

  DatabaseHelperPrac._internal();
  factory DatabaseHelperPrac() => instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, 'prac.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
create table users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL
  phone TEXT,
  address TEXT,
  age INTEGER,
  salary REAL,
  gender INTEGER,
  department TEXT,
  dob TEXT,
  createdAt TEXT,
  isActive INTEGER,
  skills TEXT,
  imagePath TEXT
) ''');
  }
}
