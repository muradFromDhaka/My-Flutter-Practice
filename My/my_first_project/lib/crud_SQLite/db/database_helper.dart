import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../model/user.dart';

class DatabaseHelper {
  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, 'app.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            email TEXT,
            age INTEGER,
            gender TEXT,
            dob TEXT,
            isActive INTEGER,
            imagePath TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE users ADD COLUMN imagePath TEXT');
        }
      },
    );
  }

  // CREATE
  Future<int> insertUser(User user) async =>
      (await database).insert('users', user.toMap());

  // READ
  Future<List<User>> getUsers() async {
    final res = await (await database).query('users');
    return res.map((e) => User.fromMap(e)).toList();
  }

  // UPDATE
  Future<int> updateUser(User user) async => (await database).update(
    'users',
    user.toMap(),
    where: 'id=?',
    whereArgs: [user.id],
  );

  // DELETE
  Future<int> deleteUser(int id) async =>
      (await database).delete('users', where: 'id=?', whereArgs: [id]);
}

// import 'dart:io';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
// import '../model/user.dart';

// class DatabaseHelper {

//   static final DatabaseHelper instance = DatabaseHelper._internal();
//   static Database? _database;

//   DatabaseHelper._internal();

//   factory DatabaseHelper() => instance;

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDB();
//     return _database!;
//   }

//   Future<Database> _initDB() async {
//     Directory dir = await getApplicationDocumentsDirectory();
//     String path = join(dir.path, 'app.db');

//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: _createDB,
//     );
//   }

//   Future _createDB(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE users (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         name TEXT,
//         email TEXT,
//         age INTEGER,
//         gender TEXT,
//         dob TEXT,
//         isActive INTEGER
//       )
//     ''');
//   }

//   // CREATE
//   Future<int> insertUser(User user) async {
//     final db = await database;
//     return await db.insert('users', user.toMap());
//   }

//   // READ
//   Future<List<User>> getUsers() async {
//     final db = await database;
//     final res = await db.query('users');

//     return res.map((e) => User.fromMap(e)).toList();
//   }

//   // UPDATE
//   Future<int> updateUser(User user) async {
//     final db = await database;
//     return await db.update(
//       'users',
//       user.toMap(),
//       where: 'id=?',
//       whereArgs: [user.id],
//     );
//   }

//   // DELETE
//   Future<int> deleteUser(int id) async {
//     final db = await database;
//     return await db.delete('users', where: 'id=?', whereArgs: [id]);
//   }
// }
