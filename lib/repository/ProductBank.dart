import 'package:hive/hive.dart';
import 'package:shop_hive/main.dart';
import 'package:shop_hive/repository/models/Product.dart';

class ProductBank {
  List<Product> _products = [
    Product(name: "پودر", id: 4839, image: "images/product-image.jpg"),
    Product(name: "پودر كيك ", id: 4840, image: "images/product-image.jpg"),
    Product(
        name: "رشد مقدار 600 گرم",
        id: 4841,
        image: "images/product-image.jpg",
        price: 12800.0,
        offPercent: 10.0),
    Product(
        name: "پودر خامه كيك و شيريني با طعم ",
        id: 4842,
        image: "images/product-image.jpg"),
    Product(name: "پودر كيك  گرم", id: 4843, image: "images/product-image.jpg"),
    Product(
        name: "پودر كيك رد 600 گرم",
        id: 4844,
        image: "images/product-image.jpg",
        price: 12800.0,
        offPercent: 10.0),
    Product(
        name: "پودر خامه 200 گرم", id: 4845, image: "images/product-image.jpg"),
    Product(
        name: "پودر كيك رد ولوت رشد مقدار 600 گرم",
        id: 4846,
        image: "images/product-image.jpg"),
    Product(
        name: " ولوت رشد مقدار 600 گرم",
        id: 4847,
        image: "images/product-image.jpg",
        price: 12800.0,
        offPercent: 10.0),
    Product(
        name: "پودر وانيل فلورا - 200 گرم",
        id: 4848,
        image: "images/product-image.jpg"),
    Product(
        name: "پودر كيك رد و گرم", id: 4849, image: "images/product-image.jpg"),
    Product(
        name: "پودر كيك رد 600 گرم",
        id: 4850,
        image: "images/product-image.jpg",
        price: 12800.0,
        offPercent: 10.0),
    Product(
        name: "پودر خامه كيك 200 گرم",
        id: 4851,
        image: "images/product-image.jpg"),
    Product(
        name: "پودر كيك رد ولوت  600 گرم",
        id: 4852,
        image: "images/product-image.jpg"),
    Product(
        name: "پومقدار 600 گرم",
        id: 4853,
        image: "images/product-image.jpg",
        price: 12800.0,
        offPercent: 10.0),
    Product(
        name: "پودر خامه كيك و شيريني با طعم وانيل فلورا - 200 گرم",
        id: 4854,
        image: "images/product-image.jpg"),
    Product(
        name: "پودر كيك رد ولوت رشد مقدار 600 گرم",
        id: 4855,
        image: "images/product-image.jpg"),
  ];
  Box<Product> box = Hive.box<Product>(productCardBoxKey);

  List<Product> getProducts() {
    for (var i = 0; i < _products.length; i++) {
      if (box.get(_products[i].id) != null) {
        _products[i] = box.get(_products[i].id);
      }
    }
    return _products;
  }
}
