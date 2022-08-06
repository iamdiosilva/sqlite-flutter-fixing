import 'package:crud_flutter/views/users_page.dart';
import 'package:flutter/cupertino.dart';

import '../database/db.dart';
import '../models/user.dart';

class UsersRepository extends ChangeNotifier {
  static List<User> usersList = [];

  UsersRepository() {
    _readAllUsers();
  }

  Future _readAllUsers() async {
    final db = await DB.instance.database;
    String sql = 'SELECT * FROM users';
    final result = await db.rawQuery(sql);
    //fill usersList
    usersList = result.map((json) => User.fromJson(json)).toList();
    notifyListeners();
  }

  Future updateUser(int id, String name, String age) async {
    final db = await DB.instance.database;
    String sql = "UPDATE users SET name = '$name', age = '$age' WHERE id = $id";
    await db.execute(sql);
    _refreshList();
  }

  Future deleteUser(int id) async {
    final db = await DB.instance.database;
    String sql = "DELETE FROM users WHERE id = $id";
    await db.execute(sql);
    _refreshList();
  }

  Future saveUser(String name, String age) async {
    final db = await DB.instance.database;
    /*Map<String, dynamic> userData = {
      'name': 'Dio Silva',
      'age': '28',
      
    };
    int id = await db.insert('users', userData);*/
    String sql = 'INSERT INTO users (name, age) VALUES (\'$name\', \'$age\');';
    await db.rawInsert(sql);
    _refreshList();
  }

  _refreshList() {
    usersList.clear();
    _readAllUsers();
  }
}
