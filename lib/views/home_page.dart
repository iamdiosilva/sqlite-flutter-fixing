import 'package:crud_flutter/database/db.dart';
import 'package:crud_flutter/models/user.dart';
import 'package:crud_flutter/repositories/users_repository.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<User> users;
  late DBState state;

  @override
  void initState() {
    super.initState();
    fillUsersList();
  }

  @override
  void dispose() {
    super.dispose();
    DB.instance.closeDB();
  }

  Future fillUsersList() async {
    state = DBState.loading;
    users = await UsersRepository.readAllUsers();
    state = DBState.loaded;
  }

  _printUsers() {
    for (var i in users) {
      print('${i.id}: ${i.name} has ${i.age} yers old');
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController ageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('Save name')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Form(
              child: TextFormField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: Text('Name'),
                ),
              ),
            ),
            SizedBox(height: 20),
            Form(
              child: TextFormField(
                controller: ageController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: Text('Age'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black54)),
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => _save(nameController, ageController),
                    ),
                  ),
                ],
              ),
            ),
            (state == DBState.loaded)
                ? Expanded(
                    child: Container(
                      child: ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) => ListTile(
                          title: Text(users[index].name),
                          subtitle: Text(users[index].age),
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  _save(TextEditingController name, TextEditingController age) {
    if (name.value.text != '' && age.value.text != '') {
      UsersRepository.saveUser(name.value.text, age.value.text);
      name.clear();
      age.clear();
    }
  }
}

enum DBState {
  start,
  loading,
  loaded,
}
