import 'package:flutter/material.dart';

class ValueSelector extends StatefulWidget {
  final EdgeInsetsGeometry padding;
  final Color forgroundColor;
  int value = 1;
  Function(int value) onValueChange;

  ValueSelector(
      {this.padding = const EdgeInsets.all(8),
      this.forgroundColor = Colors.deepOrange,
      this.onValueChange,
      this.value});

  @override
  _ValueSelectorState createState() => _ValueSelectorState();
}

class _ValueSelectorState extends State<ValueSelector> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                widget.value--;
                widget.onValueChange(widget.value);
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Icon(Icons.remove),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text('${widget.value}'),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                widget.value++;
                widget.onValueChange(widget.value);
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  color: widget.forgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
