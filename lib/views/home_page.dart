import 'package:crud_flutter/database/db.dart';
import 'package:crud_flutter/models/user.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<User> users;

  @override
  void initState() {
    super.initState();
    fillUsersList();
  }

  @override
  void dispose() {
    DB.instance.closeDB();
  }

  Future fillUsersList() async {
    users = await DB.instance.readAllUsers();
    print('users loaded');
  }

  _printUsers() {
    for (var i in users) {
      print('${i.name} has ${i.age} yers old');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextButton(
            onPressed: () => _printUsers(),
            child: Text('Print Users'),
          ),
        ],
      ),
    );
  }
}
