import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shop_hive/pages/LoginPage.dart';
import 'package:shop_hive/pages/MainPage.dart';
import 'package:shop_hive/repository/models/Product.dart';
import 'package:shop_hive/repository/models/ProductAdapter.dart';

const productCacheBoxKey = 'Product_cache_box';
const productCardBoxKey = 'Product_card_box';
const userBoxKey = 'user_box';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(ProductAdapter());

  await Hive.openBox<Product>(productCacheBoxKey);
  await Hive.openBox<Product>(productCardBoxKey);
  await Hive.openBox<String>(userBoxKey);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Hive.box<String>(userBoxKey).isEmpty ? '/log_in' : '/home',
      routes: {
        '/home': (context) => MainPage(),
        '/log_in': (context) => LoginPage(isLogIn: true),
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    Hive.box(productCacheBoxKey).close();
    Hive.box(productCardBoxKey).close();
    Hive.box(userBoxKey).close();
  }
}
