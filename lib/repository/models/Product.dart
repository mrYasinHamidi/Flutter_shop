import 'package:flutter/cupertino.dart';

class Product {
  String name;
  int id;
  String image;
  double price;
  double offPercent;
  int count;

  Product(
      {@required this.name,
      @required this.id,
      @required this.image,
      this.price,
      this.offPercent,
      this.count = 0});
}
