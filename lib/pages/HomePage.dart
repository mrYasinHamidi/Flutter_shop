import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shop_hive/components/ValueSelector.dart';
import 'package:shop_hive/main.dart';
import 'package:shop_hive/pages/ProductDetailPage.dart';
import 'package:shop_hive/repository/ProductBank.dart';
import 'package:shop_hive/repository/models/Product.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _onSearch = false;
  Box<Product> pCache = Hive.box<Product>(productCacheBoxKey);
  Box<Product> pCard = Hive.box<Product>(productCardBoxKey);
  ProductBank bank = ProductBank();
  List<Product> items = [];
  List<Product> searchResult = [];
  String _searchText = '';
  bool _onCache = false;

  @override
  Widget build(BuildContext context) {
    items = getItemList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: EdgeInsets.all(4),
          height: 130,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue[800],
                Colors.blue[200],
              ],
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  Hive.box<String>(userBoxKey).get('0'),
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                Container(
                  width: 200,
                  height: 30,
                  margin: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue[100],
                        Colors.blue[200],
                      ],
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: TextField(
                    // textAlign: TextAlign.center,
                    // textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      icon: Icon(Icons.search),
                      hintText: 'find your future',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      if (value.trim().isNotEmpty)
                        setState(() {
                          _onCache = false;
                          _searchText = value;
                          _onSearch = true;
                        });
                      else
                        setState(() {
                          _onSearch = false;
                        });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Container(
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(blurRadius: 4),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: Image.asset(items[index].image),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(items[index].name),
                                  Text(isPriced(items[index])
                                      ? 'Price : \$${items[index].price.toInt()}'
                                      : 'Not Exist'),
                                  if (isPriced(items[index]) &&
                                      isOffset(items[index]))
                                    Text(
                                        'Off : ${items[index].offPercent.toInt()}%'),
                                  if (isPriced(items[index]) &&
                                      isOffset(items[index]))
                                    Text(
                                        'just for now : \$${getOffsetsPrice(items[index])}'),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: _onCache,
                              child: GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.black54,
                                  ),
                                ),
                                onTap: () {
                                  pCache.delete(items[index].id);
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                        if (isPriced(items[index]))
                          items[index].count > 0
                              ? Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: ValueSelector(
                                    value: items[index].count,
                                    onValueChange: (int value) {
                                      items[index].count = value;
                                      pCard.put(items[index].id, items[index]);
                                      if (value < 1) setState(() {});
                                    },
                                  ),
                                )
                              : Positioned(
                                  bottom: 8,
                                  right: 6,
                                  child: GestureDetector(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red,
                                      ),
                                      child: Icon(Icons.add),
                                    ),
                                    onTap: () {
                                      pCard.put(items[index].id, items[index]);
                                      setState(() {
                                        items[index].count = 1;
                                      });
                                    },
                                  ),
                                ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(
                          product: items[index],
                        ),
                      ),
                    );
                  },
                );
              }),
        ),
      ],
    );
  }

  double getOffsetsPrice(Product product) {
    if (isPriced(product))
      return (product.price * (100 - product.offPercent)) / 100;
  }

  bool isPriced(Product product) {
    if (product.price == null)
      return false;
    else
      return true;
  }

  bool isOffset(Product product) {
    if (product.offPercent == null)
      return false;
    else
      return true;
  }

  List<Product> getItemList() {
    if (_onSearch) return search(bank.getProducts(), _searchText);

    _onCache = pCache.isNotEmpty;
    if (pCache.isEmpty) {
      return bank.getProducts();
    } else
      return pCache.values.toList();
  }

  List<Product> search(List<Product> items, String text) {
    List<Product> result = [];
    items.forEach((element) {
      if (element.name.contains(text)) result.add(element);
    });
    print(result.length);
    return result;
  }
}
