import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

import '../models/user.dart';

class DB {
  //singleton
  DB._();
  static final instance = DB._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    return await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    const String sql = '''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name VARCHAR,
        age VARCHAR
      );
    ''';

    db.execute(sql);
  }

  Future saveFile() async {
    final db = await DB.instance.database;

    Map<String, dynamic> userData = {
      'name': 'Dio Silva',
      'age': '28',
    };

    int id = await db.insert('users', userData);
    print('${id} saved');
  }

  Future readAllUsers() async {
    final db = await DB.instance.database;

    String sql = 'SELECT * FROM users';

    final result = await db.rawQuery(sql);

    return result.map((json) => User.fromJson(json)).toList();
  }

  Future closeDB() async {
    final db = await DB.instance.database;
    if (db.isOpen) {
      print('DB was closed');
      db.close();
    } else {
      print('DB is not open');
    }
  }
}
