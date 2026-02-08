import 'dart:io';

import 'package:my_first_project/crud_SQLite/model/practice.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelperPrac {
  static final DatabaseHelperPrac instance = DatabaseHelperPrac._instance();
  static Database? _database;

  DatabaseHelperPrac._instance();
  factory DatabaseHelperPrac() => instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, 'pract.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT,
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
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('AlTER TABLE practice ADD COLUMN Role TEXT');
    }
  }

  Future<int> insertUser(User user) async {
    final db = await database;
    return await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateUser(User user) async {
    final db = await database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'id=?',
      whereArgs: [user.id],
    );
  }

  Future<List<User>> getUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'users',
      orderBy: 'salary DESC',
    );
    return result.map((e) => User.fromMap(e)).toList();
  }

  Future<User> getUserById(int id) async {
    final db = await database;

    final List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
    return User.fromMap(result.first);
  }

  Future<int> deleteUser(int id) async {
    final db = await database;

    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> clearUser(User user) async {
    final db = await database;
    return await db.delete('users');
  }

  Future<void> closeDB() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
