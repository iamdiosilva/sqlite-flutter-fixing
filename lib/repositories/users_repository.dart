import 'package:flutter/cupertino.dart';

import '../database/db.dart';
import '../models/user.dart';

class UsersRepository {
  static List<User> usersList = [];

  static Future readAllUsers() async {
    final db = await DB.instance.database;

    String sql = 'SELECT * FROM users';

    final result = await db.rawQuery(sql);
    //fill usersList
    return usersList = result.map((json) => User.fromJson(json)).toList();
  }

  static Future saveUser(String name, String age) async {
    final db = await DB.instance.database;

    /*Map<String, dynamic> userData = {
      'name': 'Dio Silva',
      'age': '28',
      
    };
    int id = await db.insert('users', userData);*/

    String sql = 'INSERT INTO users (name, age) VALUES (\'$name\', \'$age\');';

    await db.rawInsert(sql);
    print('$name saved');
    readAllUsers();
  }
}
