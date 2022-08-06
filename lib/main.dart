import 'package:crud_flutter/repositories/adress_respository.dart';
import 'package:crud_flutter/repositories/users_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UsersRepository()),
        ChangeNotifierProvider(create: (context) => AdressRepository()),
      ],
      child: App(),
    ),
  );
}
