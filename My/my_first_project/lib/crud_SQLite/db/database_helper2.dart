import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../model/user2.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();
  factory DatabaseHelper() => instance;

  // ==============================
  // DATABASE INSTANCE
  // ==============================
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB();
    return _database!;
  }

  // ==============================
  // INIT DATABASE
  // ==============================
  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, 'app1.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  // ==============================
  // CREATE TABLE
  // ==============================
  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT,
        phone TEXT,
        address TEXT,
        age INTEGER,
        salary REAL,
        gender TEXT,
        department TEXT,
        dob TEXT,
        createdAt TEXT,
        isActive INTEGER,
        skills TEXT,
        imagePath TEXT
      )
    ''');
  }

  // ==============================
  // UPGRADE TABLE
  // ==============================
  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE users ADD COLUMN phone TEXT');
      await db.execute('ALTER TABLE users ADD COLUMN address TEXT');
    }
  }

  // ==============================
  // CREATE
  // ==============================
  Future<int> insertUser(User user) async {
    final db = await database;
    return await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // ==============================
  // READ (ALL)
  // ==============================
  Future<List<User>> getUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'users',
      orderBy: 'createdAt DESC',
    );

    return result.map((e) => User.fromMap(e)).toList();
  }

  // ==============================
  // READ (BY ID)
  // ==============================
  Future<User?> getUserById(int id) async {
    final db = await database;
    final result = await db.query('users', where: 'id = ?', whereArgs: [id]);

    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    }
    return null;
  }

  // ==============================
  // UPDATE
  // ==============================
  Future<int> updateUser(User user) async {
    final db = await database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  // ==============================
  // DELETE
  // ==============================
  Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  // ==============================
  // DELETE ALL (OPTIONAL)
  // ==============================
  Future<void> clearUsers() async {
    final db = await database;
    await db.delete('users');
  }

  // ==============================
  // CLOSE DATABASE
  // ==============================
  Future<void> closeDB() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
