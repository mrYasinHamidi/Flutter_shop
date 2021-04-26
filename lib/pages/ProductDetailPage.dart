import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shop_hive/main.dart';
import 'package:shop_hive/repository/models/Product.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  final Box<Product> cacheBox = Hive.box(productCacheBoxKey);

  ProductDetailPage({this.product}) {
    cacheBox.put(product.id, product);
  }

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool _isValueSelectorVisible = false;
  int _currentIndexImage = 0;
  bool persian = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    double showingArea = height * 0.7;
    double descriptionArea = height * 0.3;

    double categoryArea = width * 0.19;
    double pictureArea = width * 0.78;
    double sideMargin = width * 0.03;

    _isValueSelectorVisible = widget.product.count > 0;

    return Directionality(
        textDirection: persian ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          body: Column(
            children: [
              SizedBox(
                height: showingArea,
                child: Row(
                  children: [
                    SizedBox(
                      width: sideMargin,
                    ),
                    SizedBox(
                      width: categoryArea,
                      child: Column(
                        children: [
                          SizedBox(
                            height: showingArea * 0.1,
                          ),
                          SizedBox(
                            height: showingArea * 0.1,
                            child: GestureDetector(
                              child: Icon(Icons.arrow_back),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          SizedBox(
                            height: showingArea * 0.7,
                            child: ColoriseListView(
                              images: [widget.product.image],
                              onImageChanged: (int imageIndex) {
                                setState(() {
                                  _currentIndexImage = imageIndex;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: showingArea,
                      width: pictureArea,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(persian ? 0 : 20),
                          bottomRight: Radius.circular(persian ? 20 : 0),
                        ),
                      ),
                      child: Center(
                        child: Image.asset(widget.product.image),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: descriptionArea,
                child: Row(
                  children: [
                    SizedBox(
                      width: sideMargin,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.name,
                            style: TextStyle(
                                fontSize: 30, color: Colors.purple[900]),
                          ),
                          Text(
                            widget.product.name,
                            style: TextStyle(height: 1),
                            maxLines: 3,
                          ),
                          Text(isPriced(widget.product)
                              ? 'Price : \$${widget.product.price.toInt()}'
                              : 'Not Exist'),
                          if (isPriced(widget.product) &&
                              isOffset(widget.product))
                            Text('Off : ${widget.product.offPercent.toInt()}%'),
                          if (isPriced(widget.product) &&
                              isOffset(widget.product))
                            Text(
                                'just for now : \$${getOffsetsPrice(widget.product)}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
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
}

class ColoriseListView extends StatefulWidget {
  final List<String> images;
  final Function(int imageIndex) onImageChanged;

  ColoriseListView({this.images, this.onImageChanged});

  @override
  _ColoriseListViewState createState() => _ColoriseListViewState();
}

class _ColoriseListViewState extends State<ColoriseListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.images.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                widget.onImageChanged(index);
              });
            },
            child: Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)]),
              child: Image.asset(widget.images[index]),
            ),
          );
        });
  }
}
