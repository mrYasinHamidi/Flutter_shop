import 'package:flutter/material.dart';
import 'package:shop_hive/pages/HomePage.dart';
import 'package:shop_hive/pages/LoginPage.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 20),
              color: Colors.orange,
              child: TabBar(
                indicatorColor: Colors.white,
                tabs: [
                  Tab(text: 'Home', icon: Icon(Icons.home)),
                  Tab(text: 'Profile', icon: Icon(Icons.person)),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  HomePage(),
                  LoginPage(isLogIn: false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
