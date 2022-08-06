import 'package:crud_flutter/database/db.dart';
import 'package:crud_flutter/models/user.dart';
import 'package:crud_flutter/repositories/users_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late UsersRepository usersRep;
  late TextEditingController nameController;
  late TextEditingController ageController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    ageController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    DB.instance.closeDB();
  }

  @override
  Widget build(BuildContext context) {
    usersRep = context.watch<UsersRepository>();

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
                keyboardType: TextInputType.number,
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
            (UsersRepository.usersList.isNotEmpty)
                ? Expanded(
                    child: Container(
                      child: ListView.builder(
                        itemCount: UsersRepository.usersList.length,
                        itemBuilder: (context, index) => ListTile(
                          title: Text(UsersRepository.usersList[index].name),
                          subtitle: Text(UsersRepository.usersList[index].age),
                          leading: Text(UsersRepository.usersList[index].id.toString()),
                          trailing: Wrap(
                            children: [
                              IconButton(
                                onPressed: () => _updateUser(UsersRepository.usersList[index]),
                                icon: Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () {
                                  usersRep.deleteUser(UsersRepository.usersList[index].id!);
                                },
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          ),
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
      usersRep.saveUser(name.value.text, age.value.text);
      name.clear();
      age.clear();
    }
  }

  _updateUser(User user) {
    TextEditingController nameController = TextEditingController();
    TextEditingController ageController = TextEditingController();

    final usersRep = context.read<UsersRepository>();

    nameController.text = user.name;
    ageController.text = user.age;

    AlertDialog dialog = AlertDialog(
      title: Text('Edit User'),
      content: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 150),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                label: Text('Name'),
              ),
              controller: nameController,
            ),
            TextFormField(
              decoration: InputDecoration(
                label: Text('Age'),
              ),
              controller: ageController,
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (user.name != nameController.value.text || user.age != ageController.value.text) {
              usersRep.updateUser(user.id!, nameController.value.text, ageController.value.text);
              Navigator.pop(context);
            }
          },
          child: Text('Save'),
        ),
      ],
    );
    showDialog(context: context, builder: (context) => dialog);
  }
}
