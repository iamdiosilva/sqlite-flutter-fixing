import 'package:crud_flutter/repositories/users_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: ((context) => UsersRepository()),
      child: App(),
    ),
  );
}
