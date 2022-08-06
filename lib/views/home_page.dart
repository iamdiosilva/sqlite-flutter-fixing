import 'package:crud_flutter/views/adress_page.dart';
import 'package:crud_flutter/views/users_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  late PageController pController;

  @override
  void initState() {
    super.initState();
    pController = PageController(initialPage: currentPage);
  }

  _setCurrentPage(int page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pController,
        onPageChanged: (value) => _setCurrentPage(value),
        children: [
          UsersPage(),
          AdressPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (pageIndex) {
          pController.animateToPage(pageIndex, duration: Duration(milliseconds: 300), curve: Curves.ease);
        },
        currentIndex: currentPage,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.account_box_outlined), label: 'Users'),
          BottomNavigationBarItem(icon: Icon(Icons.book_online), label: 'Adress'),
        ],
      ),
    );
  }
}
