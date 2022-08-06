import 'package:flutter/cupertino.dart';

import '../database/db.dart';
import '../models/adress.dart';

class AdressRepository extends ChangeNotifier {
  static List<Adress> adressList = [];

  AdressRepository() {
    _setupAdressTable();
    _readAllAdress();
  }

  Future _setupAdressTable() async {
    final db = await DB.instance.database;
    const String sql = '''
      CREATE TABLE IF NOT EXISTS adress (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        street TEXT,
        neighborhood TEXT,
        state TEXT
      );
    ''';
    await db.execute(sql);
  }

  Future _readAllAdress() async {
    final db = await DB.instance.database;
    const String sql = 'SELECT * FROM adress';
    final result = await db.rawQuery(sql);
    adressList = result.map((json) => Adress.fromJson(json)).toList();
    notifyListeners();
  }

  Future addAdress({required String street, required String neighborhood, required String state}) async {
    final db = await DB.instance.database;
    String sql = "INSERT INTO adress (street, neighborhood, state) VALUES ('$street', '$neighborhood', '$state');";
    await db.execute(sql);
    _refreshAdressList();
  }

  Future deleteAdress(int id) async {
    final db = await DB.instance.database;
    String sql = "DELETE FROM adress WHERE id = $id";
    await db.execute(sql);
    _refreshAdressList();
  }

  _refreshAdressList() {
    adressList.clear();
    _readAllAdress();
  }
}
